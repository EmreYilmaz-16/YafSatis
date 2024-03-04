﻿

<cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>

<cfset CatPropertiesJson=ProductService.getCatProperties(PRODUCT_CATID=attributes.PRODUCT_CATID)>
<cfset CatProperties=deserializeJSON(CatPropertiesJson)>

<cfoutput>
<cfloop array="#CatProperties#" item="it">
    <div class="form-group col col-1 col-md-1 col-sm-1 col-xs-12">
        <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
            <label class="margin-bottom-5 bold font-sm">#it.PROPERTY#</label>
            <cfset CatPropertieDetailsJson=ProductService.getPropDetails(PROPERTY_ID=it.PROPERTY_ID)>
                <cfset CatPropertieDetails=deserializeJSON(CatPropertieDetailsJson)>
            <select class="propss" name="SEARCH_PROP" id="SEARCH_PROP_#it.PROPERTY_ID#" data-PROPERTY_ID="#it.PROPERTY_ID#" onchange="console.log(this)">
                
                <option value="">Seç</option>
                <cfloop array="#CatPropertieDetails#" item="it2">
                    <option value="#it2.PROPERTY_DETAIL_ID#|#it2.IS_SUB_PRPT#">#it2.PROPERTY_DETAIL#</option>
                </cfloop>
            </select>
        </div>
    </div>
</cfloop>
</cfoutput>

<script>
    $(document).ready(function(){
        $('.propss').select2();
    })
</script>