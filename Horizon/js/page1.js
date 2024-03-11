$(document).ready(function () {
  getDashBoard();
  // getOfferList();
});
function getDashBoard() {
  var Uri =
    "/AddOns/YafSatis/partner/cfc/OfferService.cfc?method=getOfferDashBoard";
  $.ajax({
    url: Uri,
    success: function (retDat) {
      var Obje = JSON.parse(retDat);
      console.log(Obje);
      for (let i = 0; i < Obje.OFFER_CURRENCY_TOTALS.length; i++) {
        var elem = Obje.OFFER_CURRENCY_TOTALS[i];
        document.getElementById("OC_" + elem.CURRENCY_ID).innerText =
          elem.CURRENCY_COUNT;
      }
      for (let i = 0; i < Obje.OFFER_STAGE_TOTALS.length; i++) {
        var elem = Obje.OFFER_STAGE_TOTALS[i];
        document.getElementById(
          "OC_" + elem.CURRENCY_ID + "_" + elem.PROCESS_ROW_ID
        ).innerText = elem.STAGE_COUNT;
      }
    },
  });
}

function LoadOffers(tip, vl, vl2) {
  if (tip == "Cust") {
    //Filters.ForCustomer
    if (Filters.ForCustomer == 1 && vl == 1) Filters.ForCustomer = 0;
    else if (Filters.ForCustomer == 0 && vl == 1) Filters.ForCustomer = 1;
    else if (Filters.ForCustomer == 2 && vl == 2) Filters.ForCustomer = 0;
    else if (Filters.ForCustomer == 0 && vl == 2) Filters.ForCustomer = 2;
    else Filters.ForCustomer = vl;
    console.warn(vl);
    console.log(Filters);
   
  } else if (tip == "STG") {
    if (Filters.Stage != vl) {
      Filters.Stage = vl;
      Filter.ForCustomer = vl2;
    } else {
      Filters.Stage = 0;
      Filter.ForCustomer = 0;
    }
    if (Filters.Stage == 261) {
      if (vl2 == 1) {
        $("#SOC_1_261").removeClass("ui-btn-ui-btn-outline-success");
        $("#SOC_1_261").addClass("ui-btn-success");

        $("#SOC_1_263").removeClass("ui-btn-success");
        $("#SOC_1_262").removeClass("ui-btn-success");
        $("#SOC_2_261").removeClass("ui-btn-success");
        $("#SOC_2_262").removeClass("ui-btn-success");
        $("#SOC_2_264").removeClass("ui-btn-success");

        $("#SOC_1_263").addClass("ui-btn-outline-success");
        $("#SOC_1_262").addClass("ui-btn-outline-success");
        $("#SOC_2_261").addClass("ui-btn-outline-success");
        $("#SOC_2_262").addClass("ui-btn-outline-success");
        $("#SOC_2_264").addClass("ui-btn-outline-success");
      } else {
        $("#SOC_2_261").removeClass("ui-btn-outline-success");
        $("#SOC_2_261").addClass("ui-btn-success");

        $("#SOC_1_263").removeClass("ui-btn-success");
        $("#SOC_1_262").removeClass("ui-btn-success");
        $("#SOC_1_261").removeClass("ui-btn-success");
        $("#SOC_2_262").removeClass("ui-btn-success");
        $("#SOC_2_264").removeClass("ui-btn-success");

        $("#SOC_1_263").addClass("ui-btn-outline-success");
        $("#SOC_1_262").addClass("ui-btn-outline-success");
        $("#SOC_1_261").addClass("ui-btn-outline-success");
        $("#SOC_2_262").addClass("ui-btn-outline-success");
        $("#SOC_2_264").addClass("ui-btn-outline-success");
      }
      /* SOC_1_261
      SOC_1_263
      SOC_1_262
      SOC_2_261
      SOC_2_262
      SOC_2_264
      
      
      ui-btn-outline-success 
      ui-btn-success 
      */
    }
    if (Filters.ForCustomer == 1) {
      $("#Cust1").removeClass("ui-btn-update");

      $("#Cust1").removeClass("ui-btn-outline-update");
      $("#Cust1").addClass("ui-btn-update");
      $("#Cust2").removeClass("ui-btn-update");
      $("#Cust2").addClass("ui-btn-outline-update");
    } else if (Filters.ForCustomer == 2) {
      $("#Cust2").removeClass("ui-btn-update");
      $("#Cust2").removeClass("ui-btn-outline-update");
      $("#Cust2").addClass("ui-btn-update");
      $("#Cust1").removeClass("ui-btn-update");
      $("#Cust1").addClass("ui-btn-outline-update");
    } else {
      $("#Cust2").removeClass("ui-btn-update");
      $("#Cust1").removeClass("ui-btn-update");
      $("#Cust1").addClass("ui-btn-outline-update");
      $("#Cust2").addClass("ui-btn-outline-update");
    }
  }
}
//OfferList
// function getOfferList() {
//   var Uri = "/AddOns/YafSatis/partner/cfc/OfferService.cfc?method=getOfferList";
//   $.ajax({
//     url: Uri,
//     success: function (retDat) {
//         var OfferList=JSON.parse(retDat);
//         OfferList.forEach(element => {
//             console.log(element)
//             var tr=document.createElement("tr");
//             var td=document.createElement("td");
//             td.innerText=element.OFFER_DATE;
//             tr.appendChild(td);
//             var td=document.createElement("td");
//             td.innerText=element.REF_NO;
//             tr.appendChild(td);
//             var td=document.createElement("td");
//             td.innerText=element.NICKNAME;
//             tr.appendChild(td);
//             var td=document.createElement("td");
//             td.innerText=element.DELIVERY_ADDRESS;
//             tr.appendChild(td);
//             var td=document.createElement("td");
//             td.innerText=element.SHIP_METHOD;
//             tr.appendChild(td);
//             document.getElementById("OfferList").appendChild(tr);
//         });
//     },
//   });
// }
