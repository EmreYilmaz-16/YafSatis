<cf_box title="Ürünler" scroll="1" collapsable="1" resize="1" popup_box="1">
<input type="hidden" name="PropList_0" id="PropList_0" value="<cfoutput>#attributes.PropList#</cfoutput>">
<input type="hidden" name="PropList_1" id="PropList_1" value="">

<div id="APX_0" style="display:flex">
<div class="form-group">
    <label>Keyword</label>
    <input type="text" name="keyword_000" id="keyword_000">
</div>
</div>
<button onclick="LoadProducts()">Ara</button>
<div id="APX_1">

</div>
<cf_ajax_list>
    <thead id="Th000">
        <th>Part No</th>
        <th>Ürün</th>
        <th></th>
    </thead>
    <tbody id="Tb000">
        
    </tbody>
</cf_ajax_list>
</cf_box>
<script>
    $(document).ready(function (){
        var p_list=document.getElementById("PropList_0").value;
        var es=document.getElementById("AddedEquipment_"+p_list)
        console.log(es.value);
        document.getElementById("PropList_1").value=es.value;
        var PS=JSON.parse(es.value);
        
        LoadProps(PS.PRODUCT_CAT_ID);
    })
    function LoadProps(Pcat){
        $.ajax({
            url:"/AddOns/YafSatis/Partner/cfc/ProductService.cfc?method=getCatProperties&PRODUCT_CATID="+Pcat,
            success:function(retdat){
                var Obj=JSON.parse(retdat);
                console.log(Obj)
                for(let i=0;i<Obj.length;i++){
                    var div=document.createElement("div");
                    div.setAttribute("class","form-group");
var Label=document.createElement("label");
Label.innerText=Obj[i].PROPERTY
                    var Sel=document.createElement("Select");
                    Sel.setAttribute("style","margin-left:5px");
                    Sel.setAttribute("onchange","propduzenle(this)");
                    Sel.setAttribute("data-propertyId",Obj[i].PROPERTY_ID)
                    Sel.id="SELECT_00_"+Obj[i].PROPERTY_ID;
                    var Opt=document.createElement("option");
                    Opt.value="";
                    Opt.innerText="Seç";
                    Sel.appendChild(Opt);
                    div.appendChild(Label)
                    div.appendChild(Sel)
                    document.getElementById("APX_0").appendChild(div)
                    
                    getOptions(Pcat,Obj[i].PROPERTY_ID)
                }
            }
        })
    }

    function getOptions(PRODUCT_CAT_ID,PROPERTY_ID,SELECTED_ID){
       console.log(arguments);
        var PSL=document.getElementById("PropList_1").value
        var PS=JSON.parse(PSL);
        console.log(PS)
        $.ajax({
            url:"/AddOns/YafSatis/Partner/cfc/ProductService.cfc?method=getPropertyDetailsWithCatId&PRODUCT_CATID="+PRODUCT_CAT_ID+"&PROPERTY_ID="+PROPERTY_ID,
            success:function (params) {
                var Obj=JSON.parse(params);
                console.log(Obj);
                if(Obj.length==0){
                    $("#SELECT_00_"+PROPERTY_ID).parent().remove();
                }
                for(let i=0;i<Obj.length;i++){
                    var aVariation=Obj[i];
                    var SelectedVar=PS.Filters.findIndex(p=>p.PRODUCT_CAT_ID==aVariation.PROPERTY_DETAIL_ID.toString());
                    
                    var Opt=document.createElement("option");
                    Opt.value=aVariation.PROPERTY_DETAIL_ID;
                    Opt.innerText=aVariation.PROPERTY_DETAIL
                    if(SelectedVar != -1){
                        Opt.setAttribute("selected","true");
                        document.getElementById("SELECT_00_"+aVariation.PROPERTY_ID).setAttribute("disabled","true");
                    }
                    document.getElementById("SELECT_00_"+aVariation.PROPERTY_ID).appendChild(Opt);
                    
                  //  console.log(aVariation);
                }
            }
        })
    }
    function propduzenle(el) {
        var PRODUCT_CAT=el.options[el.selectedIndex].innerText;
        var PRODUCT_CAT_ID=el.options[el.selectedIndex].value;
        var PropId=el.getAttribute("data-propertyId");
        var PSL=document.getElementById("PropList_1").value
        var PS=JSON.parse(PSL);
        console.log(PS);
        var ix=PS.Filters.findIndex(p=>p.PROP_ID==PropId);
        if(ix == -1){
            var Ox={
                PNAME:"REV",
                PRODUCT_CAT:PRODUCT_CAT,
                PRODUCT_CAT_ID:PRODUCT_CAT_ID,
                PROP_ID:PropId
            }
            PS.Filters.push(Ox)
        }else{
            var Ox={
                PNAME:"REV",
                PRODUCT_CAT:PRODUCT_CAT,
                PRODUCT_CAT_ID:PRODUCT_CAT_ID,
                PROP_ID:PropId
            }
            PS.Filters[ix]=Ox;
        }
        document.getElementById("PropList_1").value=JSON.stringify(PS);
    }
    function LoadProducts(){
       var SearchMainValue=JSON.parse(document.getElementById("PropList_1").value)
       var keyword=document.getElementById("keyword_000").value;
        var Search = {
        SearchMainValue: SearchMainValue,
        keyword: keyword,
        };

  $.ajax({
    url: ServiceUri + "/ProductService.cfc?method=SearchProductPopup",
    data: {
      FormData: JSON.stringify(Search),
    },success:function (params) {
        var Obj=JSON.parse(params);
        console.log(Obj)
        $("#APX_1").html("");
        $("#Tb000").html("");
        for(let i=0;i<Obj.OTHER_PROPERTIES.length;i++){
            var aProperty=Obj.OTHER_PROPERTIES[i];
            
            var div=document.createElement("div");
                    div.setAttribute("class","form-group");
var Label=document.createElement("label");
Label.innerText=aProperty.PROPERTY
                    var Sel=document.createElement("Select");
                    Sel.setAttribute("style","margin-left:5px");
                    Sel.setAttribute("onchange","propduzenle(this)");
                    Sel.setAttribute("data-propertyId",aProperty.PROPERTY_ID)
                    Sel.id="SELECT_00_"+aProperty.PROPERTY_ID;
                    var Opt=document.createElement("option");
                    Opt.value="";
                    Opt.innerText="Seç";
                    Sel.appendChild(Opt);
                    
                    for(let j=0;j<aProperty.VARIATIONS.length;j++){
                        var opt=document.createElement("option")
                        opt.value=aProperty.VARIATIONS[j].PROPERTY_DETAIL_ID
                        opt.innerText=aProperty.VARIATIONS[j].PROPERTY_DETAIL
                        Sel.appendChild(opt)
                    }
                    div.appendChild(Label)
                    div.appendChild(Sel)
                    document.getElementById("APX_1").appendChild(div)
        }
        for(let i=0;i<Obj.PRODUCTS.length;i++){
           var aProduct=Obj.PRODUCTS[i];
            var tr=document.createElement("tr");
            var td=document.createElement("td");
            td.innerText=aProduct.MANUFACT_CODE;
            tr.appendChild(td)
            var td=document.createElement("td");
            td.innerText=aProduct.PRODUCT_NAME;
            tr.appendChild(td)
            var td=document.createElement("td");
            td.innerHtml=aProduct.DTP;
            tr.appendChild(td)
            document.getElementById("Tb000").appendChild(tr)
        }
    }
    })}
</script>