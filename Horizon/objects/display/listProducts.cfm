<cf_box title="Ürünler" scroll="1" collapsable="1" resize="1" popup_box="1">
<input type="hidden" name="PropList_0" id="PropList_0" value="<cfoutput>#attributes.PropList#</cfoutput>">
<input type="hidden" name="PropList_1" id="PropList_1" value="">

<div id="APX_0" style="display:flex">
<div class="form-group">
    <label>Keyword</label>
    <input type="text" name="keyword_000" id="keyword_000">
</div>
</div>
<button>Ara</button>
<div id="APX_1">

</div>
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
        var PropId=el.getAttribute(data-propertyId)
    }
    function LoadProducts(){

    }
</script>