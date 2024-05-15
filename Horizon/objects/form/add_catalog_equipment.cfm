<cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService_V1")>
    <cfset _Cats=ProductService.getCats()>
    <cfset Cats=deserializeJSON(_Cats)>
    <cfset _Catalogs=ProductService.getCatalogs(attributes.CatalogId)>
    <cfset Catalogs=deserializeJSON(_Catalogs)>
    <cfset ACatalog="">
    <cfif arrayLen(Catalogs)>
        <cfset ACatalog=Catalogs[1]>
    </cfif>



<cf_box title="Kataloga Ürün Ekle" scroll="1" collapsable="1" resize="1" popup_box="1">
    <input type="hidden" name="CatalogId" id="CatalogId" value="<cfoutput>#attributes.CatalogId#</cfoutput>">
<div class="row">
    <div class="col col-6">
        <div class="form-group">
            <label>Ürün Adı</label>
            <input type="text" name="ProductName">
            <input type="hidden" name="ProductId">
            <input type="hidden" name="StockId">
        </div>
        <div class="form-group">
            <label>Part No</label>
            <input type="text" name="ManufactCode" onchange="SearchProductCatalog(this)">
            
            
        </div>
        <div class="form-group">
            <select name="PCAT" <cfif isDefined("ACatalog.PRODUCT_CATID") AND LEN(ACatalog.PRODUCT_CATID)>disabled</cfif> onchange="getCatPropsFSF(this)">
                <cfoutput>
                <cfloop array="#Cats#" item="it">
                    <option <cfif (isDefined("ACatalog.PRODUCT_CATID") AND LEN(ACatalog.PRODUCT_CATID)) AND ACatalog.PRODUCT_CATID eq it.PRODUCT_CATID>selected=""</cfif>  value="#it.PRODUCT_CATID#">#it.PRODUCT_CAT#</option>
                </cfloop>
                </cfoutput>
            </select>
        </div>
        <div class="form-group">
            <label>Gemi</label>
            <input type="text" name="ShipName" id="ShipName" value="<cfoutput>#ACatalog.SHIP_NAME#</cfoutput>" readonly="">
            <input type="hidden" name="ShipId" id="ShipId" value="<cfoutput>#ACatalog.SHIP_ID#</cfoutput>">
        </div>
        <div class="form-group">
            <label>Makina</label>
            <input type="text" name="MachineName" id="MachineName"  value="<cfoutput>#ACatalog.MACHINE_NAME#</cfoutput>" readonly="">
            <input type="hidden" name="MachineId" id="MachineId"  value="<cfoutput>#ACatalog.MACHINE_ID#</cfoutput>">
        </div>
        <div class="form-group">
            <label>Açıklama</label>
            <textarea name="Descr" id="Descr"></textarea>
        </div>
    </div>
    
    <div class="col col-6">
        <cfif structKeyExists(ACatalog.JSON_STRINGIM,"Filters")>
            <div style="display:flex">
            <cfloop array="#ACatalog.JSON_STRINGIM.Filters#" item="it" index="ix">
          
                <cfoutput>
                    <cfif it.PNAME neq "EQUIPMENT">
              <div class="form-group">
                    <label>#it.PNAME#</label>
                <select disabled data-IS_OPTIONAL=#it.IS_OPTIONAL#  class="propss_fs" name="SEARCH_PROP_FS" data-propText="#it.PNAME#" id="SEARCH_PROP_FS_#it.PROP_ID#" data-PROPERTY_ID="#it.PROP_ID#" onchange="getCatPropsFSF(this)">                    
                    <option value="#it.PRODUCT_CAT_ID#">#it.PRODUCT_CAT#</option>
            </select>
        </div>
        </cfif>
        </cfoutput>
            </cfloop>
            <div class="form-group">
            <label>&nbsp;</label>
                <a href="javascript://" onclick="AddPropRow()" class="ui-wrk-btn ui-wrk-btn-extra"><i class="fa fa-plus"></i></a>
        </div>
        </div>
        <cfelse>
            <div id="dv1">

            </div>
            <cfif isDefined("ACatalog.PRODUCT_CATID") AND LEN(ACatalog.PRODUCT_CATID)>
                <script>
                     AjaxPageLoad(
            "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=catProps2&PRODUCT_CATID=" +
            ACatalog.PRODUCT_CATID,
            "dv1",
            1,
            "Yükleniyor"
          );
                </script>
            </cfif>
        </cfif>
        <h5>Ürün Özellikleri</h5>
        <form name="upd_related_features" id="upd_related_features ">
        <cf_grid_list>
            <thead>
                <tr>
                    <th>
                        Özellik
                    </th>
                    <th>
                        Varyasyon
                    </th>
                    <th></th>
                </tr>
            </thead>
            <tbody id="tb1FS"> 
                
            </tbody>
        </cf_grid_list>
    </form>
    </div>
    <div>
        <a href="javascript://" onclick="KaydediverGulum()" class="ui-wrk-btn ui-wrk-btn-extra"><i class="fa fa-save"></i> Kaydet</a>
    </div>
