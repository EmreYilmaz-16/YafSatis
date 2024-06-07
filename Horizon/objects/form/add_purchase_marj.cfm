<cf_box title="Satış Fiyat Marjları" scroll="1" collapsable="1" resize="1" popup_box="1">
<cfparam name="attributes.OFFER_ID" default="11">
<cfquery name="getMQ" datasource="#dsn3#">
  SELECT FIYAT_ONERME_PBS.*,PBS_OFFER_ROW.PRICE_OTHER,PBS_OFFER_ROW.OTHER_MONEY,PBS_OFFER_ROW.QUANTITY,PBS_OFFER_ROW.DISCOUNT_COST
    ,STOCKS.PRODUCT_NAME,STOCKS.MANUFACT_CODE,COMPANY.FULLNAME,PBS_OFFER.OFFER_NUMBER,COMPANY.COMPANY_ID
    FROM CatalystQA_1.FIYAT_ONERME_PBS 
LEFT JOIN CatalystQA_1.PBS_OFFER_ROW ON PBS_OFFER_ROW.OFFER_ID=FIYAT_ONERME_PBS.OFFER_ID
AND FIYAT_ONERME_PBS.WRK_ROW_ID=PBS_OFFER_ROW.UNIQUE_RELATION_ID
LEFT JOIN CatalystQA_1.PBS_OFFER ON PBS_OFFER.OFFER_ID=FIYAT_ONERME_PBS.OFFER_ID
LEFT JOIN CatalystQA.COMPANY  ON COMPANY.COMPANY_ID IN (REPLACE(PBS_OFFER.OFFER_TO, ',', ''))
LEFT JOIN CatalystQA_1.STOCKS ON STOCKS.STOCK_ID=PBS_OFFER_ROW.STOCK_ID
WHERE FIYAT_ONERME_PBS.FOR_OFFER_ID=#attributes.OFFER_ID#
ORDER BY COMPANY.FULLNAME,STOCKS.PRODUCT_NAME
</cfquery>


<cf_grid_list>
    <cfoutput query="getMQ" group="COMPANY_ID">
    <tr>
        <td colspan="8">#FULLNAME#</td>
    </tr>
    <tr>
    <th>
        Part Number
    </th>
    <th>
        Product Name
    </th>
    <th>
        Offered Quantity
    </th>
    <th>
        Price
    </th>
    <th></th>
    <th>
        Discount Cost
    </th>
    <th></th>
    <th>Discounted Price</th>
    <th></th>
    <th>Marh</th>
    </tr>
    <cfoutput>
   
        <tr>
        <td>#MANUFACT_CODE#</td>
        <td>#PRODUCT_NAME#</td>
        <td>#QUANTITY#</td>
        <td>#PRICE_OTHER#</td>
        <td>#OTHER_MONEY#</td>
        <td>#DISCOUNT_COST#</td>
        <td>#OTHER_MONEY#</td>
        <td>#PRICE_OTHER-DISCOUNT_COST#</td>
        <td>#OTHER_MONEY#</td>
        <td>#MARJ_ORAN#</td>
    </tr>
</cfoutput>
</cfoutput>
</cf_grid_list>
</cf_box>