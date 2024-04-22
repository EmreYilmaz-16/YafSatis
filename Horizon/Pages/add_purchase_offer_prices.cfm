
<cfset attributes.offer_id=32>


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
<script>
var AktifSepet = [];
var OfferSettings = {
  IS_TAX_ZERO: 1,
};
var EqArr = [];
var RowCount = 1;
    function addEqRow(Obj, jsn) {
  var exxx = EqArr.findIndex((p) => p == Obj.PropList);
  if (exxx != -1) {
    return false;
  }
  //console.log(Obj);
  var div = document.createElement("div");

  div.setAttribute("class", "alert alert-success eq_header");
  div.setAttribute("style", "position:relative");
  div.setAttribute("data-PropList", Obj.PropList);
  var table = document.createElement("table");
  table.setAttribute("class", "EqTableMain");
  var tr = document.createElement("tr");
  var td = document.createElement("td");
  var b0 = document.createElement("button");
  b0.setAttribute("class", "ui-wrk-btn");
  var spn = '<span class="icn-md icon-down"></span>';
  b0.innerHTML = spn;
  b0.setAttribute("onclick", "$('#SLO_'" + Obj.PropList + ").toggle()");
  var b1 = document.createElement("button");
  b1.setAttribute("class", "ui-wrk-btn ui-wrk-btn-extra");
  var spn = '<span class="icn-md fa fa-check-square-o"></span>';
  b1.innerHTML = spn;
  var b2 = document.createElement("button");
  b2.setAttribute("class", "ui-wrk-btn ui-wrk-btn-success");
  var spn = '<span class="icn-md fa fa-plus"></span>';
  b2.innerHTML = spn;
  b2.setAttribute("onclick", "addRowCrs('" + Obj.PropList + "')");

  var b3 = document.createElement("button");
  b3.setAttribute("class", "ui-wrk-btn ui-wrk-btn-warning");
  var spn = '<span class="icn-md fa fa-edit"></span>';
  b3.innerHTML = spn;

  var b4 = document.createElement("button");
  b4.setAttribute("class", "ui-wrk-btn ui-wrk-btn-red");
  var spn = '<span class="icn-md icon-remove"></span>';
  b4.setAttribute("onclick", "SeciliSil('" + Obj.PropList + "')");
  b4.innerHTML = spn;

  var b5 = document.createElement("button");
  b5.setAttribute("class", "ui-wrk-btn ");
  b5.setAttribute("style", "background:#292424 !important;color:white");
  b5.setAttribute("onclick", "SeperatorSil('" + Obj.PropList + "')");
  b5.innerHTML = '<span class="icn-md fa fa-trash"></span>';

  var b6 = document.createElement("button");
  b6.setAttribute("class", "ui-wrk-btn ui-wrk-btn-extra");

  b6.innerHTML = '<span class="icn-md icon-filter"></span>';
  b6.setAttribute("onclick", "lookProducts('" + Obj.PropList + "')");
  var diva = document.createElement("div");
  diva.setAttribute("style", "display:flex");
  b1.setAttribute(
    "style",
    "font-size: 7px !important;padding: 3px 7px !important;"
  );
  b2.setAttribute(
    "style",
    "font-size: 7px !important;padding: 3px 7px !important;"
  );
  b3.setAttribute(
    "style",
    "font-size: 7px !important;padding: 3px 7px !important;"
  );
  b4.setAttribute(
    "style",
    "font-size: 7px !important;padding: 3px 7px !important;"
  );
  b5.setAttribute(
    "style",
    "font-size: 7px !important;padding: 3px 7px !important;"
  );
  b6.setAttribute(
    "style",
    "font-size: 7px !important;padding: 3px 7px !important;"
  );
  diva.appendChild(b1);
  diva.appendChild(b2);
  diva.appendChild(b3);
  diva.appendChild(b4);
  diva.appendChild(b5);
  diva.appendChild(b6);
  //td.appendChild(diva);
  var input = document.createElement("input");
  input.id = "SeperatorRC_" + Obj.PropList;
  input.name = "SeperatorRC_" + Obj.PropList;
  input.type = "hidden";
  input.value = 1;
  td.appendChild(input);
  tr.appendChild(td);
  var svk_st = 10;

  for (let index = 0; index < Obj.Filters.length; index++) {
    const element = Obj.Filters[index];
    var td = document.createElement("td");
    td.setAttribute("style", "border-right:solid 1px;width:" + svk_st + "%");
    var spnT =
      "<span style='font-weight:bold'>" +
      element.PNAME +
      "</span></br><span>" +
      element.PRODUCT_CAT +
      "</span>";
    td.innerHTML = spnT;
    tr.appendChild(td);
  }
  var sv_kalan_ = 0;
  var sv_kalan = 0;
  if (Obj.Filters.length < 12) {
    sv_kalan_ = 100 - (Obj.Filters.length*svk_st)
    sv_kalan = sv_kalan_
    var td = document.createElement("td");
    td.setAttribute("style", "width:" + sv_kalan + "%");
    tr.appendChild(td);
  }

  table.appendChild(tr);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.value = jsn;
  input.name = "AddedEquipment";
  input.id = "AddedEquipment_" + Obj.PropList;
  div.appendChild(input);
  div.appendChild(table);
  var div2 = document.createElement("div");
  div2.setAttribute("style", "background:white");
  div2.setAttribute("id", "SLO_" + Obj.PropList);
  var Table = document.createElement("table");
  Table.setAttribute("class", "SubSepet table");
  var thead = document.createElement("thead");
  var tr = document.createElement("tr");
  tr.appendChild(thCrate("#",true));
  tr.appendChild(thCrate("Part No",true));
  tr.appendChild(thCrate("Part Name",true));
  tr.appendChild(thCrate("Quantity",true));
  tr.appendChild(thCrate("Unit",true));
  tr.appendChild(thCrate("Purchase Price",false));
  tr.appendChild(thCrate("Sales Price",true));
  tr.appendChild(thCrate("Sales Discount",false));
  tr.appendChild(thCrate("Unit Price",true));
  tr.appendChild(thCrate("Total Price",false));
  tr.appendChild(thCrate("First Remark",true));
  tr.appendChild(thCrate("Delivered Items",false));
  tr.appendChild(thCrate("Weight",true));

  thead.appendChild(tr);
  Table.appendChild(thead);
  Table.id = "SubSepet_" + Obj.PropList;
  var tbody = document.createElement("tbody");
  tbody.id = "SubSepetBody_" + Obj.PropList;
  Table.appendChild(tbody);
  div2.appendChild(Table);
  div.appendChild(div2);
  var btn =
    '<button class="ui-wrk-btn ui-wrk-btn-extra" style="position: absolute;right: 0;top: 0;display:none"><span id="RC_' +
    Obj.PropList +
    '">0</span> Rows Listed<br><span id="TOTALE_' +
    Obj.PropList +
    '">0 ' +
    OfferData.OTHER_MONEY +
    "</span></button>";
  var btn =
    '<button class="ui-wrk-btn ui-wrk-btn-extra" style="position: absolute;right: 0;top: 0;display:none"><span id="RC_' +
    Obj.PropList +
    '">0</span> Rows Listed<br><span id="TOTALE_' +
    Obj.PropList +
    '">0 ' +
    OfferData.OTHER_MONEY +
    "</span></button>";
  btn = $(btn)[0];
  
  div.appendChild(btn);
  
  document.getElementById("BasketArea").appendChild(div);
  EqArr.push(Obj.PropList);
}
//addRowCrs('32,50004,50005', "10",  "10",  "Anti-polishing ring", 0,  "100 003",  1,  "Adet",  0,  "TL",  200,  0, 200,  200,  "",0,0)
function addRowCrs(
  proplist,
  PRODUCT_ID = "",
  STOCK_ID = "",
  PRODUCT_NAME = "",
  TAX,
  MANUFACT_CODE = "",
  QUANTITY = 1,
  PRODUCT_UNIT = "",
  PURCHASE_PRICE = 0,
  PURCHASE_MONEY = "",
  SALE_PRICE = 0,
  SALE_DISCOUNT = 0,
  UNIT_PRICE = 0,
  TOTAL_PRICE = 0,
  FIRST_REMARK = "",
  DELIVERED_ITEMS = 0,
  WEIGHT = 0,
  IS_VIRTUAL = 0,
  UNIQUE_RELATION_ID = ""
) {
  $("#SLO_" + proplist).show();
  var tr = document.createElement("tr");
  var td = document.createElement("td");
  td.setAttribute("style","vertical-align:middle;font-weight:bold");
  var input = document.createElement("input");
  input.type = "checkbox";
  input.name = "CBX";
  input.id = "CBX_" + RowCount;
  input.setAttribute("class", "SatirSecCbx");
  var input2 = document.createElement("input");
  input2.type = "hidden";
  input2.name = "IS_VIRTUAL";
  input2.id = "IS_VIRTUAL_" + RowCount;
  input2.value = IS_VIRTUAL;
  var input3 = document.createElement("input");
  input3.type = "hidden";
  input3.name = "UNIQUE_RELATION_ID";
  input3.id = "UNIQUE_RELATION_ID_" + RowCount;
  if (UNIQUE_RELATION_ID.length > 0) {
    input3.value = UNIQUE_RELATION_ID;
  } else {
    input3.value = GenerateUniqueId();
  }
  var b1 = document.createElement("span");
  
  
  b1.innerText = RowCount;
  var b2 = document.createElement("span");
  
  
  var rc2 = document.getElementById("SeperatorRC_" + proplist).value;
  rc2 = parseInt(rc2);

  b2.innerText = rc2;
  
  var div = document.createElement("div");
  div.setAttribute("style", "display:flex");
  
  div.appendChild(input2);
  div.appendChild(input3);
  div.appendChild(b1);
  
  rc2++;
  td.appendChild(div);
  tr.appendChild(td);
  document.getElementById("SeperatorRC_" + proplist).value = rc2;
  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var input = document.createElement("input");
  input.setAttribute("type", "text");

  input.name = "PRODUCT_CODE_2";
  input.value = MANUFACT_CODE;
  input.id = "PRODUCT_CODE_2_" + RowCount;
  input.setAttribute("proplist", proplist);
  input.setAttribute("readonly","true");
  div.appendChild(input);
  var input = document.createElement("input");
  input.type = "hidden";
  input.name = "PRODUCT_ID";
  input.id = "PRODUCT_ID_" + RowCount;
  input.value = PRODUCT_ID;
  div.appendChild(input);
  var input = document.createElement("input");
  input.type = "hidden";
  input.name = "STOCK_ID";
  input.id = "STOCK_ID_" + RowCount;
  input.value = STOCK_ID;
  div.appendChild(input);

  var input = document.createElement("input");
  input.type = "hidden";
  input.name = "TAX";
  input.value = TAX;
  input.id = "TAX_" + RowCount;
  div.appendChild(input);

  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.name = "PRODUCT_NAME";
  input.value = PRODUCT_NAME;
  input.id = "PRODUCT_NAME_" + RowCount;
  input.setAttribute("style", "text-align:left");
  div.appendChild(input);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.name = "QUANTITY";

  input.id = "QUANTITY_" + RowCount;
  input.value = commaSplit(QUANTITY);
  input.setAttribute("onchange", "AlayiniHesapla()");
  div.appendChild(input);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var input = document.createElement("select");
  var opt = document.createElement("option");
  opt.value = PRODUCT_UNIT;
  opt.innerText = PRODUCT_UNIT;

  input.name = "PRODUCT_UNIT";

  input.id = "PRODUCT_UNIT_" + RowCount;
  input.appendChild(opt);
  div.appendChild(input);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  td.setAttribute("style","display:none")
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var div2 = document.createElement("div");
  div2.setAttribute("class", "input-group");
  div2.setAttribute("style", "display:flex");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.name = "PURCHASE_PRICE";
  input.id = "PURCHASE_PRICE_" + RowCount;
  input.value = commaSplit(PURCHASE_PRICE);
  div2.appendChild(input);
  var input = document.createElement("select");
  if (PURCHASE_MONEY.length == 0) {
    PURCHASE_MONEY = OfferData.OTHER_MONEY;
  }
  input.innerHTML = CreateOptionList(1, PURCHASE_MONEY);
  input.name = "PURCHASE_MONEY";
  input.id = "PURCHASE_MONEY_" + RowCount;
  input.setAttribute("class", "input-group-text");
  div2.appendChild(input);
  div.appendChild(div2);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var div2 = document.createElement("div");
  div2.setAttribute("class", "input-group");
  div2.setAttribute("style", "display:flex");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.name = "SALE_PRICE";
  input.id = "SALE_PRICE_" + RowCount;
  input.value = commaSplit(SALE_PRICE);
  input.setAttribute("onchange", "AlayiniHesapla()");
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = CreateOptionList(1, OfferData.OTHER_MONEY);
  input.name = "SALE_MONEY";
  input.id = "SALE_MONEY_" + RowCount;
  input.setAttribute("disabled", "yes");
  input.setAttribute("class", "input-group-text");
  div2.appendChild(input);
  div.appendChild(div2);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  td.setAttribute("style","display:none")
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var div2 = document.createElement("div");
  div2.setAttribute("class", "input-group");
  div2.setAttribute("style", "display:flex");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.name = "SALE_DISCOUNT";
  input.id = "SALE_DISCOUNT_" + RowCount;
  input.value = commaSplit(SALE_DISCOUNT);
  input.setAttribute("onchange", "AlayiniHesapla()");
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = CreateOptionList(1, OfferData.OTHER_MONEY);
  input.name = "SALE_DISCOUNT_MONEY";
  input.setAttribute("disabled", "yes");
  input.id = "SALE_DISCOUNT_MONEY_" + RowCount;
  input.setAttribute("class", "input-group-text");
  div2.appendChild(input);
  div.appendChild(div2);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var div2 = document.createElement("div");
  div2.setAttribute("class", "input-group");
  div2.setAttribute("style", "display:flex");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.name = "UNIT_PRICE";
  input.id = "UNIT_PRICE_" + RowCount;
  input.value = commaSplit(UNIT_PRICE);
  input.setAttribute("readonly", "yes");
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = CreateOptionList(1, OfferData.OTHER_MONEY);
  input.name = "UNIT_PRICE_MONEY";
  input.id = "UNIT_PRICE_MONEY_" + RowCount;
  input.setAttribute("class", "input-group-text");
  input.setAttribute("disabled", "yes");
  div2.appendChild(input);
  div.appendChild(div2);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  td.setAttribute("style","display:none")
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var div2 = document.createElement("div");
  div2.setAttribute("class", "input-group");
  div2.setAttribute("style", "display:flex");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.name = "TOTAL_PRICE";

  input.id = "TOTAL_PRICE_" + RowCount;
  input.setAttribute("readonly", "yes");
  input.value = commaSplit(TOTAL_PRICE);
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = CreateOptionList(1, OfferData.OTHER_MONEY);
  input.name = "TOTAL_PRICE_MONEY";
  input.id = "TOTAL_PRICE_MONEY_" + RowCount;
  input.setAttribute("disabled", "yes");
  input.setAttribute("class", "input-group-text");
  div2.appendChild(input);
  div.appendChild(div2);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var div2 = document.createElement("div");
  div2.setAttribute("class", "input-group");
  div2.setAttribute("style", "display:flex");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.name = "FIRST_REMARK";
  input.value = FIRST_REMARK;
  input.id = "FIRST_REMARK_" + RowCount;
  div2.appendChild(input);
  var input = document.createElement("span");
  input.setAttribute("class", "input-group-addon btnPointer icon-remove");
  div2.appendChild(input);
  div.appendChild(div2);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  td.setAttribute("style","display:none")
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var div2 = document.createElement("div");
  div2.setAttribute("class", "input-group");
  div2.setAttribute("style", "display:flex");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.name = "DELIVERED_ITEMS";
  input.id = "DELIVERED_ITEMS_" + RowCount;
  input.value = commaSplit(DELIVERED_ITEMS);
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = "";
  input.name = "DELIVERED_ITEMS_UNIT";
  input.id = "DELIVERED_ITEMS_UNIT_" + RowCount;
  input.setAttribute("class", "input-group-text");
  div2.appendChild(input);
  div.appendChild(div2);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var div2 = document.createElement("div");
  div2.setAttribute("class", "input-group");
  div2.setAttribute("style", "display:flex");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.name = "WEIGHT";
  input.id = "WEIGHT_" + RowCount;
  input.value = commaSplit(WEIGHT);
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = "";
  input.name = "WEIGHT_UNIT";
  input.id = "WEIGHT_UNIT_" + RowCount;
  input.setAttribute("class", "input-group-text");
  div2.appendChild(input);
  div.appendChild(div2);
  td.appendChild(div);
  tr.appendChild(td);
  document.getElementById("SubSepetBody_" + proplist).appendChild(tr);
  RowCount++;
}

