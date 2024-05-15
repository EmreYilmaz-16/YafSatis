<cfcomponent>
    <cffunction name="AddProductToCatalog"  access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="Data">
        <cfset FormData=deserializeJSON(arguments.data)>
        <cfdump var="#FormData#">
    </cffunction>
</cfcomponent>