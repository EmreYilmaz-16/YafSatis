var ServiceUri = "/AddOns/YafSatis/Partner/cfc";
$(document).ready(function () {
  var e = document.getElementById("OFFER_CURRENCY");
  var e1 = document.getElementById("MONEY");
  var e2 = document.getElementById("PRIORITY");
  var e3 = document.getElementById("DELIVERY_PLACE");
  var e4 = document.getElementById("SHIP_METHOD_ID");
  var e5 = document.getElementById("OFFER_CONDITION");
  getOfferCurrencies(e);
  getMoney(e1);
  getOfferPriorities(e2);
  getDeliveryPlaces(e3);
  getShipMethods(e4);
  getOfferConditions(e5);
});
var MoneyArr = [];
function openShipList() {
  var CustomerId = document.getElementById("Addcompany_id").value;
  if (CustomerId.length > 0) {
    openBoxDraggable(
      "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=getWessels&CustomerId=" +
        CustomerId
    );
  } else {
    alert("Müşteri Seçmediniz");
  }
}

function getOfferCurrencies(el) {
  var DP_ID=el.getAttribute("data-value");
  $.ajax({
    url: ServiceUri + "/OfferService.cfc?method=getOfferCurrencies",
    success: function (returnData) {
      var Obje = JSON.parse(returnData);
      console.log(Obje);
      $(el).html("");
      for (let i = 0; i < Obje.length; i++) {
        var option = document.createElement("option");
        option.value = Obje[i].OFFER_CURRENCY_ID;
        option.innerText = Obje[i].OFFER_CURRENCY;
        if(DP_ID.length>0 && parseInt(DP_ID)==Obje[i].OFFER_CURRENCY_ID){
          option.setAttribute("selected","selected");
        }
        el.appendChild(option);
      }
    },
  });
}
function getDeliveryPlaces(el) {
  var DP_ID=el.getAttribute("data-value");
  $.ajax({
    url: ServiceUri + "/OfferService.cfc?method=getDeliveryPlaces",
    success: function (returnData) {
      var Obje = JSON.parse(returnData);
      console.log(Obje);
      $(el).html("");
      for (let i = 0; i < Obje.length; i++) {
        var option = document.createElement("option");
        option.value = Obje[i].DELIVERY_PLACE_ID;
        option.innerText = Obje[i].DELIVERY_PLACE;
        if(DP_ID.length>0 && parseInt(DP_ID)==Obje[i].DELIVERY_PLACE_ID){
          option.setAttribute("selected","selected");
        }
        el.appendChild(option);
        /*DELIVERY_PLACE_ID,DELIVERY_PLACE*/
      }
    },
  });
}
function getOfferConditions(el) {
  var DP_ID=el.getAttribute("data-value");
  $.ajax({
    url: ServiceUri + "/OfferService.cfc?method=getOfferConditions",
    success: function (returnData) {
      var Obje = JSON.parse(returnData);
      console.log(Obje);
      $(el).html("");
      for (let i = 0; i < Obje.length; i++) {
        var option = document.createElement("option");
        option.value = Obje[i].ID;
        option.innerText = Obje[i].CONDITION;
        if(DP_ID.length>0 && parseInt(DP_ID)==Obje[i].ID){
          option.setAttribute("selected","selected");
        }
        el.appendChild(option);
        /*DELIVERY_PLACE_ID,DELIVERY_PLACE ID=ID,
                    CONDITION=CONDITION*/
      }
    },
  });
}

function getShipMethods(el) {
  var DP_ID=el.getAttribute("data-value");
  $.ajax({
    url: ServiceUri + "/OfferService.cfc?method=getShipMethods",
    success: function (returnData) {
      var Obje = JSON.parse(returnData);
      console.log(Obje);
      $(el).html("");
      for (let i = 0; i < Obje.length; i++) {
        var option = document.createElement("option");
        option.value = Obje[i].SHIP_METHOD_ID;
        option.innerText = Obje[i].SHIP_METHOD;
        if(DP_ID.length>0 && parseInt(DP_ID)==Obje[i].SHIP_METHOD_ID){
          option.setAttribute("selected","selected");
        }
        el.appendChild(option);
        /*DELIVERY_PLACE_ID,DELIVERY_PLACE*/
      }
    },
  });
}

function getMoney(el) {
  var DP_ID=el.getAttribute("data-value");
  $.ajax({
    url: ServiceUri + "/OfferService.cfc?method=getOfferMoney",
    success: function (returnData) {
      var Obje = JSON.parse(returnData);
      console.log(Obje);
      $(el).html("");
      var option = document.createElement("option");
      option.value ="";
      option.innerText = "Seçiniz";
      el.appendChild(option);
      for (let i = 0; i < Obje.length; i++) {
        var option = document.createElement("option");
        option.value = Obje[i].MONEY;
        option.innerText = Obje[i].MONEY;
        if(DP_ID.length>0 && parseInt(DP_ID)==Obje[i].MONEY){
          option.setAttribute("selected","selected");
        }
        el
        el.appendChild(option);
        MoneyArr.push(Obje[i]);
      }
      $("#rate1").val(1);
      $("#rate2").val(1);
    },
  });
}
function setMoney(el) {
  var ix = MoneyArr.findIndex((p) => p.MONEY == el.value);
  $("#rate1").val(MoneyArr[ix].RATE1);
  $("#rate2").val(MoneyArr[ix].RATE2);
  $("#selected_money").val(MoneyArr[ix].MONEY);
}

