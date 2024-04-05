<cf_box title="Gemiler" scroll="1" collapsable="1" resize="1" popup_box="1">


<cfquery name="getProductProperties" datasource="#dsn1#">
                                select PROPERTY,PROPERTY_DETAIL,ISNULL(PCP.IS_AMOUNT,PDP.IS_EXIT) AS IS_AMOUNT from 
                                CatalystQA_product.PRODUCT AS P 
                               LEFT JOIN  CatalystQA_product.PRODUCT_DT_PROPERTIES AS PDP ON PDP.PRODUCT_ID=P.PRODUCT_ID
 LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL PPD ON PPD.PROPERTY_DETAIL_ID=PDP.VARIATION_ID
 LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PPD.PRPT_ID
 LEFT JOIN CatalystQA_product.PRODUCT_CAT_PROPERTY AS PCP ON PCP.PRODUCT_CAT_ID=P.PRODUCT_CATID AND PCP.PROPERTY_ID=PP.PROPERTY_ID
 
  WHERE PDP.PRODUCT_ID=#attributes.PID# AND PDP.VARIATION_ID IS NOT NULL
</cfquery>

<cf_big_list>
    <tr>
<cfoutput query="getProductProperties">
    <td>
        <cfif IS_AMOUNT eq 1>
            <span style="color:red;font-weight:bold;font-size:12pt !important;display:block">*</span>
        </cfif>
        #PROPERTY#
        <br>
        #PROPERTY_DETAIL#
    </td>
</cfoutput>
</tr>
</table>
</cf_big_list>