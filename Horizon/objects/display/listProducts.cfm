<input type="hidden" name="PropList_0" id="PropList_0" value="<cfoutput>#attributes.PropList#</cfoutput>">
<div id="APX_0">

</div>
<div id="APX_1">

</div>

<script>
    $(document).ready(function (){
        var p_list=document.getElementById("PropList_0").value;
        var es=document.getElementById("AddedEquipment_"+p_list)
        console.log(es.value);
        
    })
    function LoadProps(Pcat){
        $.ajax({
            url:"/AddOns/YafSatis/Partner/cfc/ProductService.cfc?method=getCatProperties&PRODUCT_CATID="+Pcat,
            success:function(retdat){
                var Obj=JSON.parse(retdat);
                console.log(obj)
            }
        })
    }
</script>