<cfquery name="getProducts" datasource="#dsn3#">
    SELECT VPS.*,POR.IS_VIRTUAL FROM CatalystQA_1.VIRTUAL_PRODUCTS_PBS AS VPS
LEFT JOIN CatalystQA_1.PBS_OFFER_ROW AS POR ON POR.UNIQUE_RELATION_ID=VPS.OFFER_ROW_REL
WHERE POR.IS_VIRTUAL =1

</cfquery>
<cf_box title="Bekleyen Sanal Ürünler" scroll="1" collapsable="1" resize="1" popup_box="1">
<cf_big_list>
    <thead>
    <tr>
        <th>
            Part No
        </th>
        <th>
            Ürün
        </th>
        <th>
            Birim
        </th>
        <th>

        </th>
    </tr>
</thead>
<tbody>
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
                <cfset DF=deserializeJSON(JSON_STRINGIM)>
                <cfloop array="#DF.Filters#" item="it">
                    <button>
                        <b>#it.PNAME#</b>
                        <br>
                        #it.PRODUCT_CAT#
                    </button>
                </cfloop>
                
            </td>
        </tr>
    </cfoutput>
</tbody>
</cf_big_list>
</cf_box>