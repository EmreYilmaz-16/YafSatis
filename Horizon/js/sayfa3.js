var RowCount = 1;
var ServiceUri = "/AddOns/YafSatis/Partner/cfc";
$(document).ready(function () {
  var e = document.getElementById("PRODUCT_CAT");
  // var e1 = document.getElementById("MONEY");
  // var e2 = document.getElementById("PRIORITY");
  getCats(e);
});
function getCats(el) {
  $.ajax({
    url: ServiceUri + "/ProductService.cfc?method=getCats",
    success: function (returnData) {
      var Obje = JSON.parse(returnData);
      console.log(Obje);
      $(el).html("");
      for (let i = 0; i < Obje.length; i++) {
        var option = document.createElement("option");
        option.value = Obje[i].PRODUCT_CATID;
        option.innerText = Obje[i].PRODUCT_CAT;
        el.appendChild(option);
      }
    },
  });
}
function getCatProperties(cat_id) {
  /* $.ajax({
        url: ServiceUri + "/ProductService.cfc?method=getCatProperties&PRODUCT_CATID="+cat_id,
        success: function (returnData) {
          var Obje = JSON.parse(returnData);
          console.log(Obje);
          $(el).html("");
          for (let i = 0; i < Obje.length; i++) {
            var option = document.createElement("option");
            option.value = Obje[i].PRODUCT_CATID;
            option.innerText = Obje[i].PRODUCT_CAT;
            el.appendChild(option);
          }
        },font-size: 7px !important;padding: 3px 7px !important;
      });*/

  AjaxPageLoad(
    "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=catProps&PRODUCT_CATID=" +
      cat_id,
    "PROP_AREA",
    1,
    "Yükleniyor"
  );
}

function AddEquipment() {
  var elem = document.getElementById("PRODUCT_CAT");
  var ix = elem.options.selectedIndex;
  var PRODUCT_CAT = elem.options[ix].innerText;
  var PRODUCT_CAT_ID = elem.options[ix].value;

  var ReturnObject = {
    PRODUCT_CAT: PRODUCT_CAT,
    PRODUCT_CAT_ID: PRODUCT_CAT_ID,
  };
  console.table(ReturnObject);
  var SelectedValues = [];
  var ox = {
    PRODUCT_CAT: PRODUCT_CAT,
    PRODUCT_CAT_ID: PRODUCT_CAT_ID,
    PNAME: "EQUIPMENT",
  };
  SelectedValues.push(ox);
  var Properties = document.getElementsByClassName("propss");
  var PropList = "";
  PropList += PRODUCT_CAT_ID;
  //console.log(Properties)
  var DataHata=0;
  for (let i = 0; i < Properties.length; i++) {
    var Pelem = Properties[i];
    var isReq=Pelem.getAttribute("required");
    
    var Pdata = $(Pelem).select2("data")[0];
    console.log($(Pelem).select2("data")[0]);
    var PRODUCT_CAT = Pdata.text;
    var PRODUCT_CAT_ID = Pdata.id;
    var PNAME = Pdata.title;
    if (Pdata.id.length > 0) {
      var O = {
        PRODUCT_CAT: PRODUCT_CAT,
        PRODUCT_CAT_ID: PRODUCT_CAT_ID,
        PNAME: PNAME,
      };
     
      console.table(O);
      SelectedValues.push(O);
      PropList += "," + PRODUCT_CAT_ID;
    }
    if(isReq =="true" && Pdata.id.length==0){
      DataHata++;
    }
  }
  ReturnObject.Filters = SelectedValues;
  ReturnObject.PropList = PropList;
  var jsn = JSON.stringify(ReturnObject);
  if(DataHata>0){
    alert("Zorunlu Alanlar var !");
    return false;
  }
  addEqRow(ReturnObject, jsn);
}
var EqArr = [];

