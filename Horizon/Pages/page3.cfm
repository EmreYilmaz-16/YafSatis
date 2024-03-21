<!--<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />---->
<script src="/AddOns/YafSatis/Content/Js/responsive-non-intrusive-toast/toast-plugin.js"></script>
<!--- Yönlendirme Başlangıç --->
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
    
</script>

<style>
*{
    font-size:8pt !important;
}
    .EqTableMain{
        text-align: center;
    width: 100%;
    }
    .EqTableMainRows{
        border-right: solid 1px;
    width: 8%;
    }
    .input-group-addon, .input-group-btn{
        width:unset !important;
    }
    .SubSepet, input {
    text-align: right;
    padding: 1px !important;
}
</style>
<cfparam name="attributes.offer_id" default="3">
<cf_box>
    <cfset OfferService = createObject("component","AddOns.YafSatis.Partner.cfc.OfferService")>
    <cfset OfferList=OfferService.getOfferWithOfferId(attributes.OFFER_ID)>
    <script>
        var OfferData=<cfoutput>#OfferList#</cfoutput>
    </script>
    <cfset Offer=deserializeJSON(OfferList)>
    <div class="col col-12 col-sm-12 col-md-12 col-lg-12 col-xs-12">
        <div class="pull-left margin-top-10">
            <span class="margin-right-5"><a href="" class="font-md margin-right-5">YAF DIESEL</a> /</span>
            <span class="margin-right-5"><a href="" class="font-md margin-right-5">PURCHASE ITEMS</a> /</span>
            <span class="margin-right-5"><a href="" class="font-md margin-right-5">INQURIY RECORDS</a> /</span>
            <span class="margin-right-5"><a href="" class="font-md margin-right-5">INQURIY DETAIL</a> /</span>
            <span class="margin-right-5"><a href="" class="bold font-md margin-right-5 text-danger">CUSTOMER INQURIY</a></span>
        </div>
        <div class="pull-right">
            <a href="javascript://" class="ui-wrk-btn ui-wrk-btn-success ui-wrk-btn-addon-left"><i class="fa fa-envelope"></i>QUOTATION MAIL</a>
            <a href="javascript://" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left"><i class="fa fa-repeat"></i>CHANGE STATUS</a>
        </div>
    </div>
</cf_box>

<!--- Information Başlangıç --->
<cfquery name="GETrOWS" datasource="#DSN3#">
    SELECT POR.*,0 AS PURCHASE_PRICE,'TL' AS PURCHASE_MONEY,'' AS FIRST_REMARK,S.MANUFACT_CODE FROM PBS_OFFER_ROW AS POR LEFT JOIN STOCKS AS S ON S.STOCK_ID=POR.STOCK_ID WHERE OFFER_ID=#attributes.OFFER_ID#
</cfquery>

