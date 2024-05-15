<cfcomponent>
    <cfset dsn = application.systemParam.systemParam().dsn>
    <cffunction name="AddProductToCatalog"  access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="Data">
        <cfset FormData=deserializeJSON(arguments.data)>
        <cfdump var="#FormData#">
<cfif len(FormData.ProductId)>
    <!------Ürünü Direk Kataloğa Koyacağız----->
    <cfquery name="ins" datasource="#dsn#_product"></cfquery>
<cfelse>
    <!---------Ürün Açacağız---------->
</cfif>

    </cffunction>
</cfcomponent>