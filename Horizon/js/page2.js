var ServiceUri="/AddOns/YafSatis/Partner/cfc"
$(document).ready(function(){
    var e=document.getElementById("OFFER_CURRENCY")
    getOfferCurrencies()
})
function getOfferCurrencies(el){
    $.ajax({
        url:ServiceUri+"/OfferService.cfc?method=getOfferCurrencies",
        success:function(returnData){
            var Obje=JSON.parse(returnData);
            console.log(Obje);
            $(el).html("");
            for(let i=0;i<Obje.length;i++){
                var option=document.createElement("option");
                option.value=Obje[i].OFFER_CURRENCY_ID;
                option.innerText=Obje[i].OFFER_CURRENCY;
                el.appendChild(option);
            }
        }
    })
}

