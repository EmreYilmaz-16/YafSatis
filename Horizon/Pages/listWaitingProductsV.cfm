<cfquery name="getProducts" datasource="#dsn3#">
    SELECT VPS.*,POR.IS_VIRTUAL FROM CatalystQA_1.VIRTUAL_PRODUCTS_PBS AS VPS
LEFT JOIN CatalystQA_1.PBS_OFFER_ROW AS POR ON POR.UNIQUE_RELATION_ID=VPS.OFFER_ROW_REL
WHERE POR.IS_VIRTUAL =1

</cfquery>

<table>
    <tr>
        <td>

        </td>
    </tr>
    <cfoutput query="getProducts">
        <tr>
            <td>
                #PART_NUMBER#
            </td>
            <td>
                #PRODUCT_NAME#
            </td>
            <td>
                #PRODUCT_UNIT#
            </td>
            <td>
                #JSON_STRINGIM#
            </td>
        </tr>
    </cfoutput>
</table>