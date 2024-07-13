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
    <cfset ProductList_=ProductService.SearchProductPopup(FormData=attributes.FormData)>
    
    <cfset ProductList=deserializeJSON(ProductList_)>
    <cfdump var="#ProductList#">
</cfif>
<cf_big_list>
    <thead>
        <tr>
            <th>
                Part No
            </th>
            <th>
                Product Code
            </th>
            <th>
                Product Name
            </th>
            <cfquery name="getpc" datasource="#dsn1#">
                SELECT PP.PROPERTY_ID,PP.PROPERTY FROM CatalystQA_product.PRODUCT_CAT_PROPERTY AS PCP 
LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PCP.PROPERTY_ID
where PRODUCT_CAT_ID=#attributes.PRODUCT_CAT#
            </cfquery>
<cfloop query="getpc">
    <th>
        <cfoutput>#PROPERTY#</cfoutput>
    </th>
</cfloop>
        </tr>
    </thead>
    <tbody>
        <cfloop array="#ProductList.PRODUCTS#" item="it">
            <tr>
                <td><cfoutput>#it.MANUFACT_CODE#</cfoutput></td>
                <td><cfoutput>#it.PRODUCT_CODE#</cfoutput></td>
                <td><cfoutput>#it.PRODUCT_NAME#</cfoutput></td>
                <cfset PPLIST=deserializeJSON(it.DTP)>
                <cfloop query="getpc">
                    <td>
                        <cfset IIIS=arrayFilter(PPLIST,function(item){
                            return item.PROPERTY_ID==getpc.PROPERTY_ID
                        })>
                        <cfloop array="#IIS#" item="it2">
                        <cfoutput>#it2.PROPERTY_DETAIL#</cfoutput>
                        </cfloop>
                    </td>
                </cfloop>

            </tr>
        </cfloop>
    </tbody>

</cf_big_list>

</cf_box>

<script src="/AddOns/YafSatis/Horizon/js/list_product.js"></script>
