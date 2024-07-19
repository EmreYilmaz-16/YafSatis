<cf_box title="Satış Fiyat Marjları" scroll="1" collapsable="1" resize="1" popup_box="1">
<cfparam name="attributes.OFFER_ID" default="11">
<cfquery name="getMQ" datasource="#dsn3#">
  SELECT FIYAT_ONERME_PBS.ID,FIYAT_ONERME_PBS.WRK_ROW_ID,FIYAT_ONERME_PBS.OFFER_ID,FIYAT_ONERME_PBS.SON_FIYAT,FIYAT_ONERME_PBS.FOR_OFFER_ID,FIYAT_ONERME_PBS.SECEN_EMP,FIYAT_ONERME_PBS.SECEN_DATE,FIYAT_ONERME_PBS.MARJ_EMP,FIYAT_ONERME_PBS.MARJ_DATE,ISNULL(FIYAT_ONERME_PBS.MARJ_ORAN,0) MARJ_ORAN
  ,PBS_OFFER_ROW.PRICE_OTHER,PBS_OFFER_ROW.OTHER_MONEY,PBS_OFFER_ROW.QUANTITY,PBS_OFFER_ROW.DISCOUNT_COST
    ,STOCKS.PRODUCT_NAME,STOCKS.MANUFACT_CODE,COMPANY.FULLNAME,COMPANY.OZEL_KOD,PBS_OFFER.OFFER_NUMBER,COMPANY.COMPANY_ID
    ,STOCKS.PRODUCT_ID,STOCKS.STOCK_ID
    FROM CatalystQA_1.FIYAT_ONERME_PBS 
LEFT JOIN CatalystQA_1.PBS_OFFER_ROW ON PBS_OFFER_ROW.OFFER_ID=FIYAT_ONERME_PBS.OFFER_ID
AND FIYAT_ONERME_PBS.WRK_ROW_ID=PBS_OFFER_ROW.UNIQUE_RELATION_ID
LEFT JOIN CatalystQA_1.PBS_OFFER ON PBS_OFFER.OFFER_ID=FIYAT_ONERME_PBS.OFFER_ID
LEFT JOIN CatalystQA.COMPANY  ON COMPANY.COMPANY_ID IN (REPLACE(PBS_OFFER.OFFER_TO, ',', ''))
LEFT JOIN CatalystQA_1.STOCKS ON STOCKS.STOCK_ID=PBS_OFFER_ROW.STOCK_ID
WHERE FIYAT_ONERME_PBS.FOR_OFFER_ID=#attributes.OFFER_ID#
ORDER BY COMPANY.FULLNAME,STOCKS.PRODUCT_NAME
</cfquery>
<cfquery name="getOfferMoney" datasource="#dsn3#">
    select MONEY_TYPE from CatalystQA_1.PBS_OFFER_MONEY where ACTION_ID=#attributes.OFFER_ID# and IS_SELECTED=1
</cfquery>
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

<cfloop query="getMoney">
    <cfset "KURLAR.#MONEY#.RATE2" =RATE2>
</cfloop>

<style>
    .MoneyText{
        background: #f7f1ea !important;
    border: solid 1px #c3b7a6 !important;
    text-align: right;
    }
</style>

<form id="FORM_0001">
<cf_ajax_list>
    <cfset ROW_COUNT=0>
    <cfoutput query="getMQ" group="COMPANY_ID">
        <thead>
    <tr>
        <th style="background:##f0f8ff" colspan="14"><cfif listFind(session.ep.USER_LEVEL,"12")>#FULLNAME#<cfelse>#OZEL_KOD#</cfif></th>
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
    <th>Net Price</th>
    <th></th>
    <th>Marj <span style="float:inline-end">%</span>
        <div class="form-group">
        <input type="text" name="MarjS" style="background:##f7f1ea !important;border: solid 1px ##c3b7a6 !important;text-align: right;" data-company_id="#COMPANY_ID#" onchange="SetAllSubMarj(this)">
    </div>
    </th>
    <th>Sales Price</th>
    <th></th>
    </tr>
