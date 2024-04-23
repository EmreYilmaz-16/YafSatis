
<cfparam name="attributes.offer_id" default="32">


<CFSET OfferService=createObject("component","AddOns.YafSatis.Partner.cfc.OfferService")>

<cfset _OfferData=OfferService.getPurchaseOffer(attributes.offer_id)>
<cfset OfferData=deserializeJSON(_OfferData)>
<cfset MoneyArr=deserializeJSON(OfferService.getOfferMoney())>
<cfquery name="getMoney" datasource="#dsn#">
    SELECT (
            SELECT RATE1
            FROM #DSN#.MONEY_HISTORY
            WHERE MONEY_HISTORY_ID = (
                    SELECT MAX(MONEY_HISTORY_ID)
                    FROM #DSN#.MONEY_HISTORY
                    WHERE MONEY = SM.MONEY
                    )
            ) AS RATE1
        ,(
            SELECT RATE2
            FROM #DSN#.MONEY_HISTORY
            WHERE MONEY_HISTORY_ID = (
                    SELECT MAX(MONEY_HISTORY_ID)
                    FROM #DSN#.MONEY_HISTORY
                    WHERE MONEY = SM.MONEY
                    )
            ) AS RATE2
        ,SM.MONEY
    FROM #DSN#.SETUP_MONEY AS SM
    WHERE SM.PERIOD_ID = #session.ep.period_id#
</cfquery>
<script>
    var DataSources={
        DSN:"<cfoutput>#dsn#</cfoutput>",
        DSN1:"<cfoutput>#dsn1#</cfoutput>",
        DSN2:"<cfoutput>#dsn2#</cfoutput>",
        DSN3:"<cfoutput>#dsn3#</cfoutput>",
    }
    var ACTIVE_COMPANY="<CFOUTPUT>#session.ep.company_id#</CFOUTPUT>";
    var MONEY_ARR=[
        <cfoutput query="getMoney">
            {
                RATE1:#RATE1#,
                RATE2:#RATE2#,
                MONEY:'#MONEY#',
                SELECTED:0
            },
        </cfoutput>
    ]
    var generalParamsSatis={
        userData:{
            user_id:<cfoutput>#session.ep.userid#</cfoutput>
        }
    }

</script>

<cfdump var="#OfferData#">
<cf_box title="DEAR #OfferData.NICKNAME# , YOU CAN CREATE AND SEND YOUR OFFER TO US">
    <cfset OfferList=OfferService.getOfferWithOfferId(attributes.OFFER_ID)>
    <script>
        var OfferData=<cfoutput>#OfferList#</cfoutput>
    </script>      
    

<div style="display:flex">
    <div class="form-group">
        <label>DELIVER FEE</label>
        <select name="DELIVER_FEE">
            <option value="">Seç</option>
            <option value="1">Need Charge</option>
        </select>
    </div>
    <div class="form-group">
        <label>Tax Status</label>
        <select name="TAX_STATUS">
            <option value="">Seç</option>
            <option value="1">With Tax</option>
            <option value="1">Without Tax</option>
        </select>
    </div>
    <div class="form-group">
        <label>General Discount %</label>
        <input type="text" id="GENERAL_DISCOUNT" name="GENERAL_DISCOUNT" onchange="indirimYuzdeHesap()">
    </div>    
    <div class="form-group">
        <label>Currency</label>
        <select id="MONEY" name="MONEY" onchange="AlayiniHesapla()">
            <option value="">Seç</option>
            <cfoutput>
                <cfloop from="1" to="#arrayLen(MoneyArr)#" index="ix">
                
                    <cfset item=MoneyArr[ix]>
                <option value="#item.MONEY#">#item.MONEY#</option>
                </cfloop>
            </cfoutput>
             </select>
    </div>
    <div class="form-group">
        <label>Delivery Times</label>
        <input type="text" name="DELIVERY_TIMES">
    </div> 
    <div class="form-group">
        <button class="ui-wrk-btn ui-wrk-btn-success" onclick="SaveOffer()">
          Kaydet
        </button>
    </div>
