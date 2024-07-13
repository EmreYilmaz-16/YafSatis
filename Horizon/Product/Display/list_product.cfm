<cf_box title="Ürünler">
<cf_box_search>
    <cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&event=list_special" name="form1" id="form1">
<div class="row">
    <div class="col col-2">
        <div class="form-group col col-12">
            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                <label class="margin-bottom-5 bold font-sm">EQUIPMENT</label>
                <div class="input-group">
                <select name="PRODUCT_CAT" id="PRODUCT_CAT" onchange="getCatProperties(this.value)">
                    
                </select>
            </div>
            </div>
        </div>
        
    </div>
    <div class="col col-9">
        <div id="PROP_AREA">

        </div>
    </div>
    <div class="col col-1">
        <a id="BUTON_1" href="javascript://" onclick="AraBeni()" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left"><i class="fa fa-repeat"></i>Ara</a>
    </div>
</div>
<input type="hidden" name="FormData" id="FormData">
<input type="hidden" name="is_submit" id="is_submit">
</cfform>
</cf_box_search>
<cfif isDefined("attributes.is_submit")>
    <cfdump var="#attributes#">

    <cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>
    <cfset ProductList=ProductService.SearchProductPopup(FormData=attributes.FormData)>
    <cfdump var="#ProductList#">

</cfif>


</cf_box>

<script src="/AddOns/YafSatis/Horizon/js/list_product.js"></script>
