
<cfset ShipService=createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>
<cfset _MachineArr=ShipService.listMachines(attributes.WESSEL_ID)>
<cfset MachineArr=deserializeJSON(_MachineArr)>
<cfset _Ship=ShipService.GetShips(ShipId=attributes.WESSEL_ID)>
<cfset Ship=deserializeJSON(_Ship)>
<cfset _Amachine=ShipService.GetAMachine(arguments.SM_ID)>
<cfset Amachine=deserializeJSON(_Amachine)>


<cf_box title="Add Machine Properties" scroll="1" collapsable="1" resize="1" popup_box="1">
    <cfdump var="#Amachine#">
<div id="PRPPPP">
    <cfset attributes.PRODUCT_CATID=Amachine.PRODUCT_CATID>
<cfinclude template="/AddOns/YafSatis/Horizon/objects/display/getCatProps.cfm">
</div>
</cf_box>


<script>
 
</script>