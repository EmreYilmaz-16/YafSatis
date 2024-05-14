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
            <input type="text" name="ManufactCode" onkeyup="SearchProductCatalog()">
            
            
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
                </tr>
            </thead>
            <tbody id="tb1FS"> 
                
            </tbody>
        </cf_grid_list>
    </form>
    </div>
</div>


</cf_box>

<script>
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
    function AddPropRow() {
        
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
inp1.id="Variation_"+PropRowCount;
inp1.name="Variation";
var inp2=document.createElement("input");
inp2.type="hidden";
inp2.id="Variation_ID_"+PropRowCount;
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

document.getElementById("tb1FS").appendChild(tr);

    }

    function pencere_pos(no)
        {
            openBoxDraggable('index.cfm?fuseaction=product.popup_product_properties&property=upd_related_features.Property_' + no + '&property_id=upd_related_features.Property_ID_' + no + '&is_select=1&is_product_property=1&value_deger='+no);
        }
        function select_var(crntrw)
        {
            
                openBoxDraggable('index.cfm?fuseaction=product.popup_list_variations_property&property_id=' + eval('document.getElementById("property_id' + crntrw + '")').value + '&record_num_value=' + crntrw + ''); 
            
        }
</script>