function thCrate(innerText,dn) {
  var th = document.createElement("th");
  th.innerText = innerText;
  if(dn){
  th.setAttribute("class", "tablesorter-header tablesorter-headerUnSorted");}else{
    th.setAttribute("class", "tablesorter-header tablesorter-headerUnSorted");
th.setAttribute("style","display:none");
}
  return th;
}
function CreateOptionList(tip, selval = "EUR") {
  if (tip == 1) {
    var paraBirimleri = wrk_safe_query("getMoneyList", "dsn");
    var array = paraBirimleri.MONEY;
    var ReturnStr = "";
    for (let index = 0; index < array.length; index++) {
      const element = array[index];
      if (selval == element) {
        ReturnStr +=
          "<option  selected value='" + element + "'>" + element + "</option>";
      } else {
        ReturnStr +=
          "<option  value='" + element + "'>" + element + "</option>";
      }
    }
    //console.log(ReturnStr);
    var o = $("ReturnStr");
    return ReturnStr;
    console.log(o);
  }
}

function AlayiniHesapla() {
  AktifSepet = [];
  OrderFooter = {
    total_default: 0,
    genel_indirim_: 0,
    total_discount_wanted: 0,
    brut_total_wanted: 0,
    total_tax_wanted: 0,
    net_total_wanted: 0,
    other_money: "TL",
  };
  var SepetSeperatorler = document.getElementById("BasketArea").children;
  for (let i = 0; i < SepetSeperatorler.length; i++) {
    var Seperator = SepetSeperatorler[i];
    var PropList = Seperator.getAttribute("data-proplist");
    var JSON_STRINGIM_ = document.getElementById(
      "AddedEquipment_" + PropList
    ).value;
    var JSON_STRINGIM = JSON.parse(JSON_STRINGIM_);
    // console.log(PropList)
    var Sepet = document.getElementById("SubSepetBody_" + PropList);
    var SeperatorToplam = 0;
    var Jcount = Sepet.children.length;
    document.getElementById("RC_" + PropList).innerText = Jcount;
    var SEPET_SIRA = 0;
    var AKTIF_KUR = KurGetir(document.getElementById("MONEY").value);
    //console.table(AKTIF_KUR);
    for (let j = 0; j < Sepet.children.length; j++) {
      var SepetItem = Sepet.children[j];
      SEPET_SIRA++;
      // console.log(SepetItem)
      var PRODUCT_ID = DegeriGetir(SepetItem, "PRODUCT_ID", 1);
      var IS_VIRTUAL = DegeriGetir(SepetItem, "IS_VIRTUAL", 1);
      var PRODUCT_NAME = DegeriGetir(SepetItem, "PRODUCT_NAME", 0);
      var PRODUCT_CODE_2 = DegeriGetir(SepetItem, "PRODUCT_CODE_2", 0);

      var TAX_RATE = 0;
      if (OfferSettings.IS_TAX_ZERO == 0)
        TAX_RATE = DegeriGetir(SepetItem, "TAX", 2, 0);
      var STOCK_ID = DegeriGetir(SepetItem, "STOCK_ID", 1);
      var AMOUNT = DegeriGetir(SepetItem, "QUANTITY", 2, 1);
      var PRODUCT_UNIT = DegeriGetir(SepetItem, "PRODUCT_UNIT", 0);
      var PURCHASE_PRICE = DegeriGetir(SepetItem, "PURCHASE_PRICE", 2, 1);
      var PURCHASE_MONEY = DegeriGetir(SepetItem, "PURCHASE_MONEY", 0);
      var SALE_PRICE = DegeriGetir(SepetItem, "SALE_PRICE", 2, 1);
      var SALE_MONEY = DegeriGetir(SepetItem, "SALE_MONEY", 0);
      var disc_=document.getElementById("GENERAL_DISCOUNT").value
      var disc=parseFloat(filterNum(commaSplit(disc_)))
      var Hdisc=(SALE_PRICE*disc)/100
      DegerYaz(SepetItem,"SALE_DISCOUNT",Hdisc);
      var SALE_DISCOUNT = DegeriGetir(SepetItem, "SALE_DISCOUNT", 2, 1);
      var UNIQUE_RELATION_ID = DegeriGetir(SepetItem, "UNIQUE_RELATION_ID", 0);
      var SALE_DISCOUNT_MONEY = DegeriGetir(
        SepetItem,
        "SALE_DISCOUNT_MONEY",
        0,
        0
      );
      var TOTAL_PRICE_MONEY = DegeriGetir(SepetItem, "TOTAL_PRICE_MONEY", 0, 0);
      var UNIT_PRICE = SALE_PRICE - SALE_DISCOUNT;
      DegerYaz(SepetItem, "UNIT_PRICE", 2, UNIT_PRICE);
      var TOTAL_PRICE = 0;
      if (AKTIF_KUR.MONEY == TOTAL_PRICE_MONEY) {
        TOTAL_PRICE = UNIT_PRICE * AMOUNT;
      } else {
        var Cx = MONEY_ARR.findIndex((p) => p.MONEY == TOTAL_PRICE_MONEY);
        var SatirKur = MONEY_ARR[Cx];
        var CRROS_RATE = AKTIF_KUR.RATE2 / SatirKur.RATE2;
        //console.log(CRROS_RATE);
        TOTAL_PRICE = UNIT_PRICE * AMOUNT * CRROS_RATE;
      }

      var PRICE_OTHER = SALE_PRICE;
      var PRICE = SALE_PRICE * AKTIF_KUR.RATE2;

      DegerYaz(SepetItem, "TOTAL_PRICE", 2, TOTAL_PRICE);
      var TL_TOTAL_PRICE = UNIT_PRICE * AMOUNT * AKTIF_KUR.RATE2;

      var TAX = (TL_TOTAL_PRICE * TAX_RATE) / 100;
      var WITH_TAX = TL_TOTAL_PRICE + TAX;

      var Urun = {
        PRODUCT_ID: PRODUCT_ID,
        STOCK_ID: STOCK_ID,
        PRODUCT_NAME: PRODUCT_NAME,
        PRODUCT_CODE_2: PRODUCT_CODE_2,
        AMOUNT: AMOUNT,
        PRICE_OTHER: PRICE_OTHER, //workcube standart alan
        PRICE: PRICE, //workcube standart alan
        OTHER_MONEY: OfferData.OTHER_MONEY, //WORKCUBE STANDART ALAN
        OTHER_MONEY_VALUE: TOTAL_PRICE, //WORKCUBE STANDART ALAN
        DISCOUNT_COST: SALE_DISCOUNT, //WORKCUBE STANDART ALAN
        TL_TOTAL_PRICE: TL_TOTAL_PRICE,
        PRODUCT_UNIT: PRODUCT_UNIT,
        PURCHASE_PRICE: PURCHASE_PRICE,
        PURCHASE_MONEY: PURCHASE_MONEY,
        SALE_PRICE: SALE_PRICE,
        SALE_PRICE: SALE_PRICE,
        SALE_MONEY: SALE_MONEY,
        IS_VIRTUAL: IS_VIRTUAL,
        UNIQUE_RELATION_ID: UNIQUE_RELATION_ID,
        SALE_DISCOUNT: SALE_DISCOUNT,
        PROP_LIST: PropList,
        JSON_STRINGIM: JSON_STRINGIM,
        SALE_DISCOUNT_MONEY: SALE_DISCOUNT_MONEY,
        UNIT_PRICE: UNIT_PRICE,
        TOTAL_PRICE: TOTAL_PRICE,
        TOTAL_PRICE_MONEY: TOTAL_PRICE_MONEY,
        TAX_RATE: TAX_RATE,
        TAX: TAX,
        WITH_TAX: WITH_TAX,
        RATE2: AKTIF_KUR.RATE2,
        SEPET_SIRA: SEPET_SIRA,
      };

      Urun.TLF = Urun.OTHER_MONEY_VALUE * AKTIF_KUR.RATE2;
      if (Urun.TOTAL_PRICE_MONEY == AKTIF_KUR.MONEY) {
        SeperatorToplam += Urun.TOTAL_PRICE;
      } else {
        var cbx = MONEY_ARR.findIndex((p) => p.MONEY == Urun.TOTAL_PRICE_MONEY);
        var r2 = MONEY_ARR[cbx].RATE2;
        SeperatorToplam += Urun.TOTAL_PRICE * r2;
      }

      OrderFooter.total_default += Urun.PRICE_OTHER * AMOUNT;
      OrderFooter.total_discount_wanted +=
        Urun.PRICE_OTHER * Urun.AMOUNT - Urun.UNIT_PRICE * Urun.AMOUNT;
      AktifSepet.push(Urun);
    }
    // document.getElementById("TOTALE_" + PropList).innerText =
    //   commaSplit(SeperatorToplam);
    OrderFooter.TOTAL_PRICE += SeperatorToplam;
  }
  //console.table(AktifSepet);
  var FlDis = document.getElementById("genel_indirim_").value;
  if (FlDis.length > 0) {
    FlDis = filterNum(commaSplit(FlDis));
    FlDis = parseFloat(FlDis);
    document.getElementById("genel_indirim_").value = commaSplit(FlDis);
    OrderFooter.genel_indirim_ = FlDis;
  } else {
    document.getElementById("genel_indirim_").value = commaSplit(0);
    FlDis = 0;
    OrderFooter.genel_indirim_ = FlDis;
  }
  OrderFooter.total_discount_wanted += FlDis;
  OrderFooter.brut_total_wanted =
    OrderFooter.total_default - OrderFooter.total_discount_wanted;
  OrderFooter.total_tax_wanted = 0;
  OrderFooter.net_total_wanted =
    OrderFooter.total_default -
    OrderFooter.total_discount_wanted +
    OrderFooter.total_tax_wanted;
 OzetOlustur();
}
function KurGetir(money) {
  var ix = MONEY_ARR.findIndex((p) => p.MONEY == money);
  return MONEY_ARR[ix];
}

