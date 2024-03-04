
<cfif attributes.ListType  eq "getWessels">
    <cf_box>
    <cfinclude template="getWessels.cfm">
</cf_box>
</cfif>
<cfif attributes.ListType  eq "catProps">
    <cfinclude template="getCatProps.cfm">
</cfif>
