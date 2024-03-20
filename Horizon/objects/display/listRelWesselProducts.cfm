

<cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>

<cfset getWesselProducts=ProductService.getWesselProducts(attributes.WesselId)>
<cfset WesselProducts=deserializeJSON(getWesselProducts)>


<cf_box title="Ürünler" scroll="1" collapsable="1" resize="1" popup_box="1">
    <cf_box>
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
                        <option data-RELATED_VARIATION_ID="#it2.IS_SUB_PRPT#" title="#it.PROPERTY#" value="#it2.PROPERTY_DETAIL_ID#">#it2.PROPERTY_DETAIL#</option>
                    </cfloop>
                </select>
            </div>
        </div>
    </cfloop>
    </cfoutput>
</cf_box>
<cf_ajax_list>
    <thead>
        <tr>
            <th>
                Part No
            </th>
            <th>
                Ürün
            </th>
            <th>

            </th>
        </tr>
    </thead>
    <cfoutput>
        <cfloop array="#WesselProducts#" item="it" index="ix">
            <tr>
                <td>
                    <a href="##" onclick="EkleCanimBenim(#ix#)">
                    #it.MANUFACT_CODE#
                </a>
                    <input type="hidden" name="PROP_LIST" id="PROP_LIST#ix#" value="#it.PROP_LIST#">
                    <input type="hidden" name="PRODUCT_NAME" id="PRODUCT_NAME#ix#" value="#it.PRODUCT_NAME#">
                    <input type="hidden" name="MANUFACT_CODE" id="MANUFACT_CODE#ix#" value="#it.MANUFACT_CODE#">
                    <input type="hidden" name="PRODUCT_ID" id="PRODUCT_ID#ix#" value="#it.PRODUCT_ID#">
                    <input type="hidden" name="STOCK_ID" id="STOCK_ID#ix#" value="#it.STOCK_ID#">
                    <input type="hidden" name="MAIN_UNIT" id="MAIN_UNIT#ix#" value="#it.MAIN_UNIT#">
                    <input type="hidden" name="TAX" id="TAX#ix#" value="#it.TAX#">
                    <input type="hidden" name="JSON_STRINGIM" id="JSON_STRINGIM#ix#" value='#it.JSON_STRINGIM#'>
                </td>
                <td>
                    #it.PRODUCT_NAME#
                </td>
                <TD>
                    <cfset KMK=deserializeJSON(it.JSON_STRINGIM)>
                    
                    <cfloop array="#KMK.Filters#" item="it2" index="jx">
                        #it2.PRODUCT_CAT#-&gt;
                    </cfloop>
                </TD>
            </tr>
        </cfloop>
    </cfoutput>
</cf_ajax_list>

</cf_box>
<script>
    function EkleCanimBenim(iiix) {
        var PROP_LIST=$("#PROP_LIST"+iiix).val()
        var PRODUCT_ID=$("#PRODUCT_ID"+iiix).val()
        var STOCK_ID=$("#STOCK_ID"+iiix).val()
        var MAIN_UNIT=$("#MAIN_UNIT"+iiix).val()
        var TAX=$("#TAX"+iiix).val()
        var JSON_STRINGIM=$("#JSON_STRINGIM"+iiix).val()
        console.log(JSON_STRINGIM)
        var PRODUCT_NAME=$("#PRODUCT_NAME"+iiix).val()
        var MANUFACT_CODE=$("#MANUFACT_CODE"+iiix).val()
        
        var Ro={
            Filters:JSON.parse(JSON_STRINGIM),
            PropList:PROP_LIST
        }
        var jsn = JSON.stringify(Ro);
        addEqRow(Ro, jsn)
        addRowCrs(PROP_LIST, PRODUCT_ID,  STOCK_ID,  PRODUCT_NAME, 0,  MANUFACT_CODE,  1,  MAIN_UNIT,  0,  "TL",  0,  0, 0,  0,  "",0,0) 
    }
</script>