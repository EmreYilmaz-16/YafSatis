$(document).ready(function(){
    getDashBoard();
})
function getDashBoard(){
    var Uri="/AddOns/YafSatis/partner/cfc/OfferService.cfc?method=getOfferDashBoard"
    $.ajax({
        url:Uri,
        success:function (retDat){
            var Obje=JSON.parse(retDat);
            console.log(Obje)
            for(let i=0;i<Obje.OFFER_CURRENCY_TOTALS.length;i++){
                var elem=Obje.OFFER_CURRENCY_TOTALS[i]
                document.getElementById("OC_"+elem.CURRENCY_ID).innerText=elem.CURRENCY_COUNT
            }
            for(let i=0;i<Obje.OFFER_STAGE_TOTALS.length;i++){
                var elem=Obje.OFFER_STAGE_TOTALS[i]
                document.getElementById("OC_"+elem.CURRENCY_ID+"_"+elem.PROCESS_ROW_ID).innerText=elem.STAGE_COUNT
            }
        }
    })
}