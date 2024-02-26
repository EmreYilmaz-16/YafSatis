<cfcomponent>
    <cffunction name="SendMail">
        <cfargument name="MailBody" required="true">
        <cfargument name="FromMail" required="true">
        <cfargument name="ToMailList" required="true">
        <cfargument name="ToCCMailList">
        <cfargument name="ToBCCMailList">
        <cfargument name="subject" required="true">
        <cfmail to = "#arguments.ToMailList#" from = "#arguments.FromMail#" subject = "#arguments.subject#">             
            #arguments.MailBody# 
        </cfmail> 
    </cffunction>
    <cffunction name="GetMailAddreses">
        <cfargument name="CustomerId">
    </cffunction>
    
</cfcomponent>