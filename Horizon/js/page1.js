$(document).ready(function () {
  getDashBoard();
  TeklifGetir();
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
  console.warn(vl);
  console.warn(vl2);
  console.warn(tip);
  if (tip == "Cust") {
    //Filters.ForCustomer
    if (Filters.ForCustomer == 1 && vl == 1) Filters.ForCustomer = 0;
    else if (Filters.ForCustomer == 0 && vl == 1) Filters.ForCustomer = 1;
    else if (Filters.ForCustomer == 2 && vl == 2) Filters.ForCustomer = 0;
    else if (Filters.ForCustomer == 0 && vl == 2) Filters.ForCustomer = 2;
    else Filters.ForCustomer = vl;

    console.log(Filters);
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
  } else if (tip == "STG") {
    if (Filters.Stage != vl) {
      Filters.Stage = vl;
      Filters.ForCustomer = vl2;
      var exlems = document.getElementsByClassName("filterb");
      for (let index = 0; index < exlems.length; index++) {
        var bs = exlems[index].getAttribute("data-stage");
        var bi = exlems[index].id;
        console.log(bs);
        console.log(bi);
        bs = parseInt(bs);
        if (bs == Filters.Stage) {
          console.log("Yaktim" + bi);
          setActive(bi);
        } else {
          console.log("Söndürdüm !" + bi);
          setDeActive(bi);
        }
      }
    } else {
      Filters.Stage = 0;
      Filters.ForCustomer = 0;
    }

  

    if (Filters.ForCustomer == 1) {
      // $("#Cust1").removeClass("ui-btn-update");

      // $("#Cust1").removeClass("ui-btn-outline-update");
      // $("#Cust1").addClass("ui-btn-update");
      // $("#Cust2").removeClass("ui-btn-update");
      // $("#Cust2").addClass("ui-btn-outline-update");
    } else if (Filters.ForCustomer == 2) {
      // $("#Cust2").removeClass("ui-btn-update");
      // $("#Cust2").removeClass("ui-btn-outline-update");
      // $("#Cust2").addClass("ui-btn-update");
      // $("#Cust1").removeClass("ui-btn-update");
      // $("#Cust1").addClass("ui-btn-outline-update");
    } else {
      // $("#Cust2").removeClass("ui-btn-update");
      // $("#Cust1").removeClass("ui-btn-update");
      // $("#Cust1").addClass("ui-btn-outline-update");
      // $("#Cust2").addClass("ui-btn-outline-update");
    }
  }
  var CompanyId = document.getElementById("company_id").value;
  var StartDate = document.getElementById("StartDate").value;
  var FinishDate = document.getElementById("FinishDate").value;
  var SalesPartnerId = document.getElementById("deliver_get_id").value;
  var PaperNo = document.getElementById("PaperNo").value;
  var RefNo = document.getElementById("customer_ref_no").value;
  Filters.CompanyId = CompanyId;
  Filters.StartDate = StartDate;
  Filters.FinishDate = FinishDate;
  Filters.SalesPartnerId = SalesPartnerId;
  Filters.PaperNo = PaperNo;
  Filters.RefNo = RefNo;
  var FormStr = JSON.stringify(Filters);
  AjaxPageLoad(
    "index.cfm?fuseaction=sales.emptypopup_ajax_list_pbs_offers&FormData=" +
      FormStr,
    "OfferListArea",
    1,
    "Yükleniyor"
  );
  /*
    CompanyId:"",
        StartDate:"",
        FinishDate:"",
        SalesPartnerId:"",
        PaperNo:"",
        RefNo:""
  
  */
}
function setActive(id) {
//  $("#" + id).removeClass("ui-btn-outline-warning");
  //$("#" + id).addClass("ui-wrk-btn-warning");
}
function setDeActive(id) {
//  $("#" + id).removeClass("ui-wrk-btn-warning");
 // $("#" + id).addClass("ui-btn-outline-warning");
}
function TeklifGetir() {
 var Filters=FiltreleriAl();
  var FormStr = JSON.stringify(Filters);
  AjaxPageLoad(
    "index.cfm?fuseaction=sales.emptypopup_ajax_list_pbs_offers&FormData=" +
      FormStr,
    "OfferListArea",
    1,
    "Yükleniyor"
  );
}
function FiltreleriAl(){
  var CompanyId = document.getElementById("company_id").value;
  var StartDate = document.getElementById("StartDate").value;
  var FinishDate = document.getElementById("FinishDate").value;
  var SalesPartnerId = document.getElementById("deliver_get_id").value;
  var PaperNo = document.getElementById("PaperNo").value;
  var RefNo = document.getElementById("customer_ref_no").value;
  var member_name=document.getElementById("member_name").value;
  if(member_name.length>0)  Filters.COMPANY_ID = CompanyId; else Filters.COMPANY_ID="";
  Filters.StartDate = StartDate;
  Filters.FinishDate = FinishDate;
  Filters.SalesPartnerId = SalesPartnerId;
  Filters.PaperNo = PaperNo;
  Filters.RefNo = RefNo;
  return Filters;
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

function Sayfala(i){

}