function DegeriGetir(Satir, Name, tip = 0, up_row = 0) {
  // console.log(arguments)
  var DonusDegeri = $(Satir)
    .find("input[name='" + Name + "']")
    .val();
  var DVX = 0;
  if (DonusDegeri) {
    if (tip == 0) {
      DVX = DonusDegeri;
    } else if (tip == 1) {
      DVX = parseInt(DonusDegeri);
    } else if (tip == 2) {
      DVX = parseFloat(filterNum(commaSplit(DonusDegeri)));
    }
    if (up_row == 1) {
      if (tip == 2 || tip == 1) {
        $(Satir)
          .find("input[name='" + Name + "']")
          .val(commaSplit(DVX));
      }
    }
  } else {
    var DonusDegeri = $(Satir)
      .find("select[name='" + Name + "']")
      .val();
    if (tip == 0) {
      DVX = DonusDegeri;
    } else if (tip == 1) {
      DVX = parseInt(DonusDegeri);
    } else if (tip == 2) {
      DVX = parseFloat(filterNum(commaSplit(DonusDegeri)));
    }
  }
  return DVX;
}
function DegerYaz(Satir, Name, tip = 0, vals) {
  console.log(arguments);
    var DonusDegeri = $(Satir).find("input[name='" + Name + "']")[0];
  var DVX = 0;
  if (DonusDegeri) {
    if (tip == 0) {
      DVX = vals;
    } else if (tip == 1) {
      DVX = commaSplit(vals);
    } else if (tip == 2) {
      DVX = commaSplit(vals);
    }
  } else {
    DonusDegeri = $(Satir).find("select[name='" + Name + "']")[0];
    if (tip == 0) {
      DVX = vals;
    } else if (tip == 1) {
      DVX = parseInt(vals);
    } else if (tip == 2) {
      DVX = parseFloat(filterNum(commaSplit(vals)));
    }
  }
  $(DonusDegeri).val(DVX);
}

