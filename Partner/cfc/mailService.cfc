<cfcomponent>
    <cffunction name="SendMail">
        <cfargument name="formData" required="true">
       <cfdump var="#arguments#">
       
        <!----
        <cfargument name="subject" required="true">
        <cfmail to = "#arguments.ToMailList#" from = "#arguments.FromMail#" subject = "#arguments.subject#">             
            #arguments.MailBody# 
        </cfmail> ----->
    </cffunction>
    <cffunction name="GetMailAddreses">
        <cfargument name="CustomerId">
    </cffunction>
    
</cfcomponent>