function getOfferPriorities(el) {
  $.ajax({
    url: ServiceUri + "/OfferService.cfc?method=getOfferPriorities",
    success: function (returnData) {
      var Obje = JSON.parse(returnData);
      console.log(Obje);
      $(el).html("");
      for (let i = 0; i < Obje.length; i++) {
        var option = document.createElement("option");
        option.value = Obje[i].PRIORITY_ID;
        option.innerText = Obje[i].PRIORITY;
        el.appendChild(option);
      }
    },
  });
}
function SaveOfferHeader() {
  var OFFER_CURRENCY = $("#OFFER_CURRENCY").val();
  var COMPANY_ID = $("#Addcompany_id").val();
  var COMPANY_NAME = $("#Addcompany").val();
  var SHIP_NAME = $("#ship_name").val();
  var SHIP_ID = $("#ship_id").val();
  var TRANSIT_WAREHOUSE = $("#TW").val();

  var REF_NO = $("#AddRefNo").val();
  var OFFER_DATE = $("#start_date").val();
  var SHIP_METHOD_ID = $("#SHIP_METHOD_ID").val();
  var ix = document.getElementById("SHIP_METHOD_ID").options.selectedIndex;
  var SHIP_METHOD =
    document.getElementById("SHIP_METHOD_ID").options[ix].innerText;
  var PRIORITY = $("#PRIORITY").val();
  var VALID_DAYS = $("#validDay").val();
  var VALID_DATE = $("#validtyDate").val();
  var DELIVERY_PLACE = $("#DELIVERY_PLACE").val();
  var DELIVERY_ADDRESS = $("#DELIVERY_ADDRESS").val();
  var DELIVERY_DATE = $("#delivery_date").val();
  var DELIVERY_TYIME = $("#DVTime").val();
  var MONEY = $("#MONEY").val();
  if (MONEY.length == 0) $("#Money");
  var OFFER_CONDITION = $("#OFFER_CONDITION").val();
  var OFFER_DETAIL = $("#OfferDetail").val();
  var PROPERTY1 = $("#PROPERTY1").val();
  var PROPERTY2 = $("#PROPERTY2").val();
  var PROPERTY3 = $("#PROPERTY3").val();
  var PROPERTY4 = $("#PROPERTY4").val();
  var OFFER_MONEY = $("#selected_money").val();
  var RATE1 = $("#rate1").val();
  var RATE2 = $("#rate2").val();
  var ACTIVECOMPANY = $("#ACTIVECOMPANY").val();
  var SALES_EMP_ID = $("#SALES_EMP_ID").val();
  var SALES_EMP = $("#SALES_EMP").val();

  var O = {
    OFFER_CURRENCY: OFFER_CURRENCY,
    COMPANY_ID: COMPANY_ID,
    COMPANY_NAME: COMPANY_NAME,
    SHIP_NAME: SHIP_NAME,
    SHIP_ID: SHIP_ID,
    TRANSIT_WAREHOUSE: TRANSIT_WAREHOUSE,
    REF_NO: REF_NO,
    OFFER_DATE: OFFER_DATE,
    SHIP_METHOD_ID: SHIP_METHOD_ID,
    SHIP_METHOD: SHIP_METHOD,
    PRIORITY: PRIORITY,
    VALID_DAYS: VALID_DAYS,
    VALID_DATE: VALID_DATE,
    DELIVERY_PLACE: DELIVERY_PLACE,
    DELIVERY_ADDRESS: DELIVERY_ADDRESS,
    DELIVERY_DATE: DELIVERY_DATE,
    DELIVERY_TYIME: DELIVERY_TYIME,
    MONEY: MONEY,
    OFFER_CONDITION: OFFER_CONDITION,
    OFFER_DETAIL: OFFER_DETAIL,
    PROPERTY1: PROPERTY1,
    PROPERTY2: PROPERTY2,
    PROPERTY3: PROPERTY3,
    PROPERTY4: PROPERTY4,
    KURLAR: MONEY_ARR,
    OFFER_MONEY: OFFER_MONEY,
    DATA_SOURCES: DataSources,
    RATE1: RATE1,
    RATE2: RATE2,
    ACTIVECOMPANY: ACTIVECOMPANY,
    SALES_EMP_ID: SALES_EMP_ID,
    SALES_EMP: SALES_EMP,
  };

  $.ajax({
    url: ServiceUri + "/OfferService.cfc?method=SaveOfferHeader",
    data: {
      Fdata: JSON.stringify(O),
    },
    success: function (retdat) {
      console.log("Kaydettim");
      var Obj = JSON.parse(retdat);
      if (Obj.STATUS == 1) {
        window.location.href =
          "/index.cfm?fuseaction=sale.emptypopup_hrz_pbs_sayfa3&offer_id=" +
          Obj.OFFER_ID;
      }
    },
  });
}

/**
 * <input type="hidden" name="rate1" id="rate1">
                                <input type="hidden" name="rate2" id="rate2">
 */


