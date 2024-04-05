
<cfif attributes.ListType  eq "getWessels">
    <cf_box>
    <cfinclude template="getWessels.cfm">
</cf_box>

<cfelseif attributes.ListType  eq "catProps">
    <cfinclude template="getCatProps.cfm">

<cfelseif attributes.ListType  eq "getCollation">
    <cfinclude template="getProductCollation.cfm">

<cfelseif attributes.ListType  eq "OfferStatus">
    <cfinclude template="OfferStatus_changer.cfm">

<cfelseif attributes.ListType  eq "ShowProductProperties">
    <cfinclude template="ShowProductProperties.cfm">
</cfif>
