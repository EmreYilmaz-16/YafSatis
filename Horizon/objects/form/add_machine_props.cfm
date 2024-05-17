
<cfset ShipService=createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>
<cfset OfferService=createObject("component","AddOns.YafSatis.Partner.cfc.OfferService")>
<cfset _Ship=ShipService.GetShips(ShipId=attributes.WESSEL_ID)>
<cfset Ship=deserializeJSON(_Ship)>
<cfset _Amachine=ShipService.GetAMachine(attributes.SM_ID)>
<cfset Amachine=deserializeJSON(_Amachine)>

<CFSET SMF=OfferService.getShipFilters(attributes.WESSEL_ID,Amachine.PRODUCT_CATID,attributes.SM_ID)>


<cf_box title="Add Machine Properties" scroll="1" collapsable="1" resize="1" popup_box="1">
 <div style="height:70vh">
    <cfdump var="#Amachine#">
<div id="PRPPPP">
    <cfset attributes.PRODUCT_CATID=Amachine.PRODUCT_CATID>
<cfinclude template="/AddOns/YafSatis/Horizon/objects/display/getCatProps_fs.cfm">
</div>
<input type="hidden" name="PCAT_MP" id="PCAT_MP" value="<cfoutput>#Amachine.PRODUCT_CAT_M#</cfoutput>">
<input type="hidden" name="PCATID_MP" id="PCATID_MP" value="<cfoutput>#attributes.PRODUCT_CATID#</cfoutput>">
<input type="hidden" name="WESSEL_ID" id="WESSEL_ID" value="<cfoutput>#attributes.WESSEL_ID#</cfoutput>">
<input type="hidden" name="SM_ID" id="SM_ID" value="<cfoutput>#attributes.SM_ID#</cfoutput>">
<button type="button" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left" onclick="SaveMachineProps(<cfoutput>#session.ep.userid#,'#attributes.modal_id#'</cfoutput>)" ><span class="icn-md icon-save">Kaydet</button>
</div>

<script>
  var JsonData=JSON.parse('<cfoutput>#SMF#</cfoutput>')
</script>
</cf_box>


<script>
    function getFilterDataFS() {
 
  var PRODUCT_CAT = document.getElementById("PCAT_MP").value;
  var PRODUCT_CAT_ID = document.getElementById("PCATID_MP").value;

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
  var Properties = document.getElementsByClassName("propss_fs");
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

function SaveMachineProps(a,b) {
    var WESSEL_ID = document.getElementById("WESSEL_ID").value;
    var SM_ID = document.getElementById("SM_ID").value;
  var FD = getFilterDataFS();
  var SEND_DATA = FD.ReturnObject;
  SEND_DATA.WESSEL_ID = WESSEL_ID;
  SEND_DATA.SM_ID = SM_ID;

  $.ajax({
    url: "/AddOns/YafSatis/Partner/cfc/OfferService.cfc?method=AddShipToFilter",
    data: {
      data: JSON.stringify(SEND_DATA),
    },
    success: function () {
      alert("Kayıt Başarılı");
    },
  });
}

$(document).ready(function (params) {
  console.log(JsonData)
  if(JsonData.STATUS ==1){
    var Pelems=document.getElementsByClassName("propss_fs")
console.log($(Pelem).select2('data')[0].element.parentElement)
/*$(Pelem).val('50173'); // Select the option with a value of '1'
$(Pelem).trigger('change'); // Notify any JS components that the value changed
*/
for(let i=0;i<JsonData.JSON_STRINGIM.Filters.length;i++){
	var F=JsonData.JSON_STRINGIM.Filters[i];
//console.log(F)
for(let j=0;j<Pelems.length;j++){
	var Pelem=Pelems[j]
	var MN=$(Pelem).select2('data')[0].element.parentElement.getAttribute("data-property_id")
	MN=parseInt(MN)
//console.log(Pelem)
//console.log(MN)
if(F.PROP_ID==MN){
$(Pelem).val(F.PRODUCT_CAT_ID); // Select the option with a value of '1'
//$(Pelem).trigger('change')
}
	}
}
  
for(let j=0;j<Pelems.length;j++){
	var Pelem=Pelems[j]

$(Pelem).trigger('change')
}
	
  }
})
</script>