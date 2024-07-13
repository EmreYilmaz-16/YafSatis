var ServiceUri = "/AddOns/YafSatis/Partner/cfc";
$(document).ready(function () {
    var e = document.getElementById("PRODUCT_CAT");
    // var e1 = document.getElementById("MONEY");
    // var e2 = document.getElementById("PRIORITY");
    //paraBirimleri = wrk_safe_query("getMoneyList", "dsn");
    getCats(e);
    //get_consumer("", "");
  });

function getCatProperties(cat_id) {
    AjaxPageLoad(
        "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=catProps&PRODUCT_CATID=" +
          cat_id,
        "PROP_AREA",
        1,
        "Yükleniyor"
      );
  }
  function getCats(el) {
    $.ajax({
      url: ServiceUri + "/ProductService.cfc?method=getCats",
      success: function (returnData) {
        var Obje = JSON.parse(returnData);
        // console.log(Obje);
        $(el).html("");
        for (let i = 0; i < Obje.length; i++) {
          var option = document.createElement("option");
          option.value = Obje[i].PRODUCT_CATID;
          option.innerText = Obje[i].PRODUCT_CAT;
          el.appendChild(option);
        }
      },
    });
  }