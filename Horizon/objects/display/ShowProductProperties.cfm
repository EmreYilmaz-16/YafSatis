<cfdump var="#attributes#">

<cfquery name="getProductProperties" datasource="#dsn1#">
                                select PROPERTY,PROPERTY_DETAIL,ISNULL(PCP.IS_AMOUNT,PDP.IS_EXIT) AS IS_AMOUNT from CatalystQA_product.PRODUCT_DT_PROPERTIES AS PDP
 LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL PPD ON PPD.PROPERTY_DETAIL_ID=PDP.VARIATION_ID
 LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PPD.PRPT_ID
 LEFT JOIN CatalystQA_product.PRODUCT_CAT_PROPERTY AS PCP ON PCP.PRODUCT_CAT_ID=P.PRODUCT_CATID AND PCP.PROPERTY_ID=PP.PROPERTY_ID
  WHERE PDP.PRODUCT_ID=#attributes.PID# AND PDP.VARIATION_ID IS NOT NULL
</cfquery>

<table>
    <tr>
<cfoutput query="getProductProperties">
    <td>
        #PROPERTY#
        <br>
        #PROPERTY_DETAIL#
    </td>
</cfoutput>
</tr>
</table>