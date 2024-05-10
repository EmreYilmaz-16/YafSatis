
<cfset ShipService=createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>
<cfset _MachineArr=ShipService.listMachines(attributes.WESSEL_ID)>
<cfset MachineArr=deserializeJSON(_MachineArr)>
<cfset _Ship=ShipService.GetShips(ShipId=attributes.WESSEL_ID)>
<cfset Ship=deserializeJSON(_Ship)>

<cf_box title="#Ship[1].SHIP_NAME# - Makina Ekle" scroll="1" collapsable="1" resize="1" popup_box="1">
    <cfdump var="#MachineArr#">
    <cfloop array="#MachineArr#" item="it" index="x">

    </cfloop>


</cf_box>