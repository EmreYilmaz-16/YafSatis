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
     // console.log(Obje);
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
  //console.table(ReturnObject);
  var SelectedValues = [];
  var ox = {
    PRODUCT_CAT: PRODUCT_CAT,
    PRODUCT_CAT_ID: PRODUCT_CAT_ID,
    PNAME: "EQUIPMENT",
    PROP_ID: 0,
  };
  SelectedValues.push(ox);
  var Properties = document.getElementsByClassName("propss");
  var PropList = "";
  PropList += PRODUCT_CAT_ID;
  //console.log(Properties)
  var DataHata = 0;
  for (let i = 0; i < Properties.length; i++) {
    var Pelem = Properties[i];
    var isReq = Pelem.getAttribute("required");

    var Pdata = $(Pelem).select2("data")[0];
    var PROP_ID = Pdata.element.parentElement.getAttribute("data-property_id");
    //console.log($(Pelem).select2("data")[0]);
    var PRODUCT_CAT = Pdata.text;
    var PRODUCT_CAT_ID = Pdata.id;
    var PNAME = Pdata.title;
    if (Pdata.id.length > 0) {
      var O = {
        PRODUCT_CAT: PRODUCT_CAT,
        PRODUCT_CAT_ID: PRODUCT_CAT_ID,
        PNAME: PNAME,
        PROP_ID: PROP_ID,
      };

      //console.table(O);
      SelectedValues.push(O);
      PropList += "," + PRODUCT_CAT_ID;
    }
    if (isReq == "true" && Pdata.id.length == 0) {
      DataHata++;
    }
  }
  ReturnObject.Filters = SelectedValues;
  ReturnObject.PropList = PropList;
  var jsn = JSON.stringify(ReturnObject);
  //console.log(ReturnObject);
  if (DataHata > 0) {
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
  td.appendChild(diva);
  var input = document.createElement("input");
  input.id = "SeperatorRC_" + Obj.PropList;
  input.name = "SeperatorRC_" + Obj.PropList;
  input.type = "hidden";
  input.value = 1;
  td.appendChild(input);
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
  div2.setAttribute("id", "SLO_" + Obj.PropList);
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
    '">0 ' +
    OfferData.OTHER_MONEY +
    "</span></button>";
  var btn =
    '<button class="ui-wrk-btn ui-wrk-btn-extra" style="position: absolute;right: 0;top: 0;"><span id="RC_' +
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
  WEIGHT = 0
) {
  $("#SLO_" + proplist).show();
  var tr = document.createElement("tr");
  var td = document.createElement("td");
  var input = document.createElement("input");
  input.type = "checkbox";
  input.name = "CBX";
  input.id = "CBX_" + RowCount;
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
  var rc2 = document.getElementById("SeperatorRC_" + proplist).value;
  rc2 = parseInt(rc2);

  b2.innerText = rc2;
  b2.setAttribute("onclick", "MoveRow(" + rc2 + ")");
  var div = document.createElement("div");
  div.setAttribute("style", "display:flex");
  div.appendChild(input);
  div.appendChild(b1);
  div.appendChild(b2);
  rc2++;
  td.appendChild(div);
  tr.appendChild(td);
  document.getElementById("SeperatorRC_" + proplist).value = rc2;
  var td = document.createElement("td");
  var div = document.createElement("div");
  div.setAttribute("class", "form-group");
  var input = document.createElement("input");
  input.setAttribute("type", "text");
  input.setAttribute("style", "text-align:left");
  input.name = "PRODUCT_CODE_2";
  input.value = MANUFACT_CODE;
  input.id = "PRODUCT_CODE_2_" + RowCount;
  input.setAttribute("proplist", proplist);
  input.setAttribute("onchange", "getProduct(this," + RowCount + ")");
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
  input.setAttribute("readonly", "yes");
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
  input.name = "SALE_DISCOUNT";
  input.id = "SALE_DISCOUNT_" + RowCount;
  input.value = commaSplit(SALE_DISCOUNT);
  input.setAttribute("onchange", "AlayiniHesapla()");
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = CreateOptionList(1, OfferData.OTHER_MONEY);
  input.name = "SALE_DISCOUNT_MONEY";
  input.setAttribute("readonly", "yes");
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
  input.setAttribute("readonly", "yes");
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
  input.name = "TOTAL_PRICE";

  input.id = "TOTAL_PRICE_" + RowCount;
  input.setAttribute("readonly", "yes");
  input.value = commaSplit(TOTAL_PRICE);
  div2.appendChild(input);
  var input = document.createElement("select");
  input.innerHTML = CreateOptionList(1, OfferData.OTHER_MONEY);
  input.name = "TOTAL_PRICE_MONEY";
  input.id = "TOTAL_PRICE_MONEY_" + RowCount;
  input.setAttribute("readonly", "yes");
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
    .getElementById("PRODUCT_CODE_2_" + rc)
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
          el.setAttribute(
            "style",
            "color:orange;font-weight:bold;text-align:left;"
          );
          var btn = document.createElement("button");
          btn.setAttribute("class", "btn btn-warning");

          btn.innerHTML = "<i class='icn-md fa fa-search'></i>";
          el.parentElement.appendChild(btn);
          el.parentElement.setAttribute("style", "display:flex");
          btn.setAttribute(
            "onclick",
            "openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=getCollation&rc=" +
              rc +
              "&kw=" +
              el.value +
              "&prp_list=" +
              pL +
              "')"
          );
        } else {
          el.setAttribute(
            "style",
            "color:green;font-weight:bold;text-align:left;"
          );
        }
        document.getElementById("PRODUCT_NAME_" + rc).value = Obje.PRODUCT_NAME;

        document.getElementById("PRODUCT_ID_" + rc).value = Obje.PRODUCT_ID;
        document.getElementById("STOCK_ID_" + rc).value = Obje.STOCK_ID;
        document.getElementById("TAX_" + rc).value = Obje.TAX;
        document.getElementById("QUANTITY_" + rc).value = commaSplit(1);
        document.getElementById("PRODUCT_UNIT_" + rc).innerHTML =
          '<option value="' +
          Obje.MAIN_UNIT +
          '">' +
          Obje.MAIN_UNIT +
          "</option>";
        document.getElementById("PURCHASE_PRICE_" + rc).value = commaSplit(0);
        document.getElementById("SALE_PRICE_" + rc).value = commaSplit(0);
        document.getElementById("SALE_DISCOUNT_" + rc).value = commaSplit(0);
        document.getElementById("UNIT_PRICE_" + rc).value = commaSplit(0);
        document.getElementById("TOTAL_PRICE_" + rc).value = commaSplit(0);
        document.getElementById("DELIVERED_ITEMS_" + rc).value = commaSplit(0);
        document.getElementById("DELIVERED_ITEMS_UNIT_" + rc).innerHTML =
          '<option value="' +
          Obje.MAIN_UNIT +
          '">' +
          Obje.MAIN_UNIT +
          "</option>";
        AlayiniHesapla();
        document.getElementById("WEIGHT_" + rc).value = commaSplit(0);
      } else {
        el.setAttribute("style", "color:red;font-weight:bold;text-align:left;");
      }
    },
  });
}
function MoveRow(FromRow) {
  var ToRow = prompt("To Row");

  var FromStockId = document.getElementById("STOCK_ID_" + FromRow).value;
  var ToStockId = document.getElementById("STOCK_ID_" + ToRow).value;
  var FromProductId = document.getElementById("PRODUCT_ID_" + FromRow).value;
  var ToProductId = document.getElementById("PRODUCT_ID_" + ToRow).value;
  var FromProductCode = document.getElementById(
    "PRODUCT_CODE_2_" + FromRow
  ).value;
  var ToProductCode = document.getElementById("PRODUCT_CODE_2_" + ToRow).value;
  var FromTax = document.getElementById("TAX_" + FromRow).value;
  var ToTax = document.getElementById("TAX_" + ToRow).value;
  var FromProductName = document.getElementById(
    "PRODUCT_NAME_" + FromRow
  ).value;
  var ToProductName = document.getElementById("PRODUCT_NAME_" + ToRow).value;
  var FromQuantity = document.getElementById("QUANTITY_" + FromRow).value;
  var ToQuantity = document.getElementById("QUANTITY_" + ToRow).value;
  var FromUnit = document.getElementById("PRODUCT_UNIT_" + FromRow).value;
  var ToUnit = document.getElementById("PRODUCT_UNIT_" + ToRow).value;
  var FromPurchasePrice = document.getElementById(
    "PURCHASE_PRICE_" + FromRow
  ).value;
  var ToPurchasePrice = document.getElementById(
    "PURCHASE_PRICE_" + ToRow
  ).value;
  var FromPurchaseMoney = document.getElementById(
    "PURCHASE_MONEY_" + FromRow
  ).value;
  var ToPurchaseMoney = document.getElementById(
    "PURCHASE_MONEY_" + ToRow
  ).value;
  var FromSalePrice = document.getElementById("SALE_PRICE_" + FromRow).value;
  var ToSalePrice = document.getElementById("SALE_PRICE_" + ToRow).value;
  var FromSaleMoney = document.getElementById("SALE_MONEY_" + FromRow).value;
  var ToSaleMoney = document.getElementById("SALE_MONEY_" + ToRow).value;
  var FromSaleDiscount = document.getElementById(
    "SALE_DISCOUNT_" + FromRow
  ).value;
  var ToSaleDiscount = document.getElementById("SALE_DISCOUNT_" + ToRow).value;
  var FromSaleDiscountMoney = document.getElementById(
    "SALE_DISCOUNT_MONEY_" + FromRow
  ).value;
  var ToSaleDiscountMoney = document.getElementById(
    "SALE_DISCOUNT_MONEY_" + ToRow
  ).value;
  var FromUnitPrice = document.getElementById("UNIT_PRICE_" + FromRow).value;
  var ToUnitPrice = document.getElementById("UNIT_PRICE_" + ToRow).value;
  var FromUnitPriceMoney = document.getElementById(
    "UNIT_PRICE_MONEY_" + FromRow
  ).value;
  var ToUnitPriceMoney = document.getElementById(
    "UNIT_PRICE_MONEY_" + ToRow
  ).value;
  var FromTotalPrice = document.getElementById("TOTAL_PRICE_" + FromRow).value;
  var ToTotalPrice = document.getElementById("TOTAL_PRICE_" + ToRow).value;
  var FromTotalPriceMoney = document.getElementById(
    "TOTAL_PRICE_MONEY_" + FromRow
  ).value;
  var ToTotalPriceMoney = document.getElementById(
    "TOTAL_PRICE_MONEY_" + ToRow
  ).value;
  var FromFirstRemark = document.getElementById(
    "FIRST_REMARK_" + FromRow
  ).value;
  var ToFirstRemark = document.getElementById("FIRST_REMARK_" + ToRow).value;
  //TOTAL_PRICE_1
  //TOTAL_PRICE_MONEY_1
  var O = {
    FromRowData: {
      ROW_ID: FromRow,
      STOCK_ID: FromStockId,
      PRODUCT_ID: FromProductId,
      PRODUCT_CODE: FromProductCode,
      TAX: FromTax,
      PRODUCT_NAME: FromProductName,
      QUANTITY: FromQuantity,
      UNIT: FromUnit,
      PURCHASE_PRICE: FromPurchasePrice,
      PURCHASE_MONEY: FromPurchaseMoney,
      SALE_PRICE: FromSalePrice,
      SALE_MONEY: FromSaleMoney,
      SALE_DISCOUNT: FromSaleDiscount,
      SALE_DISCOUNT_MONEY: FromSaleDiscountMoney,
      UNIT_PRICE: FromUnitPrice,
      UNIT_PRICE_MONEY: FromUnitPriceMoney,
      TOTAL_PRICE: FromTotalPrice,
      TOTAL_PRICE_MONEY: FromTotalPriceMoney,
      FIRST_REMARK: FromFirstRemark,
    },
    ToRowData: {
      ROW_ID: ToRow,
      STOCK_ID: ToStockId,
      PRODUCT_ID: ToProductId,
      PRODUCT_CODE: ToProductCode,
      TAX: ToTax,
      PRODUCT_NAME: ToProductName,
      QUANTITY: ToQuantity,
      UNIT: ToUnit,
      PURCHASE_PRICE: ToPurchasePrice,
      PURCHASE_MONEY: ToPurchaseMoney,
      SALE_PRICE: ToSalePrice,
      SALE_MONEY: ToSaleMoney,
      SALE_DISCOUNT: ToSaleDiscount,
      SALE_DISCOUNT_MONEY: ToSaleDiscountMoney,
      UNIT_PRICE: ToUnitPrice,
      UNIT_PRICE_MONEY: ToUnitPriceMoney,
      TOTAL_PRICE: ToTotalPrice,
      TOTAL_PRICE_MONEY: ToTotalPriceMoney,
      FIRST_REMARK: ToFirstRemark,
    },
  };

  // console.table(O.FromRowData);
  // console.table(O.ToRowData);
  // console.table(O);
  document.getElementById("STOCK_ID_" + FromRow).value = O.ToRowData.STOCK_ID;
  document.getElementById("STOCK_ID_" + ToRow).value = O.FromRowData.STOCK_ID;
  document.getElementById("PRODUCT_ID_" + FromRow).value =
    O.ToRowData.PRODUCT_ID;
  document.getElementById("PRODUCT_ID_" + ToRow).value =
    O.FromRowData.PRODUCT_ID;
  document.getElementById("PRODUCT_CODE_2_" + FromRow).value =
    O.ToRowData.PRODUCT_CODE;
  document.getElementById("PRODUCT_CODE_2_" + ToRow).value =
    O.FromRowData.PRODUCT_CODE;
  document.getElementById("TAX_" + FromRow).value = O.ToRowData.TAX;
  document.getElementById("TAX_" + ToRow).value = O.FromRowData.TAX;
  document.getElementById("PRODUCT_NAME_" + FromRow).value =
    O.ToRowData.PRODUCT_NAME;
  document.getElementById("PRODUCT_NAME_" + ToRow).value =
    O.FromRowData.PRODUCT_NAME;
  document.getElementById("QUANTITY_" + FromRow).value = O.ToRowData.QUANTITY;
  document.getElementById("QUANTITY_" + ToRow).value = O.FromRowData.QUANTITY;
  document.getElementById("PRODUCT_UNIT_" + FromRow).value = O.ToRowData.UNIT;
  document.getElementById("PRODUCT_UNIT_" + ToRow).value = O.FromRowData.UNIT;
  document.getElementById("PURCHASE_PRICE_" + FromRow).value =
    O.ToRowData.PURCHASE_PRICE;
  document.getElementById("PURCHASE_PRICE_" + ToRow).value =
    O.FromRowData.PURCHASE_PRICE;
  document.getElementById("PURCHASE_MONEY_" + FromRow).value =
    O.ToRowData.PURCHASE_MONEY;
  document.getElementById("PURCHASE_MONEY_" + ToRow).value =
    O.FromRowData.PURCHASE_MONEY;
  document.getElementById("SALE_PRICE_" + FromRow).value =
    O.ToRowData.SALE_PRICE;
  document.getElementById("SALE_PRICE_" + ToRow).value =
    O.FromRowData.SALE_PRICE;
  document.getElementById("SALE_MONEY_" + FromRow).value =
    O.ToRowData.SALE_MONEY;
  document.getElementById("SALE_MONEY_" + ToRow).value =
    O.FromRowData.SALE_MONEY;
  document.getElementById("SALE_DISCOUNT_" + FromRow).value =
    O.ToRowData.SALE_DISCOUNT;
  document.getElementById("SALE_DISCOUNT_" + ToRow).value =
    O.FromRowData.SALE_DISCOUNT;
  document.getElementById("SALE_DISCOUNT_MONEY_" + FromRow).value =
    O.ToRowData.SALE_DISCOUNT_MONEY;
  document.getElementById("SALE_DISCOUNT_MONEY_" + ToRow).value =
    O.FromRowData.SALE_DISCOUNT_MONEY;
  document.getElementById("UNIT_PRICE_" + FromRow).value =
    O.ToRowData.UNIT_PRICE;
  document.getElementById("UNIT_PRICE_" + ToRow).value =
    O.FromRowData.UNIT_PRICE;
  document.getElementById("UNIT_PRICE_MONEY_" + FromRow).value =
    O.ToRowData.UNIT_PRICE_MONEY;
  document.getElementById("UNIT_PRICE_MONEY_" + ToRow).value =
    O.FromRowData.UNIT_PRICE_MONEY;
  document.getElementById("TOTAL_PRICE_" + FromRow).value =
    O.ToRowData.TOTAL_PRICE;
  document.getElementById("TOTAL_PRICE_" + ToRow).value =
    O.FromRowData.TOTAL_PRICE;
  document.getElementById("TOTAL_PRICE_MONEY_" + FromRow).value =
    O.ToRowData.TOTAL_PRICE_MONEY;
  document.getElementById("TOTAL_PRICE_MONEY_" + ToRow).value =
    O.FromRowData.TOTAL_PRICE_MONEY;
  document.getElementById("FIRST_REMARK_" + FromRow).value =
    O.ToRowData.FIRST_REMARK;
  document.getElementById("FIRST_REMARK_" + ToRow).value =
    O.FromRowData.FIRST_REMARK;
  AlayiniHesapla();
}
/*
TODO: SEPERATOR SIL FONKSIYONU YAZILACAK
TODO: SEPRATOR SILDEN SONRA GENEL SATIR DUZENLEME YAZILACAK {
  1-BÜTÜN SATIR ELEMANLARININ IDLERİNİ VE SATIRLA İLGİLİ OLAN VERİLERİ DEĞİŞTİRECEL
  2-ROW COUNT VERİSİNİ GÜNCEL SATIR MİKTARI İLE GÜNCELLEYECEK
}
TODO: SEÇMELİ SATIR SİLME YAZILACAK 
TODO: SEÇMELİ SATIR SİLME SONRASI SEPRATOR DUZENLEME YAZILACAK {
  1-SEPERATOR SATIRLARI DÖNGÜYE GİRECEK
  2-İDL
}
*/
function SeperatorSil(PropList = "7,50014,50015") {
  var Basket = document.getElementById("BasketArea");
  var BasketSperators = Basket.children;
  for (let i = 0; i < BasketSperators.length; i++) {
    var Seperator = BasketSperators[i];
    var PropList_ = Seperator.getAttribute("data-proplist");
    //console.log(PropList_);
    if (PropList_ == PropList) {
      Seperator.remove();
    }
  }
  TumSatirlariDuzenle();
  AlayiniHesapla();
}

