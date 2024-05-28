var RowCount = 1;
var ServiceUri = "/AddOns/YafSatis/Partner/cfc";
$(document).ready(function () {
  var e = document.getElementById("PRODUCT_CAT");
  // var e1 = document.getElementById("MONEY");
  // var e2 = document.getElementById("PRIORITY");
  getCats(e);
  get_consumer("", "");
});
function getCats(el) {
  $.ajax({
    url: ServiceUri + "/ProductService_V1.cfc?method=getCats",
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
  try{ $("#BUTOCUMMMMM").remove();}catch {};
  var WESSEL_ID = document.getElementById("WESSEL_ID").value;
  if (WESSEL_ID.length > 0) {
    var rs = $.post(
      ServiceUri +
        "/OfferService.cfc?method=getShipFilters&SHIP_ID=" +
        WESSEL_ID +
        "&PRODUCT_CATID=" +
        cat_id
    ).done(function (ReturnData) {
      var TV = JSON.parse(ReturnData);
      if (TV.STATUS == 1) {
        var ET = confirm(
          "Bu Gemi'de Bu Ekipmana Bağlı Filtreler Kayıt Edilmiştir Yüklemek İstermisiniz"
        );
        var btnn=document.createElement("a");
        btnn.setAttribute("class","input-group-addon")
        btnn.setAttribute("onclick","openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_list_ship_machine&WESSEL_ID="+WESSEL_ID+"&cat_id="+cat_id+"')");
        btnn.id="BUTOCUMMMMM";
        var i=document.createElement("span");
        i.setAttribute("class","icn-md fa fa-gears");
        btnn.appendChild(i);
        document.getElementById("PRODUCT_CAT").parentElement.appendChild(btnn);
        if (ET) {
          if(TV.RECORD_COUNT==1){          
          addEqRow(TV.JSON_STRINGIM, JSON.stringify(TV.JSON_STRINGIM));
          AjaxPageLoad(
            "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=catProps&PRODUCT_CATID=" +
              cat_id,
            "PROP_AREA",
            1,
            "Yükleniyor"
          );
          }else{
            openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_list_ship_machine&WESSEL_ID='+WESSEL_ID+'&cat_id='+cat_id)
            AjaxPageLoad(
              "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=catProps&PRODUCT_CATID=" +
                cat_id,
              "PROP_AREA",
              1,
              "Yükleniyor"
            );
          }
        } else {
          AjaxPageLoad(
            "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=catProps&PRODUCT_CATID=" +
              cat_id,
            "PROP_AREA",
            1,
            "Yükleniyor"
          );
        }
      } else {
        AjaxPageLoad(
          "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=catProps&PRODUCT_CATID=" +
            cat_id,
          "PROP_AREA",
          1,
          "Yükleniyor"
        );
      }
    });
  } else {
    AjaxPageLoad(
      "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=catProps&PRODUCT_CATID=" +
        cat_id,
      "PROP_AREA",
      1,
      "Yükleniyor"
    );
  }
}

function AddEquipment() {
  var OS = getFilterData();
  var ReturnObject = OS.ReturnObject;
  var jsn = OS.jsn;
  addEqRow(ReturnObject, jsn);
}
var EqArr = [];

function getFilterData() {
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
    IS_OPTIONAL: 0,
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
    var is_optional =
      Pdata.element.parentElement.getAttribute("data-is_optional");
    //console.log($(Pelem).select2("data")[0]);
    console.log(is_optional);
    var PRODUCT_CAT = Pdata.text;
    var PRODUCT_CAT_ID = Pdata.id;
    var PNAME = Pdata.title;
    if (Pdata.id.length > 0) {
      var O = {
        PRODUCT_CAT: PRODUCT_CAT,
        PRODUCT_CAT_ID: PRODUCT_CAT_ID,
        PNAME: PNAME,
        PROP_ID: PROP_ID,
        IS_OPTIONAL: is_optional,
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
  console.log(ReturnObject);
  if (DataHata > 0) {
    alert("Zorunlu Alanlar var !");
    return false;
  }
  var ST = new Object();
  ST.ReturnObject = ReturnObject;
  ST.jsn = jsn;
  return ST;
}

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
  WEIGHT = 0,
  IS_VIRTUAL = 0,
  UNIQUE_RELATION_ID = ""
) {
  $("#SLO_" + proplist).show();
  var tr = document.createElement("tr");
  var td = document.createElement("td");
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
  var b3 = document.createElement("button");
  b3.setAttribute("class", "ui-wrk-btn ui-wrk-btn-extra");
  b3.setAttribute(
    "style",
    "font-size: 7px !important;padding: 3px 7px !important;"
  );
  var spn=document.createElement("span");
  spn.setAttribute("class","icn-md fa fa-info");
  b3.appendChild(spn);
  var b4 = document.createElement("button");
  b4.setAttribute("class", "ui-wrk-btn ui-wrk-btn-busy");
  b4.setAttribute("id","ResimButonC_"+RowCount)
  b4.setAttribute(
    "style",
    "font-size: 7px !important;padding: 3px 7px !important;"
  );
  var spn=document.createElement("span");
  spn.setAttribute("class","icn-md fa fa-camera");
  b4.appendChild(spn);

  var rc2 = document.getElementById("SeperatorRC_" + proplist).value;
  rc2 = parseInt(rc2);

  b2.innerText = rc2;
  b2.setAttribute("onclick", "MoveRow(" + rc2 + ")");
  b3.setAttribute("onclick","ShowProperties(this)")
  b3.setAttribute("data-rc",RowCount);
  b4.setAttribute("onclick","ShowImages(this)")
  b4.setAttribute("data-rc",RowCount);
  var div = document.createElement("div");
  div.setAttribute("style", "display:flex");
  div.appendChild(input);
  div.appendChild(input2);
  div.appendChild(input3);
  div.appendChild(b1);
  div.appendChild(b2);
  div.appendChild(b3);
  div.appendChild(b4);
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
  if (IS_VIRTUAL == 1) {
    input.setAttribute(
      "style",
      "color:red;font-weight:bold;text-align:left;background:black;"
    );
  } else {
    input.setAttribute("style", "text-align:left");
  }
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
    url: ServiceUri + "/ProductService_V1.cfc?method=SearchProduct",
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
          if (Obje.EXTRA_PROPT > 0) {
            el.setAttribute(
              "style",
              "color:green;font-weight:bold;text-align:left;background:black"
            );
            var btn = document.createElement("button");
            btn.setAttribute("class", "btn btn-success");

            btn.innerHTML = "<i class='icn-md fa fa-search'></i>";
            el.parentElement.appendChild(btn);
            el.parentElement.setAttribute("style", "display:flex");
            btn.setAttribute(
              "onclick",
              "openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=ShowProductProperties&rc=" +
                rc +
                "&PID=" +
                Obje.PRODUCT_ID +
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
        }
        document.getElementById("PRODUCT_NAME_" + rc).value = Obje.PRODUCT_NAME;
        if(Obje.IMG_COUNT>0){
          document.getElementById("ResimButonC_"+rc).setAttribute("class","ui-wrk-btn ui-wrk-btn-red");
        }
        document.getElementById("PRODUCT_ID_" + rc).value = Obje.PRODUCT_ID;
        document.getElementById("IS_VIRTUAL_" + rc).value = Obje.IS_VIRTUAL;
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
        el.setAttribute(
          "style",
          "color:red;font-weight:bold;text-align:left;background:black"
        );
        document.getElementById("IS_VIRTUAL_" + rc).value = 1;
        document.getElementById("PRODUCT_ID_" + rc).value = 0;
        document.getElementById("STOCK_ID_" + rc).value = 0;
        var SF = wrk_safe_query("getAllUnits", "dsn");
        for (let i = 0; i < SF.recordcount; i++) {
          var Opt = document.createElement("option");
          Opt.value = SF.UNIT[i];
          Opt.innerText = SF.UNIT[i];
          document.getElementById("PRODUCT_UNIT_" + rc).appendChild(Opt);
        }
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
  RowCount = RowCount_;
}
function SeciliSil(PropList = "7,50014,50015") {
  var Sepet = document.getElementById("SubSepetBody_" + PropList).children;
  for (let i = 0; i < Sepet.length; i++) {
    var SR = Sepet[i];
    var Cbx = $(SR).find("input[type='checkbox']")[0];
    // console.log(Cbx)
    if ($(Cbx).is(":checked")) {
      SR.remove();
    }
  }
  var RCS = 0;
  var Sepet = document.getElementById("SubSepetBody_" + PropList).children;
  for (let i = 0; i < Sepet.length; i++) {
    RCS++;
    var SepetItem = Sepet[i];
    var Buttons = SepetItem.getElementsByTagName("button");
    console.log(Buttons);
    for (let x = 0; x < Buttons.length; x++) {
      var ix = Buttons[x];
      var BtnAtt = ix.getAttribute("onclick");
      if (BtnAtt) {
        console.log("BTNATT=" + BtnAtt);
        ix.innerText = RCS;
      } else {
        // ix.innerText = RowCount_;
      }
    }
  }
  if (RCS == 0) RCS = 1;
  document.getElementById("SeperatorRC_" + PropList).value = RCS;

  TumSatirlariDuzenle();
  AlayiniHesapla();
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
function GenerateUniqueId() {
  var d = new Date();
  var dy = d - 1;
  var dd = d.toISOString().split("T")[0];
  var ds = d.toISOString().split("T")[1];
  var dd1 = dd.replaceAll("-", "");
  var ds1 = ds.replaceAll(":", "");
  ds1 = ds1.replaceAll(".", "");
  console.log(ds1);
  var RelId = "PBS" + generalParamsSatis.userData.user_id + "" + dd1 + "" + ds1;
  return RelId;
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

function get_consumer(el = "", ev = "") {
  AjaxPageLoad(
    "index.cfm?fuseaction=objects.emptypopup_get_company_partner&KEYWORD=" +
      el.value,
    "text_cpm_search_result_area",
    1,
    "Yükleniyor"
  );
}
var SelectedCompArr = [];
function AddToCons() {
  var cmp_l = document.getElementsByName("comp_sel_cb");
  var pid_l = document.getElementsByName("CBX");
  for (let i = 0; i < cmp_l.length; i++) {
    var CompCb = cmp_l[i];
    if ($(CompCb).is(":checked")) {
      var Ax = SelectedCompArr.findIndex((p) => p.COMPANY_ID == CompCb.value);
      var nnmc = document.getElementById(
        "comp_sel_mb_" + CompCb.value
      ).innerText;
      var nnnn = document.getElementById(
        "comp_sel_nn_" + CompCb.value
      ).innerText;
      if (Ax == -1) {
        var OX = {
          COMPANY_ID: CompCb.value,
          NICKNAME: nnnn,
          MEMBER_CODE: nnmc,
          PIDS: [],
        };
        for (let j = 0; j <= pid_l.length; j++) {
          try {
            var PidCb = pid_l[j];
            if ($(PidCb).is(":checked")) {
              var PIDX = document.getElementById("PRODUCT_ID_" + (j + 1)).value;
              var SIDX = document.getElementById("STOCK_ID_" + (j + 1)).value;
              var PRODUCT_NAMEX = document.getElementById(
                "PRODUCT_NAME_" + (j + 1)
              ).value;
              var PRODUCT_CODE_2X = document.getElementById(
                "PRODUCT_CODE_2_" + (j + 1)
              ).value;
              var QUANTITYX = document.getElementById(
                "QUANTITY_" + (j + 1)
              ).value;
              var UNIQUE_RELATION_IDX = document.getElementById(
                "UNIQUE_RELATION_ID_" + (j + 1)
              ).value;
              var PRODUCT_UNITX = document.getElementById(
                "PRODUCT_UNIT_" + (j + 1)
              ).value;

              var TX = {
                PID: PIDX,
                SID: SIDX,
                QUANTITY: filterNum(QUANTITYX),
                UNIQUE_RELATION_ID: UNIQUE_RELATION_IDX,
                PRODUCT_NAME: PRODUCT_NAMEX,
                PRODUCT_CODE_2: PRODUCT_CODE_2X,
                PRODUCT_UNIT: PRODUCT_UNITX,
              };
              OX.PIDS.push(TX);
            }
          } catch (error) {}
        }
        SelectedCompArr.push(OX);
      } else {
        for (let j = 0; j <= pid_l.length; j++) {
          try {
            var PidCb = pid_l[j];
            var str = "PRODUCT_ID_" + (j + 1);
            console.log(str);
            var PIDX = document.getElementById("PRODUCT_ID_" + (j + 1)).value;
            var SIDX = document.getElementById("STOCK_ID_" + (j + 1)).value;
            var PRODUCT_NAMEX = document.getElementById(
              "PRODUCT_NAME_" + (j + 1)
            ).value;
            var PRODUCT_CODE_2X = document.getElementById(
              "PRODUCT_CODE_2_" + (j + 1)
            ).value;
            var QUANTITYX = document.getElementById(
              "QUANTITY_" + (j + 1)
            ).value;
            var UNIQUE_RELATION_IDX = document.getElementById(
              "UNIQUE_RELATION_ID_" + (j + 1)
            ).value;
            var PRODUCT_UNITX = document.getElementById(
              "PRODUCT_UNIT_" + (j + 1)
            ).value;

            if ($(PidCb).is(":checked")) {
              var FX = SelectedCompArr[Ax].PIDS.findIndex(
                (p) => p.UNIQUE_RELATION_ID == UNIQUE_RELATION_IDX
              );
              if (FX == -1) {
                var TX = {
                  PID: PIDX,
                  SID: SIDX,
                  QUANTITY: filterNum(QUANTITYX),
                  UNIQUE_RELATION_ID: UNIQUE_RELATION_IDX,
                  PRODUCT_NAME: PRODUCT_NAMEX,
                  PRODUCT_CODE_2: PRODUCT_CODE_2X,
                  PRODUCT_UNIT: PRODUCT_UNITX,
                };
                SelectedCompArr[Ax].PIDS.push(TX);
              }
            }
          } catch (error) {}
        }
      }
    }
  }
  TedarikYaz();
}

function TedarikYaz() {
  $("#tedarik").html("");
  for (let i = 0; i < SelectedCompArr.length; i++) {
    var AComp = SelectedCompArr[i];
    console.table(AComp);
    var Table = document.createElement("table");
    Table.setAttribute("class", "table table-sm table-stripped");
    Table.setAttribute(
      "style",
      "border: solid 0.5px #d9d9d9;box-shadow: 1px 2px 20px 0px #cfc7c7;margin-top:5px !important;"
    );
    var tr = document.createElement("tr");
    var td = document.createElement("th");
    td.innerText = AComp.MEMBER_CODE;
    td.setAttribute("style", "color:#fb6b5b;width:10%");

    tr.appendChild(td);
    var td = document.createElement("th");

    td.innerText = AComp.NICKNAME;
    var span = document.createElement("span");
    span.innerText = AComp.PIDS.length;
    span.setAttribute(
      "style",
      "    float: right;margin-right: 10px;  background: #fb6b5b;  color: white;  padding: 1px 8px 1px 8px;  border-radius: 50%;"
    );
    td.setAttribute("style", "color:#fb6b5b");
    td.appendChild(span);
    tr.appendChild(td);
    //   tr.setAttribute("style","background: #e1e1e170;")
    tr.setAttribute("onclick", "$('#tr_" + AComp.COMPANY_ID + "').toggle()");
    Table.appendChild(tr);
    var tr = document.createElement("tr");
    var td = document.createElement("td");
    td.setAttribute("colspan", "2");
    var table2 = document.createElement("table");
    table2.setAttribute("class", "table table-sm table-stripped");
    for (let j = 0; j < AComp.PIDS.length; j++) {
      var Aproduct = AComp.PIDS[j];
      var _tr = document.createElement("tr");
      var _td = document.createElement("td");
      _td.innerText = Aproduct.PRODUCT_CODE_2;
      _tr.appendChild(_td);
      var _td = document.createElement("td");
      _td.innerText = Aproduct.PRODUCT_NAME;
      _tr.appendChild(_td);
      var _td = document.createElement("td");
      _td.innerText = Aproduct.QUANTITY;
      _tr.appendChild(_td);
      table2.appendChild(_tr);
    }
    td.appendChild(table2);
    tr.appendChild(td);
    tr.setAttribute("style", "display:none");
    tr.id = "tr_" + AComp.COMPANY_ID;
    Table.appendChild(tr);
    document.getElementById("tedarik").appendChild(Table);
  }
}

function AddPurchaseOffer() {
  var OfferId = getParameterByName("offer_id");
  var OS = {
    OFFER_ID: OfferId,
    FormData: SelectedCompArr,
  };
  $.ajax({
    url: "/AddOns/YafSatis/Partner/cfc/OfferService.cfc?method=AddPurchaseOffer",
    data: {
      FormData: JSON.stringify(OS),
    },
    success: function (retDat) {
      $.notification(["Kayıt Edildi"], {
        messageType: "success",
      });
    },
  });
}

function getParameterByName(name, url) {
  if (!url) url = window.location.href;
  name = name.replace(/[\[\]]/g, "\\$&");
  var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
    results = regex.exec(url);
  if (!results) return null;
  if (!results[2]) return "";
  return decodeURIComponent(results[2].replace(/\+/g, " "));
}
function loadRelOffers() {
  var r = wrk_safe_query("GETREO_OFFERS");
  for (let i = 0; i < r.recordcount; i++) {}
}

function SavePropToShip() {
  var WESSEL_ID = document.getElementById("WESSEL_ID").value;
  // var FD = getFilterData();
  // var SEND_DATA = FD.ReturnObject;
  // SEND_DATA.WESSEL_ID = WESSEL_ID;

  // $.ajax({
  //   url: "/AddOns/YafSatis/Partner/cfc/OfferService.cfc?method=AddShipToFilter",
  //   data: {
  //     data: JSON.stringify(SEND_DATA),
  //   },
  //   success: function () {
  //     alert("Hİ");
  //   },
  // });


  openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_list_ship_machine&WESSEL_ID='+WESSEL_ID)
}

function ShowProperties(el){
var rc=el.getAttribute("data-rc");
var pid=document.getElementById("PRODUCT_ID_"+rc).value;
var pL=document.getElementById("PRODUCT_CODE_2_"+rc).getAttribute("proplist");
openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=ShowProductProperties&rc=' +
                rc +
                '&PID=' +
                pid +
                '&prp_list=' +
                pL 
                )


}
function ShowImages(el){
  //objects.emptypopup_show_product_images
  var rc=el.getAttribute("data-rc");
  var pid=document.getElementById("PRODUCT_ID_"+rc).value;
  var pL=document.getElementById("PRODUCT_CODE_2_"+rc).getAttribute("proplist");
  openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_show_product_images&PRODUCT_ID='+pid)
  
  
  }
  function ShowImages2(pid){
    
    openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_show_product_images&PRODUCT_ID='+pid)
    
    
    }
  
    function SatinAlmaKontrol(offer_id) {
      var SelectedCompArri = [];
      var SelectedCompArr = [];
      $.get(
        "/AddOns/YafSatis/Partner/cfc/OfferService.cfc?method=getPurchaseOfferListForSaleOffer&OFFER_ID=" +
          offer_id
      ).done(function (retDat) {
        var Teklifler = JSON.parse(retDat);
        console.log(Teklifler);
    
        for (let i = 0; i < Teklifler.length; i++) {
          var ATeklif = Teklifler[i];
          /*
            <table class="table table-sm table-stripped" style="border: solid 0.5px #d9d9d9;box-shadow: 1px 2px 20px 0px #cfc7c7;margin-top:5px !important;"><tr onclick="$('#tr_9').toggle()"><th style="color:#fb6b5b;width:10%">C9</th><th style="color:#fb6b5b">ADASTAR SHIPPING LTD<span style="    float: right;margin-right: 10px;  background: #fb6b5b;  color: white;  padding: 1px 8px 1px 8px;  border-radius: 50%;">3</span></th></tr><tr style="display:none" id="tr_9"><td colspan="2"><table class="table table-sm table-stripped"><tr><td>344A</td><td>FUEL VALVE</td><td>1.00</td></tr><tr><td>344A-A</td><td>SPINDLE GUIDE COMPLETE</td><td>1.00</td></tr><tr><td>344A-A</td><td>SPINDLE GUIDE COMPLETE</td><td>1.00</td></tr></table></td></tr></table>
            */
    
          var O = {
            COMPANY_ID: ATeklif.COMPANY_ID,
            NICKNAME: ATeklif.NICKNAME,
            MEMBER_CODE: ATeklif.MEMBER_CODE,
            IS_PURCHASE_SAVED: 1,
            P_PRICE_COUNT: ATeklif.OFFER_ROWS.FIYAT_VERILEN,
            PIDS: [],
          };
          for (let j = 0; j < ATeklif.OFFER_ROWS.ROWS.length; j++) {
            var ARow = ATeklif.OFFER_ROWS.ROWS[j];
            var P = {
              PID: ARow.PRODUCT_ID,
              SID: ARow.STOCK_ID,
              QUANTITY: ARow.QUANTITY,
              UNIQUE_RELATION_ID: ARow.UNIQUE_RELATION_ID,
              PRODUCT_CODE_2: ARow.MANUFACT_CODE,
              PRODUCT_UNIT: ARow.MAIN_UNIT,
            };
            O.PIDS.push(P);
          }
          SelectedCompArri.push(O);
          SelectedCompArr.push(O);
        }
        console.log(SelectedCompArr);
        console.log(SelectedCompArri);
        TedarikYaz();
      });
    }