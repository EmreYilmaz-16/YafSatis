<cfcomponent>
    <cffunction name="getCompany" access="remote">
        <cfargument name="COMPANY_ID" default="">
        <cfargument name="KEYWORD" default="">
        

        <cfquery name="getData" datasource="#dsn#">
            SELECT * FROM COMPANY WHERE 1=1 <CFIF LEN(arguments.COMPANY_ID)>AND COMPANY_ID=#arguments.COMPANY_ID#</CFIF>
            <CFIF LEN(arguments.KEYWORD)>AND (
                    FULLNAME LIKE '%#arguments.COMPANY_ID#%'
                    OR 
                    NICKNAME LIKE '%#arguments.COMPANY_ID#%'
            )
        
        </CFIF>
        </cfquery>
        <cfset ReturnArr=arrayNew(1)>
        <cfloop query="getData">
            <CFSET ITEM.COMPANY_ID=COMPANY_ID>
            <CFSET ITEM.NICKNAME=NICKNAME>
            <CFSET ITEM.FULLNAME=FULLNAME>
            <CFIF LEN(arguments.COMPANY_ID)>
                <cfreturn ITEM>
            <CFELSE>
                <cfscript>
                    arrayAppend(ReturnArr,ITEM);
                </cfscript>
            </CFIF>
        </cfloop>
    </cffunction>
</cfcomponent>