function addEqRow(Obj, jsn) {
  var exxx = EqArr.findIndex((p) => p == Obj.PropList);
  if (exxx != -1) {
    return false;
  }
  console.log(Obj);
  var div = document.createElement("div");
  div.setAttribute("class", "alert alert-success eq_header");
  div.setAttribute("data-PropList", Obj.PropList);
  var table = document.createElement("table");
  table.setAttribute("class", "EqTableMain");
  var tr = document.createElement("tr");
  var td = document.createElement("td");
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

  b4.innerHTML = spn;

  var b5 = document.createElement("button");
  b5.setAttribute("class", "ui-wrk-btn");
  b5.setAttribute("style", "background:#292424 !important;color:white");
  b5.innerHTML = '<span class="icn-md fa fa-trash"></span>';
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
  diva.appendChild(b1);
  diva.appendChild(b2);
  diva.appendChild(b3);
  diva.appendChild(b4);
  diva.appendChild(b5);
  td.appendChild(diva);
  tr.appendChild(td);
  var svk_st = 8;

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
    sv_kalan = sv_kalan_ * 8;
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
  var Table = document.createElement("table");
  Table.setAttribute("class", "SubSepet table");
  var thead = document.createElement("thead");
  var tr = document.createElement("tr");
  tr.appendChild(thCrate("#"));
  tr.appendChild(thCrate("Part No"));
  tr.appendChild(thCrate("Part Name"));
  tr.appendChild(thCrate("Quantity"));
  tr.appendChild(thCrate("Unit"));
  tr.appendChild(thCrate("Purchase Price"));
  tr.appendChild(thCrate("Sales Price"));
  tr.appendChild(thCrate("Sales Discount"));
  tr.appendChild(thCrate("Unit Price"));
  tr.appendChild(thCrate("Total Price"));
  tr.appendChild(thCrate("First Remark"));
  tr.appendChild(thCrate("Delivered Items"));
  tr.appendChild(thCrate("Weight"));

  thead.appendChild(tr);
  Table.appendChild(thead);
  Table.id = "SubSepet_" + Obj.PropList;
  var tbody = document.createElement("tbody");
  tbody.id = "SubSepetBody_" + Obj.PropList;
  Table.appendChild(tbody);
  div2.appendChild(Table);
  div.appendChild(div2);
  var btn =
    '<button class="ui-wrk-btn ui-wrk-btn-extra" style="position: absolute;right: 0;top: 0;"><span id="RC_' +
    Obj.PropList +
    '">0</span> Rows Listed<br><span id="TOTALE_' +
    Obj.PropList +
    '">0 €</span></button>';
  var btn =
    '<button class="ui-wrk-btn ui-wrk-btn-extra" style="position: absolute;right: 0;top: 0;"><span id="RC_' +
    Obj.PropList +
    '">0</span> Rows Listed<br><span id="TOTALE_' +
    Obj.PropList +
    '">0 €</span></button>';
  btn = $(btn)[0];
  div.appendChild(btn);
  document.getElementById("BasketArea").appendChild(div);
  EqArr.push(Obj.PropList);
}

function addRowCrs(proplist) {
  var tr = document.createElement("tr");
  var td = document.createElement("td");
  var input = document.createElement("input");
  input.type = "checkbox";
  input.name = "CBX_" + RowCount;
  input.setAttribute("class", "SatirSecCbx");
  var b1 = document.createElement("button");
  b1.setAttribute("class", "ui-wrk-btn ui-wrk-btn-warning");
  b1.setAttribute(
    "style",
    "font-size: 7px !important;padding: 3px 7px !important;"
  );
  b1.innerText = RowCount;
  var b2 = document.createElement("button");
  b2.setAttribute("class", "ui-wrk-btn ui-wrk-btn-success");
  b2.setAttribute(
    "style",
    "font-size: 7px !important;padding: 3px 7px !important;"
  );
  b2.innerText = RowCount;
  var div = document.createElement("div");
  div.setAttribute("style", "display:flex");
  div.appendChild(input);
  div.appendChild(b1);
  div.appendChild(b2);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.name = "PRODUCT_CODE_2_" + RowCount;
  input.setAttribute("proplist", proplist);
  input.setAttribute("onchange", "getProduct(this," + RowCount + ")");
  div.appendChild(input);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.name = "PRODUCT_NAME_" + RowCount;
  div.appendChild(input);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.name = "QUANTITY_" + RowCount;
  div.appendChild(input);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var input = document.createElement("select");
  input.setAttribute("type", "text");
  input.name = "PRODUCT_UNIT_" + RowCount;
  div.appendChild(input);
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
  input.name = "PURCHASE_PRICE_" + RowCount;
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = CreateOptionList(1, "");
  input.name = "PURCHASE_MONEY_" + RowCount;
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
  input.name = "SALE_PRICE_" + RowCount;
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = CreateOptionList(1, "");
  input.name = "SALE_MONEY_" + RowCount;
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
  input.name = "SALE_DISCOUNT_" + RowCount;
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = CreateOptionList(1, "");
  input.name = "SALE_DISCOUNT_MONEY_" + RowCount;
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
  input.name = "UNIT_PRICE_" + RowCount;
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = CreateOptionList(1, "");
  input.name = "UNIT_PRICE_MONEY_" + RowCount;
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
  input.name = "TOTAL_PRICE_" + RowCount;
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = CreateOptionList(1, "");
  input.name = "TOTAL_PRICE_MONEY_" + RowCount;
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
  input.name = "FIRST_REMARK_" + RowCount;
  div2.appendChild(input);
  var input = document.createElement("span");
  input.setAttribute("class", "input-group-addon btnPointer icon-remove");
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
  input.name = "DELIVERED_ITEMS_" + RowCount;
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = "";
  input.name = "DELIVERED_ITEMS_UNIT_" + RowCount;
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
  input.name = "WEIGHT_" + RowCount;
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = "";
  input.name = "WEIGHT_UNIT_" + RowCount;
  input.setAttribute("class", "input-group-text");
  div2.appendChild(input);
  div.appendChild(div2);
  td.appendChild(div);
  tr.appendChild(td);
  document.getElementById("SubSepetBody_" + proplist).appendChild(tr);
  RowCount++;
}

