<% 
'Copyright (C) Stefan Buchali, UDG United Digital Group, www.udg.de
'
'This software is licensed under a
'Creative Commons GNU General Public License (http://creativecommons.org/licenses/GPL/2.0/)
'Some rights reserved.
'
'You should have received a copy of the GNU General Public License
'along with addMultipleInstances.  If not, see http://www.gnu.org/licenses/.

Response.ContentType = "text/html"
Response.Charset = "utf-8"

'get session information
SessionKey=request.form("Sessionkey")
RedakteurLoginGUID=request.form("LoginGUID")
AktuelleSeiteGUID = request.form("PageGUID")

if SessionKey="" then
	SessionKey=Session("SessionKey")
end if
if RedakteurLoginGUID="" then
	RedakteurLoginGUID=Session("LoginGUID")
end if
if AktuelleSeiteGUID="" then
	AktuelleSeiteGUID = Session("PageGUID")
end if

'get the required parameters
selected_ck = request.form("selected_ck")
selected_structure_element = request.form("selected_structure_element")

'get the optional parameters
pluginTitle=request.form("pluginTitle")
eltDescription=request.form("eltDescription")
max_multiples_at_once=request.form("max_multiples_at_once")
number_of_multiples=request.form("number_of_multiples")

'set the optional parameters to default, if empty
if pluginTitle="" then pluginTitle="Mehrere Instanzen erstellen und verknüpfen" end if
if eltDescription="" then eltDescription="Anzahl" end if
if max_multiples_at_once="" then
	max_multiples_at_once=10
else
	max_multiples_at_once=CInt(max_multiples_at_once)
end if
if number_of_multiples="" then
	number_of_multiples=0
else
	number_of_multiples=CInt(number_of_multiples)
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="../../stylesheets/ioStyleSheet.css" />
<style type="text/css">
	div#messageDiv {
		color: #ff0000;
		font-weight: bold;
	}
	button {
		border: 1px solid black;
		background: #EEEEEE;
	}
</style>
<script type="text/javascript">
var submitOK=true;

function submitForm() {
	if(submitOK) {
		submitOK=false;
		document.getElementById("messageDiv").innerText='Bitte warten...';
		document.getElementById("btn1").disabled=true;
		document.getElementById("btn2").disabled=true;
		document.AddMultipleForm.submit();
	}
}
</script>
<title><%=pluginTitle %></title>
</head>
<body link="navy" alink="navy" vlink="navy" bgcolor="#ffffff" background="../../icons/back5.gif">
<form name="AddMultipleForm" method="post" action="add_multiple_do.asp">
<input type="hidden" name="selected_ck" value="<%=selected_ck %>" />
<input type="hidden" name="selected_structure_element" value="<%=selected_structure_element %>" />
<input type="hidden" name="SessionKey" value="<%= SessionKey %>" />
<input type="hidden" name="RedakteurLoginGUID" value="<%= RedakteurLoginGUID %>" />
<input type="hidden" name="AktuelleSeiteGUID" value="<%= AktuelleSeiteGUID %>" />
<table class="tdgrey" border="0" width="400" align="center" cellspacing="0" cellpadding="3">
<tr>
<td width="100%">
	<table class="tdgreylight" border="0" width="100%" cellspacing="0" cellpadding="1">
	<tr>
	<td width="100%" align="left" valign="top" height="50">
		<table border="0" width="100%">
		<tr><td class="titlebar" width="100%"><%=pluginTitle %></td></tr>
		</table>
	</td>
	</tr>
	<tr>
	<td width="100%" align="left" valign="top" height="80">
		<table cellspacing="0" cellpadding="0" border="0" width="100%">
		<tr>
		<td width="25"><img src="../../icons/transparent.gif" width="25" height="1" border="0" alt=""></td>
		<td align="left" valign="top" class="label" width="100%"><%= eltDescription %></td>
		<td width="25"><img src="../../icons/transparent.gif" width="25" height="1" border="0" alt=""></td>
		</tr>
		<tr>
		<td height="5" colspan="3"></td>
		</tr>
		<tr>
		<td></td>
		<td><select size=1 style="width:150px" name="number_of_multiples">
<% for i=1 to max_multiples_at_once %>
			 <option value="<%=i%>"<% if i=number_of_multiples then %> selected="selected"<% end if %>><%=i%></option>
<% next %>
		</select></td>
		<td></td>
		</tr>
		<tr>
		<td height="15" colspan="3"></td>
		</tr>
		<tr>
		<td width="25"><img src="../../icons/transparent.gif" width="25" height="1" border="0" alt=""></td>
		<td align="left" valign="top" class="label" width="100%"><div id="messageDiv">&nbsp;</div></td>
		<td width="25"><img src="../../icons/transparent.gif" width="25" height="1" border="0" alt=""></td>
		</tr>
		<tr>
		<td height="20" colspan="3"><img src="../../icons/transparent.gif" width="1" height="20" border="0" alt=""></td>
		</tr>
		<tr>
		<td width="25"><img src="../../icons/transparent.gif" width="25" height="1" border="0" alt=""></td>
		<td align="right" valign="top"><button id="btn1" type="button" onclick="submitForm()">OK</button>&nbsp;&nbsp;<button id="btn2" type="button" onclick="self.close()">Abbrechen</button></td>
		<td width="25"><img src="../../icons/transparent.gif" width="25" height="1" border="0" alt=""></td>
		</tr>
		<tr>
		<td height="15" colspan="3"></td>
		</tr>
		</table>
	</td>
	</tr>
	</table>
</td>
</tr>
</table>
</form>

</body>
</html>