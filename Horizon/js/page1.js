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
    if (Filters.Stage != vl && Filters.ForCustomer != vl2) {
      Filters.Stage = vl;
      Filters.ForCustomer = vl2;
    } else {
      Filters.Stage = 0;
      Filters.ForCustomer = 0;
    }

    var exlems = document.getElementsByClassName("filterb");
    for (let index = 0; index < exlems.length; index++) {
      var bs = exlems[index].getAttribute("data-stage");
      var bi = exlems[index].id;
      console.log(bs);
      console.log(bi);
      bs = parseInt(bs);
      if (bs == Filters.Stage) {
        console.log("Burdayım"+bi)
        setActive(bi);
      } else {
        console.log("Burdayım !"+bi)
        setDeActive(bi);
      }
    }

    /*
      Customer Inquiry	        261	1
      Supplier Inquiry	        262	1
      Confirmed Customer Inquiry	263	1
      Customer Offer	            264	2
      Customer Inquiry	        266	2
      Supplier Inquiry        	267	2
    */
    /* if (Filters.Stage == 261) {
      setActive("SOC_1_261");
      setDeActive("SOC_1_262");
      setDeActive("SOC_1_263");
      setDeActive("SOC_2_264");
      setDeActive("SOC_2_266");
      setDeActive("SOC_2_267");
    } else if (Filters.Stage==262){
      setDeActive("SOC_1_261");
      setActive("SOC_1_262");
      setDeActive("SOC_1_263");
      setDeActive("SOC_2_264");
      setDeActive("SOC_2_266");
      setDeActive("SOC_2_267");
    } 
     else {
      setDeActive("SOC_1_261");
      setDeActive("SOC_1_262");
      setDeActive("SOC_1_263");
      setDeActive("SOC_2_264");
      setDeActive("SOC_2_266");
      setDeActive("SOC_2_267");
    }*/

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
function setActive(id) {
  $("#" + id).removeClass("ui-btn-outline-success");
  $("#" + id).addClass("ui-btn-success");
}
function setDeActive(id) {
  $("#" + id).removeClass("ui-btn-success");
  $("#" + id).addClass("ui-btn-outline-success");
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
