

<cfif session.ep.USERID eq 9 OR session.ep.USERID eq 1>
    <cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService_V1")>
<cfelse>
<cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>
</cfif>


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
           <div style="display:table;width:100%">
            <select data-IS_OPTIONAL=#it.IS_OPTIONAL# <cfif listlen(RElprp) gt 0>
                onchange="iliskiliDataOlustur(this,#attributes.PRODUCT_CATID#,#it.PROPERTY_ID#,'#it.PROPERTY#')"
            </cfif> <cfif it.IS_AMOUNT EQ 1>required="true"</cfif> class="propss" name="SEARCH_PROP" data-propText="#it.PROPERTY#" id="SEARCH_PROP_#it.PROPERTY_ID#" data-PROPERTY_ID="#it.PROPERTY_ID#" onchange="console.log(this)">
                
                <option value="">Seç</option>
                <cfloop array="#CatPropertieDetails#" item="it2">
                    <option data-related_variation_id="#it2.IS_SUB_PRPT#" title="#it.PROPERTY#" value="#it2.PROPERTY_DETAIL_ID#">#it2.PROPERTY_DETAIL#</option>
                </cfloop>
            </select>
            <a style="width:5% !important" class="input-group-addon" onclick="AddVariation('SEARCH_PROP_#it.PROPERTY_ID#',#it.PROPERTY_ID#,#attributes.PRODUCT_CATID#,'RefReshProp')" href="javascript://" ><i class="fa fa-plus"></i></a>
        </div>
        </div>
    </div>
</cfloop>

</cfoutput>

<script>
    $(document).ready(function(){
        $('.propss').select2();
    })
    function iliskiliDataOlustur(el,pcat,prpt,pfrs){
        console.log(el);
        console.table({
            pcat:pcat,
            prpt:prpt,
            pfrs:pfrs
        });
        try {
            
        
        var SelEleman=$(el).select2('data')[0];
        console.log(SelEleman);
        var relVar=SelEleman.element.getAttribute('data-related_variation_id')
        var iid=SelEleman.id
       var Uri="/AddOns/YafSatis/Partner/cfc/<cfif session.ep.USERID eq 9 OR session.ep.USERID eq 1>ProductService_V1<cfelse>ProductService</cfif>.cfc?method=getPropertyDetailsWithCatId&PROPERTY_ID="+prpt+"&PRODUCT_CATID="+pcat+"&RELATED_PROP_ID="+relVar+"&RELATED_VAR_ID="+iid;
       console.log(Uri);
       
        $.ajax({
            url:Uri,
            success:function (returnData) {
                console.log(returnData)
                var Obj=JSON.parse(returnData)
                var e=document.getElementById("SEARCH_PROP_"+relVar)
                console.log(e.options)
                var iii=e.options.length;
                var ic=0;
//                 while (iii>1) {
//                     ic++
//                  try{   
//                     console.log(e.options[iii].value)
//                     e.options[iii].remove()
//                     iii=e.options.length;
//                  }  catch (error) {
//   console.error(error);
//                     console.log(iii)
//                     console.log(e.options.length)
//                     if(ic==10) return false;
                    
//                  }
//                 }
                $(e).html("");
                var option=document.createElement("option");
                option.value=""
                    option.innerText="Seç"
                    option.setAttribute("data-related_variation_id","")
                    option.setAttribute("title",pfrs)
                    e.appendChild(option);
                $(e).val(null).trigger('change');
                for (let index = 0; index < Obj.length; index++) {
                    const element = Obj[index];
                   // var newOption = new Option(element.text, element.id, false, false);
                    var option=document.createElement("option");
                    option.value=element.PROPERTY_DETAIL_ID
                    option.innerText=element.PROPERTY_DETAIL
                    option.setAttribute("data-related_variation_id",element.IS_SUB_PRPT)
                    option.setAttribute("title",element.PROPERTY)
                    e.appendChild(option);
                    /*
                    data-RELATED_VARIATION_ID="#it2.IS_SUB_PRPT#" title="#it.PROPERTY#" 
                    */
                   $(e).trigger('change');
                }

            }
        })
    } catch {
            
        }
        return true;
    }
    function AddVariation(DataIID,PROPERTY_ID,PRODUCT_CATID,cf) {
        openBoxDraggable('index.cfm?fuseaction=product.list_property&event=add-sub-property_special&PRODUCT_CATID='+PRODUCT_CATID+'&prpt_id='+PROPERTY_ID+'&IID='+DataIID+'&CallFunk='+cf);
    }
    function RefReshProp(IID,PROPERTY_DETAIL_ID,PROPERTY_DETAIL,IS_SUB_PRPT,PROPERTY) {
        var e=document.getElementById(IID)
        var option=document.createElement("option");
                    option.value=PROPERTY_DETAIL_ID
                    option.innerText=PROPERTY_DETAIL
                    option.setAttribute("data-related_variation_id",IS_SUB_PRPT)
                    option.setAttribute("title",PROPERTY)
                    e.appendChild(option);
                    /*
                    data-RELATED_VARIATION_ID="#it2.IS_SUB_PRPT#" title="#it.PROPERTY#" 
                    */
                   $(e).trigger('change')
    }
</script>