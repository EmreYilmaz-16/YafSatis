<cf_box title="Bekleyen Sanal Ürünler" scroll="1" collapsable="1" resize="1" popup_box="1">
<cfquery name="getProducts" datasource="#dsn3#">
    SELECT VPS.*,POR.IS_VIRTUAL FROM CatalystQA_1.VIRTUAL_PRODUCTS_PBS AS VPS
LEFT JOIN CatalystQA_1.PBS_OFFER_ROW AS POR ON POR.UNIQUE_RELATION_ID=VPS.OFFER_ROW_REL
WHERE VP_ID=#attributes.VP_ID#

</cfquery>
<cfset DFS=deserializeJSON(getProducts.JSON_STRINGIM)>
<cfoutput>
    <div style="font-size: 20pt;font-weight: bold;color: orange;border-bottom: solid 1px black;text-align: center;">
        #getProducts.PART_NUMBER#
        <input type="hidden" id="MANUFACT_CODE" value="#getProducts.PART_NUMBER#">
        <input type="hidden" id="OFFER_ROW_REL" value="#getProducts.OFFER_ROW_REL#">
    </div>
    <div style="font-size: 20pt;color: green;font-weight: bold;margin-bottom: 5px;text-align: center;">
        #getProducts.PRODUCT_NAME#
        <input type="hidden" id="PRODUCT_NAME" value="#getProducts.PRODUCT_NAME#">
    </div>
    <div style="text-align: center;display: flex;justify-content: center;margin-bottom:10px">

    
<cfloop array="#DFS.Filters#" item="it">
    <button>
        <b>#it.PNAME#</b>
        <br>
        
        #it.PRODUCT_CAT#
    </button>
</cfloop>
</div>
<input type="hidden" name="FRMPRP" id="FRMPRP" value='#getProducts.JSON_STRINGIM#'>
<input type="hidden" name="UNIQUE_RELATION_ID" id="UNIQUE_RELATION_ID" value='#getProducts.OFFER_ROW_REL#'>
</cfoutput>

<cfquery name="SameCode" datasource="#dsn3#">
    SELECT  S.PRODUCT_ID,S.STOCK_ID,S.MANUFACT_CODE,S.PRODUCT_NAME,S.PRODUCT_CATID,PC.PRODUCT_CAT,
(
    SELECT PPD.PROPERTY_DETAIL,PPD.PROPERTY_DETAIL_ID,PP.PROPERTY_ID,PP.PROPERTY,PRODUCT_ID FROM CatalystQA_product.PRODUCT_DT_PROPERTIES AS PDP
LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PPD ON PPD.PROPERTY_DETAIL_ID=PDP.VARIATION_ID
LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PDP.PROPERTY_ID
 WHERE PRODUCT_ID=S.PRODUCT_ID 
 ORDER BY PDP.LINE_VALUE
 FOR JSON PATH 
) AS JSN_V
FROM CatalystQA_1.STOCKS AS S 
LEFT JOIN CatalystQA_1.PRODUCT_CAT AS PC ON PC.PRODUCT_CATID=S.PRODUCT_CATID

WHERE MANUFACT_CODE LIKE '%#getProducts.PART_NUMBER#%' OR PRODUCT_NAME LIKE '%#getProducts.PRODUCT_NAME#%'
</cfquery>
<cf_box title="Benzer Ürünler">
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
            Equipment
        </th> 
        <th>

        </th>
        <th>

        </th>
    </tr>
</thead>
<tbody>
    <cfoutput query="SameCode">
        <tr>
            <td >
                #MANUFACT_CODE#
                
            </td>
            <td>
                #PRODUCT_NAME#
                
            </td> 
            <td>
                #PRODUCT_CAT#
                
            </td>          
            <td>
                <cftry>
                <cfset DF=deserializeJSON(JSN_V)>
                
                
                <cfloop array="#DF#" item="it">
                    <cfif isDefined("it.PROPERTY_DETAIL")>
                    <button>
                        <b>#it.PROPERTY#</b>
                        <br>
                        #it.PROPERTY_DETAIL#
                    </button>
                </cfif>
                </cfloop>
                
                <cfcatch>
                        
                </cfcatch>
            </cftry>
            </td>
            <td>
                <button onclick="UseThis(1,'#getProducts.OFFER_ROW_REL#',#PRODUCT_ID#,#STOCK_ID#)" type="button">Bunu Kullan</button>
                
            </td>
        </tr>
    </cfoutput>
    <tr>
        <td colspan="5" style="text-align:right">
            <button onclick="UseThis(3,'<cfoutput>#getProducts.OFFER_ROW_REL#</cfoutput>',0,0)" type="button">Bu Varyasonlar İle Yeni Ürün Oluştur ve Kullan</button>
        </td>
    </tr>
</tbody>
</cf_big_list>
</cf_box>

</cf_box>


<script>   
var ServiceUri = "/AddOns/YafSatis/Partner/cfc"; 
function UseThis(TIP,OFFER_ROW_REL,PRODUCT_ID,STOCK_ID) {
            $.ajax({
                url:ServiceUri+"/OfferService.cfc?method=VirtualOperations",
                data:{FormData:JSON.stringify({
                    Tip:TIP,
                    OFFER_ROW_REL:OFFER_ROW_REL,
                    PRODUCT_ID:PRODUCT_ID,
                    STOCK_ID:STOCK_ID,

                })},
                success:function (ReturnData) {
                    
                }
            })
        }
</script>