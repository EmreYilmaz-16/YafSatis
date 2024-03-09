function getDashBoard(){
    var Uri="/AddOns/YafSatis/partner/cfc/OfferService.cfc?method=getOfferDashBoard"
    $.ajax({
        url:Uri,
        success:function (retDat){
            var Obje=JSON.parse(retDat);
            console.table(Obje)
        }
    })
}