</div>


</cf_box>

<script>
var ServiceUri = "/AddOns/YafSatis/Partner/cfc";
var PropRowCount=0;
    function getCatPropsFSF(el) {
        AjaxPageLoad(
            "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=catProps2&PRODUCT_CATID=" +
            el.value,
            "dv1",
            1,
            "Yükleniyor"
          );
    }
    function AddPropRow(PROPERTY_ID,PROPERTY_NAME,VARIATION_ID,VARIATION_NAME) {
        
PropRowCount++;
var tr=document.createElement("tr");
var td=document.createElement("td");
var inp1=document.createElement("input");
inp1.type="text";
inp1.id="Property_"+PropRowCount;
inp1.name="Property";
var inp2=document.createElement("input");
inp2.type="hidden";
inp2.id="Property_ID_"+PropRowCount;
inp2.name="Property_ID";
var div=document.createElement("div");
div.setAttribute("class","form-group");
var div2=document.createElement("div");
div2.setAttribute("class","input-group");
var Span=document.createElement("span");
Span.setAttribute("class","input-group-addon btnPointer icon-ellipsis");
Span.href="javascript://";
Span.setAttribute("onclick","pencere_pos("+PropRowCount+")");
div2.appendChild(inp1);
div2.appendChild(inp2);
div2.appendChild(Span);
div.appendChild(div2);
//<span class="input-group-addon btnPointer icon-ellipsis" href="javascript://" onclick="select_var('1');" title="Varyasyon  "></span>
td.appendChild(div);
tr.appendChild(td);

var td=document.createElement("td");
var inp1=document.createElement("input");
inp1.type="text";
inp1.id="variation"+PropRowCount;
inp1.name="Variation";
var inp2=document.createElement("input");
inp2.type="hidden";
inp2.id="variation_id"+PropRowCount;
inp2.name="Variation_ID";
var div=document.createElement("div");
div.setAttribute("class","form-group");
var div2=document.createElement("div");
div2.setAttribute("class","input-group");
var Span=document.createElement("span");
Span.setAttribute("class","input-group-addon btnPointer icon-ellipsis");
Span.href="javascript://";
Span.setAttribute("onclick","select_var("+PropRowCount+")");
div2.appendChild(inp1);
div2.appendChild(inp2);
div2.appendChild(Span);
div.appendChild(div2);
//<span class="input-group-addon btnPointer icon-ellipsis" href="javascript://" onclick="select_var('1');" title="Varyasyon  "></span>
td.appendChild(div);
tr.appendChild(td);
var td=document.createElement("td");
td.innerHtml="<a onclick='sil("+PropRowCount+")';><i class='fa fa-minus'></i></a>";
//<a onclick="sil('1');"><i class="fa fa-minus"></i></a>

tr.appendChild(td);

document.getElementById("tb1FS").appendChild(tr);

    }

    function pencere_pos(no)
        {
            openBoxDraggable('index.cfm?fuseaction=product.popup_product_properties&property=upd_related_features.Property_' + no + '&property_id=upd_related_features.Property_ID_' + no + '&is_select=1&is_product_property=1&value_deger='+no);
        }
        function select_var(crntrw)
        {
            
                openBoxDraggable('index.cfm?fuseaction=product.popup_list_variations_property&property_id=' + eval('document.getElementById("Property_ID_' + crntrw + '")').value + '&record_num_value=' + crntrw + ''); 
            
        }
        function getFilterDataPROPPS() {
  var elem = document.getElementsByName("PCAT")[0];
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
  var Properties = document.getElementsByClassName("propss_fs");
  var PropList = "";
  PropList += PRODUCT_CAT_ID;
  //console.log(Properties)
  var DataHata = 0;
  for (let i = 0; i < Properties.length; i++) {
    var Pelem = Properties[i];
    var isReq = 0

    
    var PROP_ID = Pelem.getAttribute("data-property_id");
    var is_optional =
    Pelem.getAttribute("data-is_optional");
    //console.log($(Pelem).select2("data")[0]);
    console.log(is_optional);
    var PRODUCT_CAT = Pelem.options[0].innerText;
    var PRODUCT_CAT_ID = Pelem.value;
    var PNAME = Pelem.getAttribute("data-proptext");
    if (PRODUCT_CAT_ID.length > 0) {
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
    if (isReq == "true" && PRODUCT_CAT_ID.length == 0) {
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

function KaydediverGulum(){
	var JSON_STRINGIM=getFilterDataPROPPS()
	var  ManufactCode=document.getElementsByName("ManufactCode")[0].value
var  ProductName=document.getElementsByName("ProductName")[0].value
var  ProductId=document.getElementsByName("ProductId")[0].value
var  StockId=document.getElementsByName("StockId")[0].value
var  ShipId=document.getElementsByName("ShipId")[0].value
var  MachineId=document.getElementsByName("MachineId")[0].value
var  CatalogId=document.getElementsByName("CatalogId")[0].value
var ExtraPropArr=new Array();
for(let i=1;i<=PropRowCount;i++){
	var PROPERTY=document.getElementById("Property_"+i).value
var PROPERTY_ID=document.getElementById("Property_ID_"+i).value
var VARIATION=document.getElementById("variation"+i).value
var VARIATION_ID=document.getElementById("variation_id"+i).value
var PVOB={
PROPERTY:PROPERTY,
PROPERTY_ID:PROPERTY_ID,
VARIATION:VARIATION,
VARIATION_ID:VARIATION_ID
}
ExtraPropArr.push(PVOB)

}
var Objecim={
JSON_STRINGIM:JSON_STRINGIM,
ManufactCode:ManufactCode,
ProductName:ProductName,
ProductId:ProductId,
StockId:StockId,
ShipId:ShipId,
MachineId:MachineId,
CatalogId:CatalogId,
ExtraPropArr:ExtraPropArr
}

$.ajax({
    url:ServiceUri+"/CatalogService.cfc?method=AddProductToCatalog",
    data:{
        data:JSON.stringify(Objecim)
    },
    success:function (ReturnData) {
        
    }
})


console.log(Objecim)
}
function SearchProductCatalog(el) {
    var keyword = el.value;


var SearchMainValue= getFilterDataPROPPS().ReturnObject

var Search = {
  SearchMainValue: SearchMainValue,
  keyword: keyword,
};
$.ajax({
    url: ServiceUri + "/ProductService_V1.cfc?method=SearchProduct",
    data: {
      FormData: JSON.stringify(Search),
    },
    success: function (returnData) {
        console.log(returnData);
        var ReturnObject=JSON.parse(returnData);
        if(ReturnObject.RECORD_COUNT >=1){
            if(ReturnObject.RECORD_COUNT>=1){
                document.getElementsByName("ProductName")[0].setAttribute("style","font-weight:bold;color:orange")
                document.getElementsByName("ManufactCode")[0].setAttribute("style","font-weight:bold;color:orange")
                var btn = document.createElement("button");
          btn.setAttribute("class", "btn btn-warning");

          btn.innerHTML = "<i class='icn-md fa fa-search'></i>";
          document.getElementsByName("ManufactCode")[0].parentElement.appendChild(btn);
          document.getElementsByName("ManufactCode")[0].parentElement.setAttribute("style", "display:flex");
          var tt=getFilterDataPROPPS()
          btn.setAttribute(
            "onclick",
            "openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=getCollation&tip=2&rc=" +
              0 +
              "&kw=" +
              document.getElementsByName("ManufactCode")[0].value +
              "&prp_list=" +
              tt.ReturnObject.PropList +
              "')"
          )

                
            }else{
                document.getElementsByName("ProductId")[0].value=ReturnObject.PRODUCT_ID
                document.getElementsByName("StockId")[0].value=ReturnObject.STOCK_ID
                document.getElementsByName("ProductName")[0].value=ReturnObject.PRODUCT_NAME
                document.getElementsByName("ProductName")[0].setAttribute("style","font-weight:bold;color:green")
                document.getElementsByName("ManufactCode")[0].setAttribute("style","font-weight:bold;color:green")
            }
        }else{

        }
    }})
}
function SetRow(PRODUCT_ID,STOCK_ID,MANUFACT_CODE,PRODUCT_NAME,modal_id) {
    /*
    
    */
    document.getElementsByName("ProductId")[0].value=PRODUCT_ID
                document.getElementsByName("StockId")[0].value=STOCK_ID
                document.getElementsByName("ProductName")[0].value=PRODUCT_NAME
                document.getElementsByName("ManufactCode")[0].value=MANUFACT_CODE
                document.getElementsByName("ProductName")[0].setAttribute("style","font-weight:bold;color:green")
                document.getElementsByName("ManufactCode")[0].setAttribute("style","font-weight:bold;color:green")
                


                
                closeBoxDraggable(modal_id)



}
</script>