//BILGI  Satınalma Fiyat Karşılaştırmada Tüm Teklifler İçin Kullanılabilir
/*



*/
document.getElementByOfferId = function (idb) {
  var str = idb.toString();
  var el = $("*").find("* [data-offer_id='" + str + "']");
  return el;
};

function SetMarj(el, tip) {
  var marji = parseFloat(el.value);
  var TeklifId = el.getAttribute("data-offerid");
  if (tip == 1) {
    var TeklifArr = GelenTekliflList.split(",");
  } else {
    var TeklifArr = [TeklifId];
  }

  console.log(TeklifArr);
  var StTotal = 0;
  for (let j = 0; j < TeklifArr.length; j++) {
    var STATotal = 0;
    var RVS = document.getElementByOfferId(TeklifArr[j]);
    for (let i = 0; i < RVS.length; i++) {
      var ex = $(RVS[i]).find("input[type='radio']");
      //  console.log(ex)
      if ($(ex).is(":checked")) {
        console.log(ex);
        var ef = $(RVS[i]).find("span[name='F2']");
        var FF = $(ef).text();
        var Fiy = FF.trim();
        Fiy = filterNum(Fiy);
        Fiy = parseFloat(Fiy);
        console.log(Fiy);
        // var marji = 10;
        var FiyN = Fiy + (Fiy * marji) / 100;
        var Mik = $("#MIK_" + (i + 1)).text();
        console.log("Miktar=" + Mik);
        Mik = parseFloat(Mik);
        STATotal += FiyN * Mik;
        $(RVS[i]).find("span[name='F3']").text(commaSplit(FiyN, 2));
      }

      StTotal += STATotal;
    }
    console.log("Offer" + TeklifArr[j] + "Toplamı =" + STATotal);
    $("#toplam_fiyat_DOVA_PBS_" + TeklifArr[j]).text(commaSplit(STATotal, 2));
  }
  console.log("Son Toplam =" + StTotal);
}

function FiyatOnayKayit(for_offer_id) {
  var exxx = document.getElementsByClassName("rdddd");
  var pfArr = [];
  for (let index = 0; index < exxx.length; index++) {
    var ex = exxx[index];

    if ($(ex).is(":checked")) {
      console.log(ex.value);
      var ox = {
        offer_id: list_getat(ex.value, 1, "-"),
        wrkrowid: list_getat(ex.value, 2, "-"),
      };
      pfArr.push(ox);
    }
  }
  var ox = {
    for_offer_id: for_offer_id,
    pfArr: pfArr,
  };
  $.ajax({
    url: "/AddOns/YafSatis/Partner/cfc/OfferService.cfc?method=FiyatOnayKayit",
    data: {
      data: JSON.stringify(ox),
    },
    success: function (retDat) {
      $.notification(["Kayıt Edildi"], {
        messageType: "error",
      });
    },
  });
}
