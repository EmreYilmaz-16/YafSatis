<cfdump var="#attributes#">

<cfquery name="getpf" datasource="#dsn3#">
    select * from CatalystQA_1.PROCESS_TYPE_PRINTS WHERE ID=#attributes.pfid#
</cfquery>

<cfif getpf.recordCount>
    <cfinclude template="#getpf.PRINT_FILE_PATH#">
<cfelse>
    <div class="alert alert-danger">
        Şablon Bulunamadı
    </div>
</cfif>