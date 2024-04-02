<cf_box>
    <input type="text" name="VariationName" id="VariationName">
<input type="hidden" name="PROPERTY_ID" id="PROPERTY_ID" value="<cfoutput>#attributes.modal_id#</cfoutput>">
    
</cf_box>


<script>
    function SaveThisPRP(){
        var vari=document.getElementById("VariationName").val;
        var PROPERTY_ID=document.getElementById("PROPERTY_ID").val;
        
    }
</script>