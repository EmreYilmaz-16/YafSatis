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
        },
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
  //console.log(Properties)
  for (let i = 0; i < Properties.length; i++) {
    var Pelem = Properties[i];
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
  }
  ReturnObject.Filters = SelectedValues;
  ReturnObject.PropList = PropList;
  var jsn = JSON.stringify(ReturnObject);
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
  div.appendChild(input);
  div.appendChild(table);
  var div2 = document.createElement("div");
  div2.setAttribute("class", "ui-scroll");
  var Table = document.createElement("table");
  Table.setAttribute(
    "class",
    "SubSepet ui-table-list ui-form tablesorter tablesorter-default"
  );
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
  tr.setAttribute("class", "tablesorter-headerRow");
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
  b1.innerText = RowCount;
  var b2 = document.createElement("button");
  b2.setAttribute("class", "ui-wrk-btn ui-wrk-btn-success");
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
  input.name = "PRODUCT_CODE_2_" + RowCount;
  input.setAttribute("onchange", "getProduct(this," + RowCount + ")");
  div.appendChild(input);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var input = document.createElement("input");
  input.name = "PRODUCT_NAME_" + RowCount;
  div.appendChild(input);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var input = document.createElement("input");
  input.name = "QUANTITY_" + RowCount;
  div.appendChild(input);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var input = document.createElement("select");
  input.name = "PRODUCT_UNIT_" + RowCount;
  div.appendChild(input);
  td.appendChild(div);
  tr.appendChild(td);

  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var div2 = document.createElement("div");
  div2.setAttribute("class", "input-group");
  var input = document.createElement("input");
  input.type = "textbox";
  input.name = "PURCHASE_PRICE_" + RowCount;
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML(CreateOptionList(1, ""));
  input.name = "PURCHASE_MONEY_" + RowCount;
  input.setAttribute("class", "input-group-text");
  div2.appendChild(input);
  div.appendChild(div2);
  td.appendChild(div);
  tr.appendChild(td);

  document.getElementById("SubSepetBody_"+proplist).appendChild(tr);
}

function thCrate(innerText) {
  var th = document.createElement("th");
  th.innerText = innerText;
  th.setAttribute("class", "tablesorter-header tablesorter-headerUnSorted");
  return th;
}

function getProduct(el, rc) {}

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
        <input type="text" class="form-control"  name="PURCHASE_PRICE">
        	<select class="input-group-text" name="PURCHASE_PRICE_MONEY">
            <option value="EUR">EUR</option>
            <option value="USD">USD</option>
            </select>
            </div>
        </div>
    </td>  
  	<td>
    	<div class="form-group">
        	<div class="input-group">
        <input type="text" class="form-control"  name="SALE_PRICE">
        	<select class="input-group-text" name="SALE_PRICE_MONEY">
            <option value="EUR">EUR</option>
            <option value="USD">USD</option>
            </select>
            </div>
        </div>
    </td>    
      	<td>
    	<div class="form-group">
        	<div class="input-group">
        <input type="text" class="form-control"  name="SALE_DISCOUNT">
        	<select class="input-group-text" name="SALE_DISCOUNT_MONEY">
            <option value="EUR">EUR</option>
            <option value="USD">USD</option>
            </select>
            </div>
        </div>
    </td>   
          	<td>
    	<div class="form-group">
        	<div class="input-group">
        <input type="text" class="form-control"  name="UNIT_PRICE">
        	<select class="input-group-text" name="UNIT_PRICE_MONEY">
            <option value="EUR">EUR</option>
            <option value="USD">USD</option>
            </select>
            </div>
        </div>
    </td>
              	<td>
    	<div class="form-group">
        	<div class="input-group">
        <input type="text" class="form-control"  name="TOTAL_PRICE">
        	<select class="input-group-text" name="TOTAL_PRICE_MONEY">
            <option value="EUR">EUR</option>
            <option value="USD">USD</option>
            </select>
            </div>
        </div>
    </td>
     	<td>
    	<div class="form-group">
        <div class="input-group">
        	<input class="form-control" type="text" name="FIRST_REMARK">
            <button class="btn btn-danger">x</button>
          </div>
        </div>
    </td>
 	<td>
    	<div class="form-group">
        	<div class="input-group">
        <input type="text" class="form-control"  name="DELIVERED_ITEMS">
        	<select class="input-group-text" name="DELIVERED_ITEMS_UNIT">
            <option value="pcs">pcs</option>
            <option value="GR">GR</option>
            </select>
            </div>
        </div>
    </td>
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
