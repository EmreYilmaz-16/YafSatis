<cfparam name="attributes.tip" default="1">
<cf_box>
    <cftry>

<cfset prplist=listDeleteAt(attributes.prp_list,1)>
<cfquery name="getProd" datasource="#dsn#">
    SELECT * FROM (
SELECT PRODUCT_NAME,P.PRODUCT_ID,S.STOCK_ID,P.MANUFACT_CODE,PRODUCT_CODE,PRODUCT_CODE_2,PU.MAIN_UNIT,P.TAX,(SELECT COUNT(*) FROM CatalystQA_product.PRODUCT_IMAGES WHERE PRODUCT_ID=P.PRODUCT_ID) AS IMG_COUNT,(SELECT CONVERT(VARCHAR,VARIATION_ID)+',' FROM CatalystQA_product.PRODUCT_DT_PROPERTIES WHERE PRODUCT_ID=P.PRODUCT_ID FOR XML PATH('')) AS DTP  
FROM CatalystQA_product.PRODUCT AS P
LEFT JOIN CatalystQA_product.STOCKS AS S ON S.PRODUCT_ID=P.PRODUCT_ID
LEFT JOIN CatalystQA_product.PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=P.PRODUCT_ID AND PU.IS_MAIN=1
where PRODUCT_CATID IN(#listGetAt(attributes.prp_list,1)#,83)   

) AS TT WHERE 1=1 AND MANUFACT_CODE ='#attributes.kw#'
 
</cfquery>

<cf_ajax_list>

    <tr>
        <th>Part No</th>
        <th>Ürün Kodu</th>
        <th>Ürün</th>
        <th></th>
        <th></th>
    </tr>
<cfoutput query="getProd">
    <cfquery name="getPrcPrp" datasource="#dsn1#">
         select PROPERTY,PROPERTY_DETAIL,PRODUCT_CODE,ISNULL(PCP.IS_AMOUNT,PDP.IS_EXIT) AS IS_AMOUNT from CatalystQA_product.PRODUCT_DT_PROPERTIES AS PDP
 LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL PPD ON PPD.PROPERTY_DETAIL_ID=PDP.VARIATION_ID
 LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PPD.PRPT_ID
 LEFT JOIN CatalystQA_product.PRODUCT AS P ON P.PRODUCT_ID=PDP.PRODUCT_ID
 LEFT JOIN CatalystQA_product.PRODUCT_CAT_PROPERTY AS PCP ON PCP.PRODUCT_CAT_ID=P.PRODUCT_CATID AND PCP.PROPERTY_ID=PP.PROPERTY_ID
         WHERE PDP.PRODUCT_ID=#PRODUCT_ID# AND PDP.VARIATION_ID IS NOT NULL
           </cfquery>
    <tr>
        <TD>
        <cfif attributes.tip eq 1>
            <a href="##" onclick="UpdateRow(#PRODUCT_ID#,#STOCK_ID#,#TAX#,'#MANUFACT_CODE#','#PRODUCT_NAME#',#attributes.rc#,'#attributes.modal_id#')">#MANUFACT_CODE#</a>
        <cfelse>
            <a href="##" onclick="SetRow(#PRODUCT_ID#,#STOCK_ID#,'#MANUFACT_CODE#','#PRODUCT_NAME#','#attributes.modal_id#')">#MANUFACT_CODE#</a>
        </cfif>
        </TD>
        <TD>
            <cfif attributes.tip eq 1>
            <a href="##" onclick="UpdateRow(#PRODUCT_ID#,#STOCK_ID#,#TAX#,'#MANUFACT_CODE#','#PRODUCT_NAME#',#attributes.rc#,'#attributes.modal_id#')">#PRODUCT_CODE#</a>
        <cfelse>
            <a href="##" onclick="SetRow(#PRODUCT_ID#,#STOCK_ID#,'#MANUFACT_CODE#','#PRODUCT_NAME#','#attributes.modal_id#')">#MANUFACT_CODE#</a>
            </cfif>
        </TD>
        <TD>
            <cfif attributes.tip eq 1>
            <a href="##" onclick="UpdateRow(#PRODUCT_ID#,#STOCK_ID#,#TAX#',#MANUFACT_CODE#','#PRODUCT_NAME#',#attributes.rc#,'#attributes.modal_id#')"> #PRODUCT_NAME#</a>
        <cfelse>
            <a href="##" onclick="SetRow(#PRODUCT_ID#,#STOCK_ID#,'#MANUFACT_CODE#','#PRODUCT_NAME#','#attributes.modal_id#')">#MANUFACT_CODE#</a>
            </cfif>
        </TD>
        <td>
            <cfloop query="getPrcPrp">
                <button style="text-align:center">
                    <b style='<cfif IS_AMOUNT eq 1>color:orange</cfif>' >#PROPERTY#</b><br>
                    #PROPERTY_DETAIL#
                </button>
            </cfloop>
        </td>
        <td>
            <cfif IMG_COUNT gt 0>
            <button class="ui-wrk-btn ui-wrk-btn-red"  onclick="ShowImages2(#PRODUCT_ID#)" data-rc="6"><span class="icn-md fa fa-camera"></span></button>
            <cfelse>
                <button class="ui-wrk-btn ui-wrk-btn-busy"  onclick="ShowImages2(#PRODUCT_ID#)" data-rc="6"><span class="icn-md fa fa-camera"></span></button>
        </cfif>
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