<script>
   $(document).ready(function(){<cfoutput query="GETrOWS" group="PROP_LIST">
        var excalibur=#JSON_STRINGIM#
        addEqRow(excalibur, JSON.stringify(excalibur)) 
        <cfoutput>
          //  addRowCrs('#PROP_LIST#')
          addRowCrs('#PROP_LIST#', "#PRODUCT_ID#",  "#STOCK_ID#",  "#PRODUCT_NAME#", #TAX#,  "#MANUFACT_CODE#",  #QUANTITY#,  "#UNIT#",  #PURCHASE_PRICE#,  "#PURCHASE_MONEY#",  #PRICE_OTHER#,  #DISCOUNT_COST#, #OTHER_MONEY_VALUE#,  #OTHER_MONEY_VALUE*QUANTITY#,  "#FIRST_REMARK#",0,0) 
    AlayiniHesapla();    
    </cfoutput>
    </cfoutput>
}) 
</script>
<cf_box>
    <cf_box_elements>
        <!--- 1. Grid --->
        <div class="col col-12 col-sm-12 col-md-12 col-lg-12 col-xs-12 margin-bottom-5 border-bottom border-grey">
            <!--- 1. Clumn --->
            <div class="col col-2 col-sm-2 col-md-2 col-lg-2 col-xs-12">
                <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-4 col-md-4 col-sm-4 col-xs-12">
                        <label>DATE</label>
                    </div>
                    <div class="col col-8 col-md-8 col-sm-8 col-xs-12 d-flex">
                        <span class="bold margin-right-5">:</span><label class="bold"><cfoutput>#Offer.OFFER_DATE#</cfoutput></label>
                    </div>
                </div>
                <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-4 col-md-4 col-sm-4 col-xs-12">
                        <label ><span class="text-danger">OUR REF</span></label>
                    </div>
                    <div class="col col-8 col-md-8 col-sm-8 col-xs-12 d-flex">
                        <span class="bold margin-right-5 text-danger">:</span><label><span class="text-danger bold"><cfoutput>#Offer.OFFER_NUMBER#</cfoutput></span></label>
                    </div>
                </div>
            </div>  

            <!--- 2. Clumn --->
            <div class="col col-2 col-sm-2 col-md-2 col-lg-2 col-xs-12">
                <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-4 col-md-4 col-sm-4 col-xs-12">
                        <label>CUSTOMER REF</label>
                    </div>
                    <div class="col col-8 col-md-8 col-sm-8 col-xs-12 d-flex">
                        <span class="bold margin-right-5">:</span><label class="bold"><cfoutput>#Offer.REF_NO#</cfoutput></label>
                    </div>
                </div>
                <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-4 col-md-4 col-sm-4 col-xs-12">
                        <label ><span>STAFF</span></label>
                    </div>
                    <div class="col col-8 col-md-8 col-sm-8 col-xs-12 d-flex">
                        <span class="bold margin-right-5">:</span><label><span class="bold"><cfoutput>#Offer.EMPLOYEE_NAME# #Offer.EMPLOYEE_SURNAME#</cfoutput></span></label>
                    </div>
                </div>
            </div> 
            
            <!--- 3. Clumn --->
            <div class="col col-3 col-sm-3 col-md-3 col-lg-3 col-xs-12">
                <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-4 col-md-4 col-sm-4 col-xs-12">
                        <label>CUSTOMER NAME</label>
                    </div>
                    <div class="col col-8 col-md-8 col-sm-8 col-xs-12 d-flex">
                        <span class="bold margin-right-5">:</span><label class="bold"><cfoutput>#Offer.NICKNAME#</cfoutput></label>
                    </div>
                </div>
            </div> 

            <!--- 4. Clumn --->
            <div class="col col-3 col-sm-3 col-md-3 col-lg-3 col-xs-12">
                <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-4 col-md-4 col-sm-4 col-xs-12">
                        <label>VESSEL NAME</label>
                    </div>
                    <div class="col col-8 col-md-8 col-sm-8 col-xs-12 d-flex">
                        <i onclick=openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_list_wessel_related_products&WesselId=<cfoutput>#Offer.WESSEL_ID#</cfoutput>') class="fa fa-ship color-In padding-2 padding-right-5 padding-left-5 margin-right-5" style="border-radius:3px;"></i><span class="bold margin-right-5">:</span><label class="bold"><cfoutput>O#Offer.SHIP_NAME#</cfoutput></label>
                    </div>
                </div>
                <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-4 col-md-4 col-sm-4 col-xs-12">
                        <label ><span>TRANSPORTATION</span></label>
                    </div>
                    <div class="col col-8 col-md-8 col-sm-8 col-xs-12 d-flex">
                        <span class="bold margin-right-5">:</span><label><span class="bold"><cfoutput>#Offer.SHIP_METHOD#</cfoutput></span></label>
                    </div>
                </div>
            </div> 

            <!--- 5. Clumn --->
            <div class="col col-2 col-sm-2 col-md-2 col-lg-2 col-xs-12">
                <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="margin-right-5 paddingNone margin-0">
                        <a href="javascript://" class="ui-wrk-btn ui-wrk-btn-red ui-wrk-btn-addon-left "><i class="fa fa-close"></i><span class="font-xs">DROP EMBEZZLEMENT</span></a>
                    </div>
                    <div class="margin-right-5 paddingNone margin-0">
                        <a href="javascript://" class="ui-wrk-btn ui-wrk-btn-warning ui-wrk-btn-addon-left"><i class="fa fa-edit"></i>EDIT</a>
                    </div>
                    
                </div>
            </div> 

        </div>

         <!--- 2. Grid --->
        <div class="col col-12 col-sm-12 col-md-12 col-lg-12 col-xs-12 margin-bottom-5 border-bottom border-grey">
            <!--- 1. Clumn --->
            <div class="col col-2 col-sm-2 col-md-2 col-lg-2 col-xs-12">
                <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-4 col-md-4 col-sm-4 col-xs-12">
                        <label>CONDITION</label>
                    </div>
                    <div class="col col-8 col-md-8 col-sm-8 col-xs-12 d-flex">
                        <span class="bold margin-right-5">:</span>
                        <label class="bold"><cfoutput>#Offer.CONDITION#</cfoutput></label>
                        <div class="margin-left-10">
                            <span class="text-danger">CURRENY :</span><span class="text-danger bold"><cfoutput>#Offer.OTHER_MONEY#</cfoutput></span>
                        </div>
                    </div>
                </div>
                <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-4 col-md-4 col-sm-4 col-xs-12">
                        <label ><span class="">INQUIRY REASON</span></label>
                    </div>
                    <div class="col col-8 col-md-8 col-sm-8 col-xs-12 d-flex">
                        <span class="bold margin-right-5">:</span><label><span class="bold"><cfoutput>#Offer.OFFER_CURRENCY#</cfoutput></span></label>
                    </div>
                </div>
            </div>  

            <!--- 2. Clumn --->
            <div class="col col-2 col-sm-2 col-md-2 col-lg-2 col-xs-12">
                <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-4 col-md-4 col-sm-4 col-xs-12">
                        <label>DELIVERY DATE</label>
                    </div>
                    <div class="col col-8 col-md-8 col-sm-8 col-xs-12 d-flex">
                        <span class="bold margin-right-5">:</span><label class="bold"><cfoutput>#Offer.DELIVERDATE#</cfoutput></label>
                    </div>
                </div>
                <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-4 col-md-4 col-sm-4 col-xs-12">
                        <label ><span>VALIDITY</span></label>
                    </div>
                    <div class="col col-8 col-md-8 col-sm-8 col-xs-12 d-flex">
                        <span class="bold margin-right-5">:</span><label><span class="bold"><cfoutput>#Offer.VALID_DAYS#</cfoutput> Days</span></label>
                    </div>
                </div>
            </div> 

            <!--- 3. Clumn --->
            <div class="col col-3 col-sm-3 col-md-3 col-lg-3 col-xs-12">
                <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-4 col-md-4 col-sm-4 col-xs-12">
                        <label>DELIVERY ADDRESS</label>
                    </div>
                    <div class="col col-8 col-md-8 col-sm-8 col-xs-12 d-flex">
                        <span class="bold margin-right-5">:</span><label class="bold"><cfoutput>#Offer.DELIVERY_PLACE# - #Offer.DELIVERY_ADDRESS#</cfoutput></label>
                    </div>
                </div>
                <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-4 col-md-4 col-sm-4 col-xs-12">
                        <label ><span>NOTE</span></label>
                    </div>
                    <div class="col col-8 col-md-8 col-sm-8 col-xs-12 d-flex">
                        <span class="bold margin-right-5">:</span><label><span class="bold"><cfoutput>#Offer.OFFER_DETAIL#</cfoutput></span></label>
                    </div>
                </div>
            </div>

        </div>
    </cf_box_elements>

</cf_box>

<!--- Add Equipment --->
<cf_box>
    <cf_box_elements>
        <div class="col col-12 col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="form-group col col-2 col-md-2 col-sm-2 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">EQUIPMENT</label>
                    <select name="PRODUCT_CAT" id="PRODUCT_CAT" onchange="getCatProperties(this.value)">
                        
                    </select>
                </div>
            </div>
            <div id="PROP_AREA">

            </div>
            <div class="form-group col col-2 col-md-2 col-sm-2 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="padding-2 col col-12 col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="col col-4 col-lg-4 col-md-4 col-sm-4 col-xs-4 d-flex flex-center">
                            <a href="javascript://" class="font-xs text-info"><i class="fa fa-download margin-right-5"></i>EXPORT</a>
                        </div>

                        <div class="col col-4 col-lg-4 col-md-4 col-sm-4 col-xs-4 d-flex flex-center">
                            <a href="javascript://" class="font-xs text-info"><i class="fa fa-upload margin-right-5"></i>IMPORT</a>
                        </div>

                        <div class="col col-4 col-lg-4 col-md-4 col-sm-4 col-xs-4 d-flex flex-center">
                            <a href="javascript://" class="font-xs text-info"><i class="fa fa-cloud-upload margin-right-5"></i>SAMPLE EXCEL</a>
                        </div>
                    </div>
                    <a href="javascript://" onclick="AddEquipment()" class="ui-wrk-btn ui-wrk-btn-success ui-wrk-btn-addon-left btn-block padding-left-5 padding-right-5"><i class="fa fa-plus"></i>ADD EQUIPMENT</a>
                    
                </div>
            </div>
        </div>
    </cf_box_elements>
</cf_box>

<!--- .... --->
<cf_box>
    <div id="BasketArea">

    </div>
    
</cf_box>
<cf_box>
    <div id="BasketFooter">
        <div class="row">
            <div class="col col-4">

            </div>
            <div class="col col-4">

            </div>
            <div class="col col-4">
<div id="OzetAlani">

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
        <tr>
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
            </div>
        </div>
    </div>
    
</cf_box>

<script src="/AddOns/YafSatis/Horizon/js/sayfa3.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>