function TumSatirlariDuzenle() {
  var RowCount_ = 1;
  var Basket = document.getElementById("BasketArea");
  var BasketSperators = Basket.children;
  for (let i = 0; i < BasketSperators.length; i++) {
    var Seperator = BasketSperators[i];
    var PropList_ = Seperator.getAttribute("data-proplist");
    var Sepet = document.getElementById("SubSepetBody_" + PropList_).children;
    for (let j = 0; j < Sepet.length; j++) {
      var SepetItem = Sepet[j];
     // console.log(SepetItem);
      var inputs = SepetItem.getElementsByTagName("input");
      var Selects = SepetItem.getElementsByTagName("select");
      var Buttons = SepetItem.getElementsByTagName("button");
      var ARR = [];
     // console.log(inputs);
      for (let x = 0; x < inputs.length; x++) {
        var ix = inputs[x];
       // console.log(ix.id);
        ix.id = ix.name + "_" + RowCount_;
        //console.log(ix.id);
      }
      for (let x = 0; x < Selects.length; x++) {
        var ix = Selects[x];
        //console.log(ix.id);
        ix.id = ix.name + "_" + RowCount_;
        //console.log(ix.id);
      }
      for (let x = 0; x < Buttons.length; x++) {
        var ix = Buttons[x];
        var BtnAtt = ix.getAttribute("onclick");
        if (BtnAtt) {
          //console.log("BTNATT=" + BtnAtt);
        } else {
          ix.innerText = RowCount_;
        }
      }
      RowCount_++;
    }
    
  }
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
function UpdateRow(PID, SID, TAX, MANCODE, PN, RC, mdl) {
  document.getElementById("PRODUCT_ID_" + RC).value = PID;
  document.getElementById("TAX_" + RC).value = TAX;
  document.getElementById("STOCK_ID_" + RC).value = SID;
  document.getElementById("PRODUCT_CODE_2_" + RC).value = MANCODE;
  document.getElementById("PRODUCT_NAME_" + RC).value = PN;
  document
    .getElementById("PRODUCT_CODE_2_" + RC)
    .setAttribute("style", "color:green;font-weight:bold;text-align:left;");
  $(document.getElementById("PRODUCT_CODE_2_" + RC).parentElement)
    .find("button")
    .remove();
  closeBoxDraggable(mdl);
  AlayiniHesapla();
}

var AktifSepet = [];
var OfferSettings = {
  IS_TAX_ZERO: 1,
};
var OrderFooter = {
  total_default: 0,
  genel_indirim_: 0,
  total_discount_wanted: 0,
  brut_total_wanted: 0,
  total_tax_wanted: 0,
  net_total_wanted: 0,
  other_money: "TL",
};
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
    var AKTIF_KUR = KurGetir(OfferData.OTHER_MONEY);
    //console.table(AKTIF_KUR);
    for (let j = 0; j < Sepet.children.length; j++) {
      var SepetItem = Sepet.children[j];
      SEPET_SIRA++;
      // console.log(SepetItem)
      var PRODUCT_ID = DegeriGetir(SepetItem, "PRODUCT_ID", 1);
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
      var SALE_DISCOUNT = DegeriGetir(SepetItem, "SALE_DISCOUNT", 2, 1);
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
    document.getElementById("TOTALE_" + PropList).innerText =
      commaSplit(SeperatorToplam);
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
function KurGetir(money) {
  var ix = MONEY_ARR.findIndex((p) => p.MONEY == money);
  return MONEY_ARR[ix];
}

function OzetOlustur() {
  var T_OZET = "<ul>";
  var Seperators = document.getElementById("BasketArea").children;
  //console.log(Seperators);
  for (let i = 0; i < Seperators.length; i++) {
    var aSeperator = Seperators[i];
    var tx = $(aSeperator).find("table");
    var BB = tx[0].children[0].cells;
    T_OZET += "<li><table class='table'><tr><td>";
    var PropList = aSeperator.getAttribute("data-proplist");
    // console.log(PropList)
    var Sepet = document.getElementById("SubSepetBody_" + PropList);
   // console.log(Sepet.children.length);
    for (let j = 0; j < BB.length; j++) {
      var B = BB[j];

      try {
        T_OZET += B.lastChild.innerText + "->";
      } catch {}
    }

    //T_OZET+="</p>"
    T_OZET +=
      "</td><td> " + Sepet.children.length + "</</td></tr></table></li>";
  }
  T_OZET += "</ul>";
  //console.log(T_OZET);
  $("#OzetAlani").html(T_OZET);
  /*
  OrderFooter.brut_total_wanted
  OrderFooter.genel_indirim_
  OrderFooter.net_total_wanted
  OrderFooter.other_money
  OrderFooter.total_default
  OrderFooter.total_discount_wanted
  OrderFooter.total_tax_wanted
  */
  var AKTIF_KUR = KurGetir(OfferData.OTHER_MONEY);
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

function lookProducts(proplist) {
  openBoxDraggable(
    "index.cfm?fuseaction=objects.emptypopup_list_products_pbs&proplist=" +
      proplist
  );
}

function SaveOffer() {
  AlayiniHesapla();
  var BasketData = new Object();
  BasketData.OFFER_HEADER = OfferData;
  BasketData.ROWS = AktifSepet;
  BasketData.OFFER_FOOTER = OrderFooter;

  $.ajax({
    url: "/AddOns/YafSatis/Partner/cfc/OfferService.cfc?method=SAVE_OFFER_ROWS",
    data: {
      data: JSON.stringify(BasketData),
    },
    success: function (retDat) {
      $.notification(["Kayıt Edildi"], {
        messageType: "success",
      });
    },
  });
}