function OzetOlustur() {
  
  var AKTIF_KUR = KurGetir(document.getElementById("MONEY").value);
  $("#brut_total_wanted").val(commaSplit(OrderFooter.brut_total_wanted));
  $("#brut_total_wanted_").val(
    commaSplit(OrderFooter.brut_total_wanted * AKTIF_KUR.RATE2)
  );
  $("#genel_indirim_").val(commaSplit(OrderFooter.genel_indirim_));
  $("#genel_indirim__").val(
    commaSplit(OrderFooter.genel_indirim_ * AKTIF_KUR.RATE2)
  );
  $("#net_total_wanted").val(commaSplit(OrderFooter.net_total_wanted));
  $("#net_total_wanted_").val(
    commaSplit(OrderFooter.net_total_wanted * AKTIF_KUR.RATE2)
  );
  $("#total_default").val(commaSplit(OrderFooter.total_default));
  $("#total_default_").val(
    commaSplit(OrderFooter.total_default * AKTIF_KUR.RATE2)
  );
  $("#total_discount_wanted").val(
    commaSplit(OrderFooter.total_discount_wanted)
  );
  $("#total_discount_wanted_").val(
    commaSplit(OrderFooter.total_discount_wanted * AKTIF_KUR.RATE2)
  );
  $("#total_tax_wanted").val(commaSplit(OrderFooter.total_tax_wanted));
  $("#total_tax_wanted_").val(
    commaSplit(OrderFooter.total_tax_wanted * AKTIF_KUR.RATE2)
  );

  OrderFooter.brut_total_wanted_ =
    OrderFooter.brut_total_wanted * AKTIF_KUR.RATE2;
  OrderFooter.genel_indirim__ = OrderFooter.genel_indirim_ * AKTIF_KUR.RATE2;
  OrderFooter.net_total_wanted_ =
    OrderFooter.net_total_wanted * AKTIF_KUR.RATE2;
  OrderFooter.total_default_ = OrderFooter.total_default * AKTIF_KUR.RATE2;
  OrderFooter.total_discount_wanted_ =
    OrderFooter.total_discount_wanted * AKTIF_KUR.RATE2;
  OrderFooter.total_tax_wanted_ =
    OrderFooter.total_tax_wanted * AKTIF_KUR.RATE2;
}
function indirimYuzdeHesap(){
    var disc_=document.getElementById("GENERAL_DISCOUNT").value
var disc=parseFloat(filterNum(commaSplit(disc_)))
var BasketItems=document.getElementsByClassName("SubSepet")
for(let i=0;i<BasketItems.length;i++){
 var Rows=BasketItems[i].tBodies[i].children;
    for(let j=0;j<Rows.length;j++){
        var PRC=document.getElementById("SALE_PRICE_"+(j+1)).value;
        PRC=parseFloat(filterNum(commaSplit(PRC)))
        console.log(PRC)
        var Hdisc=(PRC*disc)/100
        console.log(Hdisc)
        document.getElementById("SALE_DISCOUNT_"+(j+1)).value=commaSplit(Hdisc)
        AlayiniHesapla()
    }
}
}
</script>