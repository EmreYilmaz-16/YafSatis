<cfset attributes.offer_id=32>
<CFSET OfferService=createObject("component","AddOns.YafSatis.Partner.cfc.OfferService")>

<cfset _OfferData=OfferService.getPurchaseOffer(attributes.offer_id)>
<cfset OfferData=deserializeJSON(_OfferData)>
<cfset MoneyArr=deserializeJSON(OfferService.getOfferMoney())>

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
        <input type="text" name="GENERAL_DISCOUNT">
    </div>    
    <div class="form-group">
        <label>Currency</label>
        <select name="MONEY">
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
    sv_kalan_ = 12 - Obj.Filters.length;
    sv_kalan = sv_kalan_ * 10;
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
</script>