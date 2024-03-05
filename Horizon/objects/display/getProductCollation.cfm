<cf_box>
    <cftry>
<cfdump var="#attributes#">
<cfset prplist=listDeleteAt(attributes.prp_list,1)>
<cfquery name="getProd" datasource="#dsn#">
    SELECT * FROM (
SELECT PRODUCT_NAME,P.PRODUCT_ID,MANUFACT_CODE,PRODUCT_CODE,PRODUCT_CODE_2,PU.MAIN_UNIT,(SELECT CONVERT(VARCHAR,VARIATION_ID)+',' FROM CatalystQA_product.PRODUCT_DT_PROPERTIES WHERE PRODUCT_ID=P.PRODUCT_ID FOR XML PATH('')) AS DTP  FROM CatalystQA_product.PRODUCT AS P
LEFT JOIN CatalystQA_product.PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=P.PRODUCT_ID AND PU.IS_MAIN=1
where PRODUCT_CATID=#listGetAt(attributes.prp_list,1)#  

) AS TT WHERE 1=1 AND MANUFACT_CODE ='#attributes.kw#'
<cfloop list="#prplist#" item="it"> AND DTP LIKE '%#it#,%'
</cfloop>
 
</cfquery>
<cfdump var="#getProd#">
<table>
    <cfquery name="getPrcPrp" datasource="#dsn1#">
SELECT PP.PROPERTY_ID,PP.PROPERTY FROM CatalystQA_product.PRODUCT_CAT_PROPERTY AS PCP 
	INNER JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PCP.PROPERTY_ID
	WHERE PRODUCT_CAT_ID=#listGetAt(attributes.prp_list,1)#
    </cfquery>
    <tr>
        <th>Ürün</th>
        <cfloop query="getPrcPrp">
            <th>
                <cfoutput>#PROPERTY#</cfoutput>
            </th>
        </cfloop>
    </tr>
<cfoutput query="getProd">
    <tr>
        <TD>
            #PRODUCT_NAME#
        </TD>
        <cfloop query="getPrcPrp">
            <cfquery name="getpv" datasource="#dsn1#">
                	select PPD.PROPERTY_DETAIL from CatalystQA_product.PRODUCT_DT_PROPERTIES AS PDP 
	INNER JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PPD ON PPD.PROPERTY_DETAIL_ID=PDP.VARIATION_ID
	where PRODUCT_ID=#getProd.PRODUCT_ID# AND VARIATION_ID IS NOT NULL AND PROPERTY_ID=#getPrcPrp.PROPERTY_ID#
            </cfquery>
            <td>#getpv.PROPERTY_DETAIL#</td>
        </cfloop>
    </tr>
</cfoutput>
</table>
<cfcatch>
    <cfdump var="#cfcatch#">
</cfcatch>
</cftry>

<cfoutput>
    <button onclick="closeBoxDraggable('#attributes.modal_id#')">Kapa</button>
</cfoutput>
</cf_box>