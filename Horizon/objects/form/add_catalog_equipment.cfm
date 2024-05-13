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
            <select name="PCAT" <cfif isDefined("ACatalog.PRODUCT_CATID") AND LEN(ACatalog.PRODUCT_CATID)>disabled</cfif>>
                <cfoutput>
                <cfloop array="#Cats#" item="it">
                    <option <cfif (isDefined("ACatalog.PRODUCT_CATID") AND LEN(ACatalog.PRODUCT_CATID)) AND ACatalog.PRODUCT_CATID eq it.PRODUCT_CATID>selected=""</cfif>  value="#it.PRODUCT_CATID#">#it.PRODUCT_CAT#</option>
                </cfloop>
                </cfoutput>
            </select>
        </div>
    </div>
    <div class="col col-6">
        <cfif structKeyExists(ACatalog.JSON_STRINGIM,"Filters")>
            <cfloop array="#ACatalog.JSON_STRINGIM.Filters#" item="it" index="ix">
             <cfoutput>
                <label>#it.PNAME#</label>
                <select disabled data-IS_OPTIONAL=#it.IS_OPTIONAL#  class="propss_fs" name="SEARCH_PROP_FS" data-propText="#it.PNAME#" id="SEARCH_PROP_FS_#it.PROP_ID#" data-PROPERTY_ID="#it.PROP_ID#" onchange="getCatPropsFSF(this)">                    
                    <option value="#it.PRODUCT_CAT_ID#">#it.PRODUCT_CAT#</option>
            </select>
        </cfoutput>
            </cfloop>
        <cfelse>
            <div id="dv1">

            </div>
            <cfif isDefined("ACatalog.PRODUCT_CATID") AND LEN(ACatalog.PRODUCT_CATID)>
                <script>
                     AjaxPageLoad(
            "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=catProps&PRODUCT_CATID=" +
            ACatalog.PRODUCT_CATID,
            "dv1",
            1,
            "Yükleniyor"
          );
                </script>
            </cfif>
        </cfif>
    </div>
</div>


</cf_box>

<script>
    function getCatPropsFSF(el) {
        AjaxPageLoad(
            "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=catProps&PRODUCT_CATID=" +
            el.value,
            "dv1",
            1,
            "Yükleniyor"
          );
    }
</script>