</thead>
<tbody>
    <cfoutput>
        <cfset ROW_COUNT=ROW_COUNT+1>
        <tr>
        <td><a href="javascript://" onclick="open_product_popup_fg(#PRODUCT_ID#,#STOCK_ID#)">#MANUFACT_CODE#</a></td>
        <td>#PRODUCT_NAME#</td>
        <td>#tlformat(QUANTITY)#</td>
        <td>#tlformat(PRICE_OTHER)# <input type="hidden" name="PPMNAY_#ROW_COUNT#" value="#OTHER_MONEY#"></td>
        <td>#OTHER_MONEY#</td>
        <td>#tlformat(DISCOUNT_COST)#</td>
        <td>#OTHER_MONEY#</td>
        <td><div class="form-group">
            <input type="text" name="DiscountedsPrice_#ROW_COUNT#" style="background: ##f7f1ea !important;border: solid 1px ##c3b7a6 !important;text-align: right;" value="#tlformat(PRICE_OTHER-DISCOUNT_COST)#" class="MoneyText" readonly="">
            
        </div></td>
        <td>#OTHER_MONEY#</td>
        <td>
            <div class="form-group">
                <cfset H1=PRICE_OTHER-DISCOUNT_COST>
                <cfset H1=H1* evaluate("KURLAR.#OTHER_MONEY#.RATE2")>
                <CFSET H1=H1/evaluate("KURLAR.#getOfferMoney.MONEY_TYPE#.RATE2") >
                <input type="text" name="DiscountedPrice_#ROW_COUNT#" style="background: ##f7f1ea !important;border: solid 1px ##c3b7a6 !important;text-align: right;" value="#tlformat(H1)#" class="MoneyText" readonly="">
            </div>
        </td>
        <td>#getOfferMoney.MONEY_TYPE#</td>
        <td><div class="form-group">
            <input type="text" name="Marj_#COMPANY_ID#" data-row="#ROW_COUNT#" style="background: ##f7f1ea !important;border: solid 1px ##c3b7a6 !important;text-align: right;" value="#tlformat(MARJ_ORAN)#" class="MoneyText" onchange="SatirHesaplaCanim(this)">
            <input type="hidden" name="MARJUK_#ROW_COUNT#" id="MARJUK_#ROW_COUNT#" value="#MARJ_ORAN#">
        </div>
        </td>
        <td>
            <div class="form-group">
            <input type="text" name="SalePrice_#ROW_COUNT#" class="MoneyText" style="background: ##f7f1ea !important;border: solid 1px ##c3b7a6 !important;text-align: right;" value="#TLFORMAT(SON_FIYAT)#">
            <input type="hidden" name="WrkRowId_#ROW_COUNT#" value="#WRK_ROW_ID#">
        </div>
        </td>
        <td>
            #getOfferMoney.MONEY_TYPE#
        </td>
        
    </tr>
</cfoutput>
</tbody>
<tr>
    <td colspan="12">
        Toplam
    </td>
    <td>
        <div class="form-group">
        <input type="text"  data-company_id="#COMPANY_ID#" style="background: ##f7f1ea !important;border: solid 1px ##c3b7a6 !important;text-align: right;" class="sub_total MoneyText" name="SalePriceTotal_#COMPANY_ID#" value="">
    </div>
    </td>
    <td>#getOfferMoney.MONEY_TYPE#</td>
</tr>
<tr>
    <td colspan="14">&nbsp;</td>
</tr>
</cfoutput>
<input type="hidden" name="ROW_COUNT" value="<cfoutput>#ROW_COUNT#</cfoutput>">
<tfoot>
    <th colspan="12">
        Son Toplam
    </th>
    <th>
        <div class="form-group">
        <input type="text" class="last_total MoneyText" style="background: #f7f1ea !important;border: solid 1px #c3b7a6 !important;text-align: right;" name="last_total" value="">
    </div>
</th>
<th><cfoutput>#getOfferMoney.MONEY_TYPE#</cfoutput></th>
</tfoot>
</cf_ajax_list>
</form>
<div>
    <button class="ui-wrk-btn ui-wrk-btn-success " onclick="SatisFiyatKaydet(<cfoutput>#attributes.OFFER_ID#</cfoutput>)">Kaydet</button>
    <button class="ui-wrk-btn ui-wrk-btn-warning "onclick="SatisFiyatKaydetGuncelle(<cfoutput>#attributes.OFFER_ID#</cfoutput>)">Kaydet ve Satış Teklifini Güncelle</button>
</div>
</cf_box>
<script>
SubTotalHesapla()
SonToplamHesapla()
function SatirHesaplaCanim(el, gelen) {
  // debugger;
  console.log(gelen);

  el.value = commaSplit(el.value);
  var RowId = el.getAttribute("data-row");
  var DiscountedPrice_ = document.getElementsByName(
    "DiscountedPrice_" + RowId
  )[0].value;
  console.log("1. Bölge DiscountedPrice_=" + DiscountedPrice_);
  var DiscountedPrice__ = commaSplit(DiscountedPrice_);
  console.log("2. Bölge DiscountedPrice_=" + DiscountedPrice__);
  if (DiscountedPrice__.indexOf("NaN") >= 0) {
    var DiscountedPrice = parseFloat(filterNum(DiscountedPrice_));
    console.log("3. Bölge DiscountedPrice_=" + DiscountedPrice);
  } else {
    var DiscountedPrice = parseFloat(DiscountedPrice__);
    console.log("4. Bölge DiscountedPrice_=" + DiscountedPrice);
  }
  console.log(DiscountedPrice);

  var Marj = parseFloat(filterNum(commaSplit(el.value)));
  console.log(Marj);
  $("#MARJUK_" + RowId).val(Marj);
  var SalePrice = DiscountedPrice + (DiscountedPrice * Marj) / 100;
  console.log(SalePrice);
  console.table({
    DiscountedPrice: DiscountedPrice,
    Marj: Marj,
    SalePrice: SalePrice,
    gelen: gelen,
    ev: el.value,
  });

  document.getElementsByName("SalePrice_" + RowId)[0].value =
    commaSplit(SalePrice);
  SubTotalHesapla();
  SonToplamHesapla();
  return SalePrice;
}