function thCrate(innerText) {
  var th = document.createElement("th");
  th.innerText = innerText;
  th.setAttribute("class", "tablesorter-header tablesorter-headerUnSorted");
  return th;
}

function getProduct(el, rc) {
  //"AddedEquipment_"+Obj.PropList
  var keyword = el.value;

  var pL = document
    .getElementsByName("PRODUCT_CODE_2_" + rc)[0]
    .getAttribute("proplist");
  var SearchMainValue = document.getElementById("AddedEquipment_" + pL).value;
  SearchMainValue = JSON.parse(SearchMainValue);
  var Search = {
    SearchMainValue: SearchMainValue,
    keyword: keyword,
  };

  $.ajax({
    url: ServiceUri + "/ProductService.cfc?method=SearchProduct",
    data: {
      FormData: JSON.stringify(Search),
    },
    success: function (returnData) {
      var Obje = JSON.parse(returnData);

      if (Obje.RECORD_COUNT >= 1) {
        if (Obje.RECORD_COUNT > 1) {
          el.setAttribute("style", "color:orange;font-weight:bold");
          var btn=document.createElement("button");
          btn.setAttribute("class","btn btn-warning");
          el.parentElement.appendChild(btn);
          el.parentElement.setAttribute("style","display:flex");
        } else {
          el.setAttribute("style", "color:green;font-weight:bold");
        }
        document.getElementsByName("PRODUCT_NAME_" + rc)[0].value =
          Obje.PRODUCT_NAME;
        document.getElementsByName("QUANTITY_" + rc)[0].value = 1;
        document.getElementsByName("PRODUCT_UNIT_" + rc)[0].innerHTML =
          '<option value="' +
          Obje.MAIN_UNIT +
          '">' +
          Obje.MAIN_UNIT +
          "</option>";
        document.getElementsByName("PURCHASE_PRICE_" + rc)[0].value = 0;
        document.getElementsByName("SALE_PRICE_" + rc)[0].value = 0;
        document.getElementsByName("SALE_DISCOUNT_" + rc)[0].value = 0;
        document.getElementsByName("UNIT_PRICE_" + rc)[0].value = 0;
        document.getElementsByName("TOTAL_PRICE_" + rc)[0].value = 0;
        document.getElementsByName("DELIVERED_ITEMS_" + rc)[0].value = 0;
        document.getElementsByName("DELIVERED_ITEMS_UNIT_" + rc)[0].innerHTML =
          '<option value="' +
          Obje.MAIN_UNIT +
          '">' +
          Obje.MAIN_UNIT +
          "</option>";

        document.getElementsByName("WEIGHT_" + rc)[0].value = 0;
      } else {
        el.setAttribute("style", "color:red;font-weight:bold");
      }
    },
  });
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
    console.log(ReturnStr);
    var o = $("ReturnStr");
    return ReturnStr;
    console.log(o);
  }
}
/**
 * 
 * <table class="table table-bordered">
<tr>
<th>#</th>
<th>Part No</th>
<th>Part Name</th>
<th>Quantity</th>
<th>Unit</th>
<th>Purchase Price</th>
<th>Sales Price</th>
<th>Sales Discount</th>
<th>Unit Price</th>
<th>Total Price</th>
<th>First Remark</th>
<th>Delivered Items</th>
<th>Weight</th>
</tr>
<tr>	     
     
  	
  	
   
 
  
  
 
 
         	<td>
    	<div class="form-group">
        	<div class="input-group">
        <input type="text" class="form-control"  name="WEIGHT">
        	<select class="input-group-text" name="WEIGHT_UNIT">
            <option value="KG">KG</option>
            <option value="GR">GR</option>
            </select>
            </div>
        </div>
    </td>
</tr>

</table>
 * 
 * 
 */