</div>


</cf_box>
<cf_box>
    <div id="BasketArea">

    </div>
    
<div id="SubTotalArea">
    <cf_grid_list>
        <thead>
            <tr>
                <th colspan="3">
                    Toplamlar
                </th>
            </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                Toplam
            </td>
            <td>
                <div class="form-group">
                    <input type="text" name="total_default" id="total_default" readonly>
                </div>
            </td>
            <td>
                <div class="form-group">
                    <input type="text" name="total_default_" id="total_default_" readonly>
                </div>
            </td>
        </tr>
        <tr style="display:none">
            <td>
                Fatura Altı İndirim
            </td>
            <td>
                <div class="form-group">
                    <input type="text" onchange="AlayiniHesapla()" name="genel_indirim_" id="genel_indirim_" >
                </div>
            </td>
            <td>
                <div class="form-group">
                    <input type="text" onchange="AlayiniHesapla()" name="genel_indirim__" id="genel_indirim__" readonly>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                Toplam İndirim
            </td>
            <td>
                <div class="form-group">
                    <input type="text" name="total_discount_wanted" id="total_discount_wanted" readonly>
                </div>
            </td>
            <td>
                <div class="form-group">
                    <input type="text" name="total_discount_wanted_" id="total_discount_wanted_" readonly>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                KDV'siz Toplam
            </td>
            <td>
                <div class="form-group">
                    <input type="text" name="brut_total_wanted" id="brut_total_wanted" readonly >
                </div>
            </td>
            <td>
                <div class="form-group">
                    <input type="text" name="brut_total_wanted_" id="brut_total_wanted_" readonly >
                </div>
            </td>
        </tr>
        <tr>
            <td>
                KDV Toplam
            </td>
            <td>
                <div class="form-group">
                    <input type="text" name="total_tax_wanted" id="total_tax_wanted" readonly>
                </div>
            </td>
            <td>
                <div class="form-group">
                    <input type="text" name="total_tax_wanted_" id="total_tax_wanted_" readonly>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                KDV'li Toplam
            </td>
            <td>
                <div class="form-group">
                    <input type="text" name="net_total_wanted" id="net_total_wanted" readonly>
                </div>
            </td>
            <td>
                <div class="form-group">
                    <input type="text" name="net_total_wanted_" id="net_total_wanted_" readonly>
                </div>
            </td>
        </tr>
    </tbody>
    </cf_grid_list>
</div>
</cf_box>
<!---------->
<cfoutput>
<script>
    $(document).ready(function(){
        <cfloop from="1" to="#arraylen(OfferData.PROP_ARR)#" index="i">
            <cfset Item=OfferData.PROP_ARR[i]>
            var excalibur=#Item.JSON_STRINGIM#
            addEqRow(excalibur, JSON.stringify(excalibur)) 
            <cfloop from="1" to="#arraylen(Item.OFFER_ROWS)#" index="j">
                <cfset ROWA=Item.OFFER_ROWS[j]>
                addRowCrs('#Item.PROP_LIST#', "#ROWA.PRODUCT_ID#",  "#ROWA.STOCK_ID#",  "#ROWA.PRODUCT_NAME#", 0,  "#ROWA.PART_NUMBER#",  #ROWA.QUANTITY#,  "#ROWA.UNIT#",  #ROWA.PRICE#,  "#ROWA.OTHER_MONEY#",  #ROWA.PRICE_OTHER#,  #ROWA.DISCOUNT_COST#, #0#,  #0*ROWA.QUANTITY#,  "",0,0,#ROWA.IS_VIRTUAL#,'#ROWA.UNIQUE_RELATION_ID#') 
            </cfloop>
        </cfloop>
    })
</script>
</cfoutput>
<script src="/AddOns/YafSatis/Horizon/js/add_purchase_offer_prices.js"></script>