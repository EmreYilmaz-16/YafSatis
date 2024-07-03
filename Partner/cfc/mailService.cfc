<cfcomponent>
    <cffunction name="SendMail" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="MailBody" required="true">
        <cfargument name="FromMail" required="true">
        <cfargument name="ToMailList" required="true">
        <cfargument name="ToCCMailList">
        <cfargument name="ToBCCMailList">        
        <cfargument name="fffile" default="">
        <cfargument name="ffftype">
        <cfargument name="fffcontent">
        <cfargument name="subject" required="true">



        <cfmail to = "#arguments.ToMailList#" cc="#ToCCMailList#" type="html" from = "#arguments.FromMail#" subject = "#arguments.subject#">             
            #arguments.MailBody# 
            <cfif len(arguments.fffile)>
            <cfmailparam
                            file="#arguments.fffile#"
                            type="#arguments.ffftype#"
                            content="#arguments.fffcontent#"
                            />
                        </cfif>
        </cfmail> 
    </cffunction>
    <cffunction name="GetMailAddreses">
        <cfargument name="CustomerId">
    </cffunction>
    
</cfcomponent>