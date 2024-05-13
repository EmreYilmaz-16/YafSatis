<cfset FormData=deserializeJSON(attributes.Data)>
<cfquery name="ins" datasource="#dsn1#" result="RESA">
INSERT INTO    CatalystQA_product.PRODUCT_CATALOG_PBS(
CATALOG_NAME, SHIP_ID ,MACHINE_ID )
VALUES (
    '#FormData.CatalogName#',#FormData.ShipId#,<cfif len(FormData.Machine)>#FormData.Machine#<cfelse>NULL</cfif>
)
</cfquery>
<cfoutput>
#Replace(SerializeJSON(RESA),'//','')#
</cfoutput>