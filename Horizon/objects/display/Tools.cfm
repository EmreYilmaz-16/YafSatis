
<cfif attributes.ListType  eq "getWessels">
    <cf_box>
    <cfinclude template="getWessels.cfm">
</cf_box>

<cfelseif attributes.ListType  eq "catProps">
    <cfinclude template="getCatProps.cfm">
<cfelseif attributes.ListType  eq "catProps2">
    <cfinclude template="getCatProps_fs.cfm">
<cfelseif attributes.ListType  eq "getCollation">
    <cfinclude template="getProductCollation.cfm">

<cfelseif attributes.ListType  eq "OfferStatus">
    <cfinclude template="OfferStatus_changer.cfm">

<cfelseif attributes.ListType  eq "ShowProductProperties">
    <cfinclude template="ShowProductProperties.cfm">

<cfelseif attributes.ListType  eq "addupdshiptype">
    <cfinclude template="ajax_add_upd_ship_type.cfm">

<cfelseif attributes.ListType  eq "list_ship_types">
    <cfinclude template="ship_type_list.cfm">
<cfelseif attributes.ListType  eq "add_purchase_price_marj">
    <cfinclude template="../form/add_purchase_marj.cfm">
</cfif>
