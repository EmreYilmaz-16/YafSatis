

<cfif session.ep.USERID eq 9 OR session.ep.USERID eq 1>
    <cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService_V1")>
<cfelse>
<cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>
</cfif>
<cfset _ProductCatArray=ProductService.getCats()>
<cfset ProductCatArray=deserializeJSON(_ProductCatArray)>


<cf_box title="Makina Ekle" scroll="1" collapsable="1" resize="1" popup_box="1">

<div class="form-group">
    <label>Ekipman</label>
    <select name="PCAT" id="PCAT">
        <cfoutput>
            <cfloop array="#ProductCatArray#" item="aProductCat" index="x">
                <option value="#aProductCat.PRODUCT_CATID#">#aProductCat.PRODUCT_CAT#</option>
            </cfloop>
        </cfoutput>
    </select>
</div>
<div style="display:flex">
    <div class="form-group">
        <label>Makina Adı</label>
        <input type="text" name="MACHINE_NAME" id="MACHINE_NAME">
    </div>
    <div class="form-group">
        <label>Seri No</label>
        <input type="text" name="SERIAL_NO" id="SERIAL_NO">
    </div>
</div>
<div class="form-group">
    <label>Açıklama</label>
    <textarea name="DESCRIPTION" id="DESCRIPTION"></textarea>
</div>
<div>
    <button type="button" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left" onclick="SaveMachine(<cfoutput>#session.ep.userid#,'#attributes.modal_id#'</cfoutput>)" ><span class="icn-md icon-save">Kaydet</button>
</div>
</cf_box>
