<cfdump var="#attributes#">

<cfloop from="1" to="#attributes.ROW_COUNT#" index="i">
    <cfset WRK_ROW_ID=evaluate("attributes.WrkRowId_#i#")>
    <cfset SALE_PRICE=evaluate("attributes.SalePrice_#i#")>
    <cfset DISCOUNTED_PRICE=evaluate("attributes.DiscountedsPrice_#i#")>
    
    <cfif attributes.tip eq 2>

    </cfif>

</cfloop>