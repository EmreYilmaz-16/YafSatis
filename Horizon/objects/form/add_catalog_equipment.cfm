<cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>
    <cfset Cats=ProductService.getCats()>
<cfdump var="#attributes#">
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
            <select name="PCAT">
                <cfoutput>
                <cfloop array="#Cats#" item="it">
                    <option value="#it.PRODUCT_CATID#">#it.PRODUCT_CAT#</option>
                </cfloop>
                </cfoutput>
            </select>
        </div>
    </div>
    <div class="col col-6"></div>
</div>


</cf_box>