

<cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>

<cfset getWesselProducts=ProductService.getWesselProducts(attributes.WesselId)>
<cfset WesselProducts=deserializeJSON(getWesselProducts)>
<cfset getCats=ProductService.getCats()>
<cfset Equipments=deserializeJSON(getCats)>


<cf_box title="Ürünler" scroll="1" collapsable="1" resize="1" popup_box="1">
  
  <!---- <cf_box>
   <table>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        Equipment
                    </label>
                    <select name="EQ0001" id="EQ0001" onchange="filterPP(this)">
                        <option value="">Seç</option>
                        <cfoutput>
                            <cfloop array="#Equipments#" item="it">
                                <option value="#it.PRODUCT_CATID#">#it.PRODUCT_CAT#</option>
                            </cfloop>
                        </cfoutput>
                    </select>
                </div>
                
            </td>
            <TD>
              <div class="form-group">
                <label>Keyword</label>
                <input type="text" onkeyup="filterPPtxt(this)">
              </div>
            </TD>
            <td>
                <div id="PROP_AREA_00001" style="display:flex">

                </div> 
            </td>
        </tr>
    </table>
</cf_box>---->

  <cfloop  array="#WesselProducts#" item="it2" index="iy">
    <cf_seperator title="#it2.PRODUCT_CAT#" id="item_#iy#">
      <div class="ui-info-text" id="item_<cfoutput>#iy#</cfoutput>"  style="display:none;">
        <div class="form-group">
          
          <input type="text" onkeyup="filterPPtxt(this,<cfoutput>#iy#</cfoutput>)" placeholder="Search">
        </div>
        <cfset PRODUCT_ARR=it2.PRODUCT_ARR>
        <cf_big_list id="MYRT_#iy#">
          <thead>
            <tr>
              <th>
                Part No
              </th>
              <th>
                Ürün
              </th>
              <th></th>
              <th></th>
            </tr>
          </thead>
          <cfoutput>
            <tbody >
          <cfloop array="#PRODUCT_ARR#" item="it" index="ix">
            <tr data-proplist="#it.PROP_LIST#">
              <td>
                <a href="##" onclick="EkleCanimBenim(#ix#)">#it.MANUFACT_CODE#</a>
                <input type="hidden" name="PROP_LIST" id="PROP_LIST#ix#" value="#it.PROP_LIST#">
                <input type="hidden" name="PRODUCT_NAME" id="PRODUCT_NAME#ix#" value="#it.PRODUCT_NAME#">
                <input type="hidden" name="MANUFACT_CODE" id="MANUFACT_CODE#ix#" value="#it.MANUFACT_CODE#">
                <input type="hidden" name="PRODUCT_ID" id="PRODUCT_ID#ix#" value="#it.PRODUCT_ID#">
                <input type="hidden" name="STOCK_ID" id="STOCK_ID#ix#" value="#it.STOCK_ID#">
                <input type="hidden" name="MAIN_UNIT" id="MAIN_UNIT#ix#" value="#it.MAIN_UNIT#">
                <input type="hidden" name="TAX" id="TAX#ix#" value="#it.TAX#">
                <input type="hidden" name="JSON_STRINGIM" id="JSON_STRINGIM#ix#" value='#it.JSON_STRINGIM#'>
            </td>
            <td>
              #it.PRODUCT_NAME#
          </td>
          <TD>
            <cfset KMK=deserializeJSON(it.JSON_STRINGIM)>
            
            <cfloop array="#KMK.Filters#" item="it2" index="jx">
                #it2.PRODUCT_CAT#-&gt;
            </cfloop>
        </TD>
        <td>
         <!--- <cfloop array="#it.PC_JSOIN#" item="it3" index="iz">
              <button>
                <b>#it3.PROPERTY#</b><br>
                #it3.PPD[1].PROPERTY_DETAIL#
              </button>
          </cfloop>---->
        </td>
            </tr>
          </cfloop>
        </tbody>
        </cfoutput>
        </cf_big_list>
      </div>
  </cfloop>
  
      <!----  <cfloop array="#WesselProducts#" item="it" index="ix">
            <tr data-proplist="#it.PROP_LIST#">
               
                
                
            </tr>
        </cfloop>---->
 


