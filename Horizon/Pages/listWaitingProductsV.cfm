<cfquery name="getProducts" datasource="#dsn3#">
    SELECT VPS.*,POR.IS_VIRTUAL,PO.OFFER_NUMBER,POR.OFFER_ID FROM CatalystQA_1.VIRTUAL_PRODUCTS_PBS AS VPS
LEFT JOIN CatalystQA_1.PBS_OFFER_ROW AS POR ON POR.UNIQUE_RELATION_ID=VPS.OFFER_ROW_REL
LEFT JOIN CatalystQA_1.PBS_OFFER AS PO ON PO.OFFER_ID=POR.OFFER_ID
WHERE POR.IS_VIRTUAL =1

</cfquery>
<cf_box title="Bekleyen Sanal Ürünler" scroll="1" collapsable="1" resize="1" popup_box="1">
    <cfoutput query="getProducts" group="OFFER_ID">
        <cf_seperator title="#OFFER_NUMBER#" id="item_#OFFER_ID#">
        <div id="sep_#OFFER_ID#">
        <cf_big_list>
    <thead>
    <tr>
        <th></th>
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
    <cfoutput>
        <tr>
            <td>
                <a href="javascript://" onclick='openBoxDraggable("index.cfm?fuseaction=sales.emptypopup_detail_virtual_product&VP_ID=#VP_ID#")' ><span class="icn-md icon-search"></span></a>
            </td>
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
</div>
</cfoutput>
</cf_box>

