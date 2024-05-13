<cftry>
<cfset FormData=deserializeJSON(attributes.Data)>
<cfquery name="ins" datasource="#dsn1#" result="RESA">
INSERT INTO    CatalystQA_product.PRODUCT_CATALOG_PBS(
CATALOG_NAME, SHIP_ID ,MACHINE_ID )
VALUES (
    '#FormData.CatalogName#',#FormData.ShipId#,<cfif len(FormData.Machine)>#FormData.Machine#<cfelse>NULL</cfif>
)
</cfquery>
<cfoutput>
    <cfset ReturnData.Status=1>
    <cfset ReturnData.Message="Başarılı">
    <cfset ReturnData.GeneratedKey=RESA.GENERATEDKEY>
    <cfoutput>#Replace(SerializeJSON(ReturnData),'//','')#</cfoutput>
</cfoutput>
<cfcatch>
    <cfset ReturnData.Status=0>
    <cfset ReturnData.Message=cfcatch.message>
    <cfset ReturnData.GeneratedKey="">
    <cfoutput>#Replace(SerializeJSON(ReturnData),'//','')#</cfoutput>
</cfcatch>
</cftry>