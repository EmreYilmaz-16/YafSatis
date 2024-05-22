<cfparam name="attributes.SHIP_TYPE_ID" default="">
<cfset ShipService = createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>

<cfif len(attributes.SHIP_TYPE_ID)>
<cfset ShipTypes=ShipService.getShipTypes(attributes.SHIP_TYPE_ID)>
<cfset ShipType=deserializeJSON(ShipTypes)[1]>
<cfelse>
    <cfset ShipTypes.SHIP_TYPE="">
    <cfset ShipTypes.SHIP_TYPE_ID="">
    <cfset ShipType=ShipTypes>
</cfif>


<div class="form-group">
    <label>Gemi Tipi</label>
    <input type="text" name="SHIP_TYPE" id="SHIP_TYPE" value="<cfoutput>#ShipType.SHIP_TYPE#</cfoutput>" >
    <input type="hidden" name="SHIP_TYPE_ID" id="SHIP_TYPE_ID" value="<cfoutput>#ShipType.SHIP_TYPE_ID#</cfoutput>" >
</div>
<div class="form-group">
    <div style="display:flex">
        <a href="javascript://" onclick="DelShipType()" class="ui-wrk-btn ui-wrk-btn-red  ui-wrk-btn-addon-left"><i class="fa fa-repeat"></i>Sil</a>
        <a href="javascript://" onclick="SaveShipType()" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left"><i class="fa fa-repeat"></i>Kaydet</a>
    </div>
</div>