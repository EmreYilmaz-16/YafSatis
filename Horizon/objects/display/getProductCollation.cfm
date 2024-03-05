<cf_box>
    <cftry>
<cfdump var="#attributes#">
<cfset prplist=listDeleteAt(attributes.prp_list,1)>
<cfquery name="getProd" datasource="#dsn#">
    SELECT * FROM (
SELECT PRODUCT_NAME,MANUFACT_CODE,PRODUCT_CODE,PRODUCT_CODE_2,PU.MAIN_UNIT,(SELECT CONVERT(VARCHAR,VARIATION_ID)+',' FROM CatalystQA_product.PRODUCT_DT_PROPERTIES WHERE PRODUCT_ID=P.PRODUCT_ID FOR XML PATH('')) AS DTP  FROM CatalystQA_product.PRODUCT AS P
LEFT JOIN CatalystQA_product.PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=P.PRODUCT_ID AND PU.IS_MAIN=1
where PRODUCT_CATID=#listGetAt(attributes.prp_list,1)#  

) AS TT WHERE 1=1 AND MANUFACT_CODE ='#attributes.kw#'
<cfloop list="#prplist#" item="it"> AND DTP LIKE '%#it#,%'
</cfloop>
 
</cfquery>
<cfdump var="#getProd#">
<cfcatch>
    <cfdump var="#cfcatch#">
</cfcatch>
</cftry>

<cfoutput>
    <button onclick="closeBoxDraggable('#attributes.modal_id#')">Kapa</button>
</cfoutput>
</cf_box>