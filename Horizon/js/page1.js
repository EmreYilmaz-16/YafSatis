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

function LoadOffers(tip,vl) {
  if (tip == "Cust") {
    //Filters.ForCustomer
    if(Filters.ForCustomer==1 && vl==1) Filters.ForCustomer=0; else Filters.ForCustomer=1;
    if(Filters.ForCustomer==0 && vl==1) Filters.ForCustomer=1; else Filters.ForCustomer=1;

    if(Filters.ForCustomer==2 && vl==2) Filters.ForCustomer=0; else Filters.ForCustomer=2;
    if(Filters.ForCustomer==0 && vl==2) Filters.ForCustomer=2; else Filters.ForCustomer=2;


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
