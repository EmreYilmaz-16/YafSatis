<cf_box>
    <cftry>

<cfset prplist=listDeleteAt(attributes.prp_list,1)>
<cfquery name="getProd" datasource="#dsn#">
    SELECT * FROM (
SELECT PRODUCT_NAME,P.PRODUCT_ID,S.STOCK_ID,P.MANUFACT_CODE,PRODUCT_CODE,PRODUCT_CODE_2,PU.MAIN_UNIT,P.TAX,(SELECT CONVERT(VARCHAR,VARIATION_ID)+',' FROM CatalystQA_product.PRODUCT_DT_PROPERTIES WHERE PRODUCT_ID=P.PRODUCT_ID FOR XML PATH('')) AS DTP  
FROM CatalystQA_product.PRODUCT AS P
LEFT JOIN CatalystQA_product.STOCKS AS S ON S.PRODUCT_ID=P.PRODUCT_ID
LEFT JOIN CatalystQA_product.PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=P.PRODUCT_ID AND PU.IS_MAIN=1
where PRODUCT_CATID=#listGetAt(attributes.prp_list,1)#   

) AS TT WHERE 1=1 AND MANUFACT_CODE ='#attributes.kw#'
<cfloop list="#prplist#" item="it"> AND DTP LIKE '%#it#,%'
</cfloop>
 
</cfquery>

<cf_ajax_list>
    <cfquery name="getPrcPrp" datasource="#dsn1#">
 select PROPERTY,PROPERTY_DETAIL from CatalystQA_product.PRODUCT_DT_PROPERTIES AS PDP
 LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL PPD ON PPD.PROPERTY_DETAIL_ID=PDP.VARIATION_ID
 LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY AS P ON P.PROPERTY_ID=PPD.PRPT_ID
  WHERE PRODUCT_ID=#PRODUCT_ID# AND PDP.VARIATION_ID IS NOT NULL
    </cfquery>
    <tr>
        <th>Part No</th>
        <th>Ürün</th>
     
    </tr>
<cfoutput query="getProd">
    <tr>
        <TD>
            <a href="##" onclick="UpdateRow(#PRODUCT_ID#,#STOCK_ID#,#TAX#,'#MANUFACT_CODE#','#PRODUCT_NAME#',#attributes.rc#,'#attributes.modal_id#')">#MANUFACT_CODE#</a>
        </TD>
        <TD>
            <a href="##" onclick="UpdateRow(#PRODUCT_ID#,#STOCK_ID#,#TAX#',#MANUFACT_CODE#','#PRODUCT_NAME#',#attributes.rc#,'#attributes.modal_id#')"> #PRODUCT_NAME#</a>
        </TD>
        <td>
            <cfloop query="getPrcPrp">
                <button style="text-align:center">
                    <b>#PROPERTY#</b><br>
                    #PROPERTY_DETAIL#
                </button>
            </cfloop>
        </td>
    </tr>
</cfoutput>
</cf_ajax_list>
<cfcatch>
    <cfdump var="#cfcatch#">
</cfcatch>
</cftry>

<cfoutput>
    <a href="javascript://" onclick="closeBoxDraggable('#attributes.modal_id#')" class="ui-wrk-btn ui-wrk-btn-red ui-wrk-btn-addon-left "><i class="fa fa-close"></i><span class="font-xs">Kapat</span></a>
    
</cfoutput>
</cf_box>