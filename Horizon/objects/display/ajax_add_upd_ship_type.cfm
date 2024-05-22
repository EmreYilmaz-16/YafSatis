<cfparam name="attributes.SHIP_TYPE_ID" default="">
<cfset ShipService = createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>

<cfif len(attributes.SHIP_TYPE_ID)>
<cfset ShipTypes=ShipService.getShipTypes(attributes.SHIP_TYPE_ID)>
<cfelse>
    <cfset ShipTypes.SHIP_TYPE="">
    <cfset ShipTypes.SHIP_TYPE_ID="">
</cfif>
<cfset ShipType=deserializeJSON(ShipTypes)[1]>

<div class="form-group">
    <label>Gemi Tipi</label>
    <input type="text" name="SHIP_TYPE" value="">
    
</div>