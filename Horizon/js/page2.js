var ServiceUri = "/AddOns/YafSatis/Partner/cfc";
$(document).ready(function () {
  var e = document.getElementById("OFFER_CURRENCY");
  var e1 = document.getElementById("MONEY");
  var e2 = document.getElementById("PRIORITY");
  var e3 = document.getElementById("DELIVERY_PLACE");
  var e4=document.getElementById("SHIP_METHOD_ID");
  var e5=document.getElementById("OFFER_CONDITION");
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
        el.appendChild(option);
      }
    },
  });
}
function getDeliveryPlaces(el) {
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
        el.appendChild(option);
        /*DELIVERY_PLACE_ID,DELIVERY_PLACE*/
      }
    },
  });
}
function getOfferConditions(el) {
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
        el.appendChild(option);
        /*DELIVERY_PLACE_ID,DELIVERY_PLACE ID=ID,
                    CONDITION=CONDITION*/
      }
    },
  });
}

function getShipMethods(el) {
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
        el.appendChild(option);
        /*DELIVERY_PLACE_ID,DELIVERY_PLACE*/
      }
    },
  });
}

function getMoney(el) {
  $.ajax({
    url: ServiceUri + "/OfferService.cfc?method=getOfferMoney",
    success: function (returnData) {
      var Obje = JSON.parse(returnData);
      console.log(Obje);
      $(el).html("");
      for (let i = 0; i < Obje.length; i++) {
        var option = document.createElement("option");
        option.value = Obje[i].MONEY;
        option.innerText = Obje[i].MONEY;
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
/**
 * <input type="hidden" name="rate1" id="rate1">
                                <input type="hidden" name="rate2" id="rate2">
 */