</cf_box>
<script>
var EMRECIMMMMM="";
    function EkleCanimBenim(iiix) {
        var PROP_LIST=$("#PROP_LIST"+iiix).val()
        var PRODUCT_ID=$("#PRODUCT_ID"+iiix).val()
        var STOCK_ID=$("#STOCK_ID"+iiix).val()
        var MAIN_UNIT=$("#MAIN_UNIT"+iiix).val()
        var TAX=$("#TAX"+iiix).val()
        var JSON_STRINGIM=$("#JSON_STRINGIM"+iiix).val()
        console.log(JSON_STRINGIM)
        var PRODUCT_NAME=$("#PRODUCT_NAME"+iiix).val()
        var MANUFACT_CODE=$("#MANUFACT_CODE"+iiix).val()
        EMRECIMMMMM=JSON.parse(JSON_STRINGIM);
        
        var jsn = JSON.stringify(EMRECIMMMMM);
        addEqRow(EMRECIMMMMM, jsn)
        addRowCrs(PROP_LIST, PRODUCT_ID,  STOCK_ID,  PRODUCT_NAME, 0,  MANUFACT_CODE,  1,  MAIN_UNIT,  0,  "TL",  0,  0, 0,  0,  "",0,0) 
    }
    function filterPP(el) {
        var ix = el.options[el.selectedIndex].innerText;
        console.log(el.value);
        console.log(el.value.length);
        if (el.value.length == 0) {
            $("#my1 tr").filter(function () {
            $(this).show();
            
    });
    return false;
}
    console.log(el);
    $("#my1 tr").filter(function () {
      $(this).toggle($(this).text().indexOf(ix) > -1);
    });
   // Cra(el.value);
  }

  function filterPPtxt(el,iitxx) {
        var ix = el.value
        console.log(el.value);
        console.log(el.value.length);
        if (el.value.length == 0) {
          $("#MYRT_"+iitxx+" tr").filter(function () {
            $(this).show();
            
    });
    return false;
}
    console.log(el);
    $("#MYRT_"+iitxx+" tr").filter(function () {
      $(this).toggle($(this).text().indexOf(ix) > -1);
    });
   // Cra(el.value);
  }

  

function filterPP2(el,iitxx) {
  var ix = el.options[el.selectedIndex].innerText;
  console.log(el.value);
  console.log(el.value.length);
  if (el.value.length == 0) {
    $("#MYRT_"+iitxx+" tr").filter(function () {
      $(this).show();
      
    });
    return false;
  }
  $("#MYRT_"+iitxx+" tr").filter(function () {
    $(this).toggle($(this).text().indexOf(ix) > -1);
  });
  //  Cra(el.value);
}

function Cra(cat_id) {
  $("#PROP_AREA_00001").html("");
  $.ajax({
    url:
      "/AddOns/YafSatis/Partner/cfc/ProductService.cfc?method=getCatProperties&PRODUCT_CATID=" +
      cat_id,
    success: function (retdat) {
      var Obje = JSON.parse(retdat);
      for (let i = 0; i < Obje.length; i++) {
        var PRP = Obje[i];
        var div = document.createElement("div");
        div.setAttribute("class", "form-group");
        var Label = document.createElement("label");
        Label.innerText = Obje[i].PROPERTY;
        var Sel = document.createElement("Select");
        Sel.setAttribute("style", "margin-left:5px");
        Sel.setAttribute("onchange", "filterPP2(this)");
        Sel.setAttribute("data-propertyId", Obje[i].PROPERTY_ID);
        Sel.id = "SELECT_00_" + Obje[i].PROPERTY_ID;
        var Opt = document.createElement("option");
        Opt.value = "";
        Opt.innerText = "Seç";
        Sel.appendChild(Opt);
        div.appendChild(Label);
        div.appendChild(Sel);
        document.getElementById("PROP_AREA_00001").appendChild(div);

        getOptions(cat_id, Obje[i].PROPERTY_ID);
      }
    },
  });
}
function getOptions(PRODUCT_CAT_ID, PROPERTY_ID, SELECTED_ID) {
  console.log(arguments);
  //var PSL=document.getElementById("PropList_1").value
  //var PS=JSON.parse(PSL);
  //console.log(PS)
  $.ajax({
    url:
      "/AddOns/YafSatis/Partner/cfc/ProductService.cfc?method=getPropertyDetailsWithCatId&PRODUCT_CATID=" +
      PRODUCT_CAT_ID +
      "&PROPERTY_ID=" +
      PROPERTY_ID,
    success: function (params) {
      var Obj = JSON.parse(params);
      console.log(Obj);
      if (Obj.length == 0) {
        $("#SELECT_00_" + PROPERTY_ID)
          .parent()
          .remove();
      }
      for (let i = 0; i < Obj.length; i++) {
        var aVariation = Obj[i];

        var Opt = document.createElement("option");
        Opt.value = aVariation.PROPERTY_DETAIL_ID;
        Opt.innerText = aVariation.PROPERTY_DETAIL;

        document
          .getElementById("SELECT_00_" + aVariation.PROPERTY_ID)
          .appendChild(Opt);

        //  console.log(aVariation);
      }
    },
  });
}
</script>