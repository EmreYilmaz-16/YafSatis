<cfcomponent>
    <cfset DSN=application.systemParam().DSN>
    <cffunction name="GetCustomer" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="CustomerId" default="">
        <cfargument name="Keyword" default="">
        <cfargument name="RowCount" default="20">
        <cfargument name="Page" default="1">
        <cfquery name="getCustomer" datasource="#dsn#">
            SELECT * FROM COMPANY WHERE 1=1 
            <cfif len(arguments.Keyword)>
                AND (
                    FULLNAME LIKE '%#arguments.Keyword#%' OR
                    MEMBERCODE LIKE '%#arguments.Keyword#%'
                )
            </cfif>
            <cfif len(arguments.CustomerId)>
                AND COMPANY_ID=#arguments.COMPANY_ID#
            </cfif>
        </cfquery>
        <cfset ReturnArr=arrayNew(1)>
        <cfloop query="getCustomer">
            <cfset Company=structNew()>
            <cfset Company.NICKNAME="#NICKNAME#">
            <cfset Company.FULLNAME="#FULLNAME#">
            <cfset Company.COMPANY_ID="#COMPANY_ID#">
            <cfscript>
                arrayAppend(ReturnArr,Company);
            </cfscript>
        </cfloop>
        <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>
</cfcomponent>

