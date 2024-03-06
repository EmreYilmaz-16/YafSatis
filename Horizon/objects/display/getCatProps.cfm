

<cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>

<cfset CatPropertiesJson=ProductService.getCatProperties(PRODUCT_CATID=attributes.PRODUCT_CATID)>
<cfset CatProperties=deserializeJSON(CatPropertiesJson)>

<cfoutput>
    
<cfloop array="#CatProperties#" item="it">
    <cfset CatPropertieDetailsJson=ProductService.getPropertyDetailsWithCatId(PROPERTY_ID=it.PROPERTY_ID,PRODUCT_CATID=attributes.PRODUCT_CATID)>
    <cfset CatPropertieDetails=deserializeJSON(CatPropertieDetailsJson)>
    <cfset RElprp="">
    <cfloop array="#CatPropertieDetails#" item="itx">
        <cfset RElprp="#RElprp#,#itx.IS_SUB_PRPT#">
    </cfloop>
      <cfdump var="#listlen(RElprp)#">

    <div class="form-group col col-1 col-md-1 col-sm-1 col-xs-12">
        <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
            <label class="margin-bottom-5 bold font-sm">#it.PROPERTY# <cfif it.IS_AMOUNT EQ 1><span style="color:red;font-weight:bold">*</span></cfif></label>
           
            <select <cfif listlen(RElprp) gt 0>
                onchange="iliskiliDataOlustur(this,#attributes.PRODUCT_CATID#,#it.PROPERTY_ID#)"
            </cfif> <cfif it.IS_AMOUNT EQ 1>required="true"</cfif> class="propss" name="SEARCH_PROP" data-propText="#it.PROPERTY#" id="SEARCH_PROP_#it.PROPERTY_ID#" data-PROPERTY_ID="#it.PROPERTY_ID#" onchange="console.log(this)">
                
                <option value="">Seç</option>
                <cfloop array="#CatPropertieDetails#" item="it2">
                    <option data-RELATED_VARIATION_ID=#it2.IS_SUB_PRPT# title="#it.PROPERTY#" value="#it2.PROPERTY_DETAIL_ID#">#it2.PROPERTY_DETAIL#</option>
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
    function iliskiliDataOlustur(el,pcat,prpt){
        var SelEleman=$(el).select2('data')[0];
        var relVar=SelEleman.element.getAttribute('data-related_variation_id')
        var iid=SelEleman.id
       var Uri="/AddOns/YafSatis/Partner/cfc/ProductService.cfc?method=getPropertyDetailsWithCatId&PROPERTY_ID="+prpt+"&PRODUCT_CATID="+pcat+"&RELATED_VAR_ID="+iid+"&iid="+iid;
       console.log(Uri);
       return false;
        $.ajax({
            url:Uri,
            success:function (returnData) {
                console.log(returnData)
            }
        })
    }
</script>