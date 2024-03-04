

<cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>

<cfset CatPropertiesJson=ProductService.getCatProperties(PRODUCT_CATID=attributes.PRODUCT_CATID)>
<cfset CatProperties=deserializeJSON(CatPropertiesJson)>

<cfoutput>
<cfloop array="#CatProperties#" item="it">
    <cfset CatPropertieDetailsJson=ProductService.getPropertyDetailsWithCatId(PROPERTY_ID=it.PROPERTY_ID,PRODUCT_CATID=attributes.PRODUCT_CATID)>
    <cfset CatPropertieDetails=deserializeJSON(CatPropertieDetailsJson)>
    
      

    <div class="form-group col col-1 col-md-1 col-sm-1 col-xs-12">
        <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
            <label class="margin-bottom-5 bold font-sm">#it.PROPERTY#</label>
           
            <select class="propss" name="SEARCH_PROP" data-propText="#it.PROPERTY#" id="SEARCH_PROP_#it.PROPERTY_ID#" data-PROPERTY_ID="#it.PROPERTY_ID#" onchange="console.log(this)">
                
                <option value="">Seç</option>
                <cfloop array="#CatPropertieDetails#" item="it2">
                    <option title="#it.PROPERTY#" value="#it2.PROPERTY_DETAIL_ID#">#it2.PROPERTY_DETAIL#</option>
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