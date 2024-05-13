<cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService_V1")>
    <cfset _Cats=ProductService.getCats()>
    <cfset Cats=deserializeJSON(_Cats)>
    <cfset _Catalogs=ProductService.getCatalogs(attributes.CatalogId)>
    <cfset Catalogs=deserializeJSON(_Catalogs)>
    <cfset ACatalog="">
    <cfif arrayLen(Catalogs)>
        <cfset ACatalog=Catalogs[1]>
    </cfif>


<cfdump var="#attributes#">
<cfdump var="#ACatalog#">
<cf_box title="Kataloga Ürün Ekle" scroll="1" collapsable="1" resize="1" popup_box="1">
<div class="row">
    <div class="col col-6">
        <div class="form-group">
            <input type="text" name="ProductName">
            <input type="hidden" name="ProductId">
            <input type="hidden" name="StockId">
        </div>
        <div class="form-group">
            <input type="text" name="ManufactCode" onkeyup="SearchProductCatalog()">
            
            
        </div>
        <div class="form-group">
            <select name="PCAT" <cfif isDefined("ACatalog.PRODUCT_CATID") AND LEN(ACatalog.PRODUCT_CATID)>disabled</cfif>>
                <cfoutput>
                <cfloop array="#Cats#" item="it">
                    <option <cfif (isDefined("ACatalog.PRODUCT_CATID") AND LEN(ACatalog.PRODUCT_CATID)) AND ACatalog.PRODUCT_CATID eq it.PRODUCT_CATID>selected</cfif>  value="#it.PRODUCT_CATID#">#it.PRODUCT_CAT#</option>
                </cfloop>
                </cfoutput>
            </select>
        </div>
    </div>
    <div class="col col-6"></div>
</div>


</cf_box>