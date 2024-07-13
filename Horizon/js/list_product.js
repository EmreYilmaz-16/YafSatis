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

  
function getFilterData() {
    var elem = document.getElementById("PRODUCT_CAT");
    var ix = elem.options.selectedIndex;
    var PRODUCT_CAT = elem.options[ix].innerText;
    var PRODUCT_CAT_ID = elem.options[ix].value;
  
    var ReturnObject = {
      PRODUCT_CAT: PRODUCT_CAT,
      PRODUCT_CAT_ID: PRODUCT_CAT_ID,
    };
    //console.table(ReturnObject);
    var SelectedValues = [];
    var ox = {
      PRODUCT_CAT: PRODUCT_CAT,
      PRODUCT_CAT_ID: PRODUCT_CAT_ID,
      PNAME: "EQUIPMENT",
      PROP_ID: 0,
      IS_OPTIONAL: 0,
    };
    SelectedValues.push(ox);
    var Properties = document.getElementsByClassName("propss");
    var PropList = "";
    PropList += PRODUCT_CAT_ID;
    //console.log(Properties)
    var DataHata = 0;
    for (let i = 0; i < Properties.length; i++) {
      var Pelem = Properties[i];
      var isReq = Pelem.getAttribute("required");
  
      var Pdata = $(Pelem).select2("data")[0];
      var PROP_ID = Pdata.element.parentElement.getAttribute("data-property_id");
      var is_optional =
        Pdata.element.parentElement.getAttribute("data-is_optional");
      //console.log($(Pelem).select2("data")[0]);
      console.log(is_optional);
      var PRODUCT_CAT = Pdata.text;
      var PRODUCT_CAT_ID = Pdata.id;
      var PNAME = Pdata.title;
      if (Pdata.id.length > 0) {
        var O = {
          PRODUCT_CAT: PRODUCT_CAT,
          PRODUCT_CAT_ID: PRODUCT_CAT_ID,
          PNAME: PNAME,
          PROP_ID: PROP_ID,
          IS_OPTIONAL: is_optional,
        };
  
        //console.table(O);
        SelectedValues.push(O);
        PropList += "," + PRODUCT_CAT_ID;
      }
      if (isReq == "true" && Pdata.id.length == 0) {
        DataHata++;
      }
    }
    ReturnObject.Filters = SelectedValues;
    ReturnObject.PropList = PropList;
    var jsn = JSON.stringify(ReturnObject);
    console.log(ReturnObject);
    if (DataHata > 0) {
      alert("Zorunlu Alanlar var !");
      return false;
    }
    var ST = new Object();
    ST.ReturnObject = ReturnObject;
    ST.jsn = jsn;
    return ST;
  }

  function AraBeni(){
    var FILTERS=getFilterData();
   document.getElementById("FormData").value=JSON.stringify(FILTERS);
document.fomr1.submit();
  }