# addMultipleInstances

“addMultipleInstances” is a user interface enhancement for the Opentext Website Management Server 
allowing to create and connect multiple instances of a content class at the same time.

© Stefan Buchali, UDG United Digital Group, www.udg.de

This is third party software. The author is not affiliated in any manner with Open Text Corporation.


## Installation

### Installation on the server

Copy the "addMultipleInstances" folder into the "plugins" folder of your CMS installation.  
It is not necessary to import the plugin to the Server Manager.

### Preparing the templates

In your master page template(s) (every template containing the `<head>` tag), include 
the following code within a `<!IoRangeRedDotMode>` section:

```html
<script type="text/javascript" src="/cms/plugins/addMultipleInstances/addMultipleInstances.js"></script>
```
 
### Preparing the elements

In every template where connecting multiple instances should be available for one or 
more structure elements (lists or containers, no links of course), include this code for 
every such element within a `<!IoRangeRedDotEditOnly>` section: 
 
```html
<form action="/cms/plugins/addMultipleInstances/add_multiple_dlg.asp" target="pluginWin" method="post" onsubmit="openAddMultipleWin()"> 
  <input type="hidden" name="selected_ck" value="" />
  <input type="hidden" name="selected_structure_element" value="" />
  <!-- optional elements -->
  <input type="hidden" name="pluginTitle" value="" />
  <input type="hidden" name="eltDescription" value="" />
  <input type="hidden" name="max_multiples_at_once" value="" />
  <input type="hidden" name="number_of_multiples" value="" />
  <!-- Session Data -->
  <input type="hidden" name="Sessionkey" value="{corresponding info element}" />
  <input type="hidden" name="LoginGUID" value="{corresponding info element}" />
  <input type="hidden" name="PageGUID" value="{corresponding info element}" />
  <input type="image" src="/CMS/WebClient/App_Themes/Standard/Images/Icons/icon_reddot_multilink.png" />Add multiple
</form>
```

### Parameters 
The obligatory parameter "selected_ck" contains the GUID of the content class of the 
instances that are to be created and connected.

The obligatory parameter "selected_structure_element" contains the template element 
name of the structure element where the instances will be added.

The optional parameter "pluginTitle" contains the optional window title of the dialog box.

The optional parameter "eltDescription" contains an optional element description.

The optional parameter "max_multiples_at_once" contains the maximum selectable 
number of instances, default value is 10.

The optional parameter "number_of_multiples" preselects one of the numbers, default 
is 0 (none preselected). 

## How to use 

By clicking the submit button (shown as a Multilink RedDot), a dialog box opens 
showing a dropdown list with the number of instances to be created and connected 
(from 1 to the given maximum value in parameter "max_multiples_at_once").

After clicking the OK button, the selected number of instances will be created and 
connected.

Please wait until the dialog box closes and the page reloads. 

## License and exclusion of liability

This software is licensed under a [Creative Commons GNU General Public License](http://creativecommons.org/licenses/GPL/2.0/). Some rights reserved.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but **without any warranty**; without even the implied warranty of **merchantability** or **fitness for a particular purpose**. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with addMultipleInstances. If not, see http://www.gnu.org/licenses.

The GNU General Public License is a Free Software license. Like any Free Software license, it grants to you the four following freedoms:

0. The freedom to run the program for any purpose.
1. The freedom to study how the program works and adapt it to your needs.
2. The freedom to redistribute copies so you can help your neighbor.
3. The freedom to improve the program and release your improvements to the public, so that the whole community benefits.

You may exercise the freedoms specified here provided that you comply with the express conditions of this license. The principal conditions are:

- You must conspicuously and appropriately publish on each copy distributed an appropriate copyright notice and disclaimer of warranty and keep intact all the notices that refer to this License and to the absence of any warranty; and give any other recipients of the Program a copy of the GNU General Public License along with the Program. Any translation of the GNU General Public License must be accompanied by the GNU General Public License.
- If you modify your copy or copies of the program or any portion of it, or develop a program based upon it, you may distribute the resulting work provided you do so under the GNU General Public License. Any translation of the GNU General Public License must be accompanied by the GNU General Public License.
- If you copy or distribute the program, you must accompany it with the complete corresponding machine-readable source code or with a written offer, valid for at least three years, to furnish the complete corresponding machine-readable source code.

Any of the above conditions can be waived if you get permission from the copyright holder.
