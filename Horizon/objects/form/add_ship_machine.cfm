﻿

<cfif session.ep.USERID eq 9 OR session.ep.USERID eq 1>
    <cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService_V1")>
<cfelse>
<cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>
</cfif>

<cfset ShipService=createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>

<cfset _ProductCatArray=ProductService.getCats()>
<cfset ProductCatArray=deserializeJSON(_ProductCatArray)>
<cfset _Ship=ShipService.GetShips(ShipId=attributes.WESSEL_ID)>
<cfset Ship=deserializeJSON(_Ship)>

<cf_box title="#Ship[1].SHIP_NAME# - Makina Ekle" scroll="1" collapsable="1" resize="1" popup_box="1">
    
<input type="hidden" name="WESSEL_ID" id="WESSEL_ID" value="<cfoutput>#attributes.WESSEL_ID#</cfoutput>">
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
    <div class="form-group" style="width:49.5%">
        <label>Makina Adı</label>
        <input type="text" name="MACHINE_NAME" id="MACHINE_NAME">
    </div>
    <div style="width:1%"></div>
    <div class="form-group" style="width:49.5%">
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


<script>
    function SaveMachine(uid,modal_id) {
        var PCAT=document.getElementById("PCAT").value
var MACHINE_NAME=document.getElementById("MACHINE_NAME").value
var SERIAL_NO=document.getElementById("SERIAL_NO").value
var DESCRIPTION=document.getElementById("DESCRIPTION").value
var WESSEL_ID=document.getElementById("WESSEL_ID").value
var SendData={
  PCAT:PCAT,
MACHINE_NAME:MACHINE_NAME,
SERIAL_NO:SERIAL_NO,
DESCRIPTION:DESCRIPTION,
WESSEL_ID:WESSEL_ID

};
console.table(SendData)

$.ajax({
    url:"/AddOns/YafSatis/Partner/cfc/ShipService.cfc?method=SaveMachine",
    data:{data:JSON.stringify(SendData)}
})

    }
</script>