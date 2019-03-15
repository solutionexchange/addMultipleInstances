<%
'Copyright (C) Stefan Buchali, UDG United Digital Group, www.udg.de
'
'This software is licensed under a
'Creative Commons GNU General Public License (http://creativecommons.org/licenses/GPL/2.0/)
'Some rights reserved.
'
'You should have received a copy of the GNU General Public License
'along with addMultipleInstances.  If not, see http://www.gnu.org/licenses/.

Server.ScriptTimeOut = 300

selected_structure_element = request.form("selected_structure_element")
number_of_multiples = request.form("number_of_multiples")
selected_ck = request.form("selected_ck")

'get session information
SessionKey=request.form("SessionKey")
LoginGUID=request.form("RedakteurLoginGUID")
PageGUID = request.form("AktuelleSeiteGUID")


' Send and Process XML
function sendXML (XMLString, bDebug)
	' RedDot Object fuer RQL-Zugriffe anlegen
	set objData = Server.CreateObject("OTWSMS.AspLayer.PageData")

	sendXML = objData.ServerExecuteXml(XMLString, sErrors)
	if sErrors <> "" then
		RdStartpageError = "Errors occured: " & sErrors & chr(13)
	else
		if bDebug then
			RdStartpageError = RdStartpageError & "<div style=""border:1px solid #000; background:#fff; font:11px courier; text-align:left;""><h5>sendXML Result:</h5><p>" & Server.HTMLEncode(sendXML) & "</p></div>"
		end if
	end if
	set objData = nothing
end function

' Get standard (extended=false) or extended (extended=true) informations of a page
function loadPage(pageGuid,extended,LgGUID,sKEY)
	extendedinfo=""
	if extended then extendedinfo=" option=""extendedinfo""" end if
	xmlSendDoc=	"<IODATA loginguid=""" & LgGUID & """ sessionkey=""" & sKEY & """>"&_
					"<PAGE action=""load"" guid="""&pageGuid&""""&extendedinfo&"/>"&_
				"</IODATA>"
	loadPage = sendXML (xmlSendDoc, 0)
end function

' Get all link elements of a page
function getLinksOfPage(pageGuid,LgGUID,sKEY)
	xmlSendDoc=	"<IODATA loginguid=""" & LgGUID & """ sessionkey=""" & sKEY & """>"&_
					"<PAGE guid=""" & pageGuid & """>"&_
						"<LINKS action=""load"" />"&_
					"</PAGE>"&_
				"</IODATA>"
	getLinksOfPage = sendXML (xmlSendDoc, 0)
end function

'Creates a new page of given content class, with the given headline, and assigns it to the given link
function createNewPage(linkGuid,templateGuid,pgHeadline,LgGUID,sKEY)
	xmlSendDoc=	"<IODATA loginguid=""" & LgGUID & """ sessionkey=""" & sKEY & """>"&_
					"<LINK action=""assign"" guid=""" & linkGuid & """>"&_
						"<PAGE action=""addnew"" templateguid="""&templateGuid&""" headline="""&pgHeadline&""" />"&_
					"</LINK>"&_
				"</IODATA>"
	createNewPage = sendXML (xmlSendDoc, 0)
end function



set XMLDoc = Server.CreateObject("MSXML2.DOMDocument")
XMLDoc.async = false
XMLDoc.validateOnParse = false

Dim xmlSendDoc
Dim ServerAnswer

ServerAnswer = loadPage(PageGUID,false,LoginGUID,SessionKey)
XMLDoc.loadXML(ServerAnswer)
headline = XMLDoc.selectsinglenode("//@headline").text

ServerAnswer = getLinksOfPage(PageGUID,LoginGUID,SessionKey)
XMLDoc.loadXML(ServerAnswer)
structure_element = XMLDoc.selectsinglenode("//@guid[../@name='" & selected_structure_element & "']").text

for i = number_of_multiples to 1 step -1
	ServerAnswer = createNewPage(structure_element,selected_ck,headline&" "&i,LoginGUID,SessionKey)
next

set XMLDoc = nothing
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>addMultipleInstances</title>
</head>
<body onload="top.opener.location.reload();top.close()">
</body>
</html>