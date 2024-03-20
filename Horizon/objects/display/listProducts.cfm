<cf_box title="Ürünler" scroll="1" collapsable="1" resize="1" popup_box="1">
<input type="hidden" name="PropList_0" id="PropList_0" value="<cfoutput>#attributes.PropList#</cfoutput>">
<div id="APX_0" style="display:flex">

</div>
<div id="APX_1">

</div>
</cf_box>
<script>
    $(document).ready(function (){
        var p_list=document.getElementById("PropList_0").value;
        var es=document.getElementById("AddedEquipment_"+p_list)
        console.log(es.value);
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
                    div.appendChild(Label)
                    div.appendChild(Sel)
                    document.getElementById("APX_0").appendChild(div)
                }
            }
        })
    }

    
</script>