function  SetAllSubMarj(el) {
    console.log(el)
    el.value=commaSplit(el.value)
    var CompanyId=el.getAttribute("data-company_id")
    $("input[name='Marj_"+CompanyId+"']").val(el.value)
    var Ecount=document.getElementsByName("Marj_"+CompanyId).length
    for(let i=0;i<Ecount;i++){
        var ee=document.getElementsByName("Marj_"+CompanyId)[i];
    SatirHesaplaCanim(ee,"SetAllSubMarj")
}
    
}
function SubTotalHesapla(params) {
    var ee=document.getElementsByClassName("sub_total")
    for(let i=0;i<ee.length;i++){
        var CompanyId=ee[i].getAttribute("data-company_id")
        var Ecount=document.getElementsByName("Marj_"+CompanyId).length;
        var SubTotal=0;
        for(let j=0;j<Ecount;j++){
           var el=document.getElementsByName("Marj_"+CompanyId)[j]
            var RowId=el.getAttribute("data-row")
           
            var SalePrice_=document.getElementsByName("SalePrice_"+RowId)[0].value
            if(SalePrice_.length==0){SalePrice_="0";}
            var SalePrice=parseFloat(filterNum(commaSplit(SalePrice_)))
            SubTotal+=SalePrice;
        }
       document.getElementsByName("SalePriceTotal_"+CompanyId)[0].value=commaSplit(SubTotal)
    }
}
function SonToplamHesapla(){
    var ee=document.getElementsByClassName("sub_total")
    var SonToplam=0;
    for(let i=0;i<ee.length;i++){
        var pp_=ee[i].value
        var pp=parseFloat(filterNum(commaSplit(pp_)))
        SonToplam=SonToplam+pp
    }
    console.log(SonToplam)
    document.getElementsByName("last_total")[0].value=commaSplit(SonToplam)
}

function SatisFiyatKaydet(offer_id) {
    var FD=$("#FORM_0001").serialize()
    $.post("index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=save_purchase_price_marj&tip=1&offer_id="+offer_id+"&"+FD).done(function (params) {
        alert("Kayıt Edilmiştir");
    })
}
function SatisFiyatKaydetGuncelle(offer_id) {
    var FD=$("#FORM_0001").serialize()
    $.post("index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=save_purchase_price_marj&tip=2&offer_id="+offer_id+"&"+FD).done(function (params) {
        var rc=document.getElementsByName("ROW_COUNT")[0].value
rc=parseInt(rc);
console.log(rc)

for(let t=0;t<rc;t++){
var sp=document.getElementsByName("SalePrice_"+(t+1))[0].value;
var dp=document.getElementsByName("DiscountedPrice_"+(t+1))[0].value;
var pmm=document.getElementsByName("PPMNAY_"+(t+1))[0].value;
var wrk_id=document.getElementsByName("WrkRowId_"+(t+1))[0].value;
console.log(sp)
console.log(wrk_id)

		var SepetSeperatorler = document.getElementById("BasketArea").children;
  for (let i = 0; i < SepetSeperatorler.length; i++) {
		var Seperator = SepetSeperatorler[i];
    var PropList = Seperator.getAttribute("data-proplist");
		console.log(Seperator)
 		var Sepet = document.getElementById("SubSepetBody_" + PropList);
		for (let j = 0; j < Sepet.children.length; j++) {
      	var SepetItem = Sepet.children[j];
				var dddd=DegeriGetir(SepetItem,"UNIQUE_RELATION_ID",0)
console.log(dddd)

		if(wrk_id==dddd){
		console.warn(wrk_id)
DegeriGetir(SepetItem,"SALE_PRICE",1,1)
DegerYaz(SepetItem,"SALE_PRICE",0,sp);
DegerYaz(SepetItem,"PURCHASE_PRICE",0,dp);
DegerYaz(SepetItem,"PURCHASE_MONEY",0,pmm);
AlayiniHesapla()
}
		}
}


}
alert("Satır Verileri Değiştirilmiştir; Teklifi Güncelleyiniz");
    })

}
</script>