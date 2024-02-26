var ServiceUri = "/AddOns/YafSatis/Partner/cfc";
$(document).ready(function () {
  var e = document.getElementById("OFFER_CURRENCY");
  var e1 = document.getElementById("MONEY");
  getOfferCurrencies(e);
  getOfferCurrencies(e1);
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

function getMoney() {
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

/**
 * <input type="hidden" name="rate1" id="rate1">
                                <input type="hidden" name="rate2" id="rate2">
 */
