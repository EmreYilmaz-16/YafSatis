<cf_box>
<cfif attributes.ListType  eq "getWessels">
    <cfinclude template="getWessels.cfm">
</cfif>
<cfif attributes.ListType  eq "catProps">
    <cfinclude template="getCatProps.cfm">
</cfif>
</cf_box>