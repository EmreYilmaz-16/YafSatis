<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&list_type=import_offer_rows" enctype="multipart/form-data" >
    <div class="form-group">
        <input type="file" name="file_11" id="file_11">
        <input type="hidden"  name="FileName" id="FileName"> 
    </div>
  
<input type="submit">
<input type="hidden" name="is_submit">
</cfform>

<cfif isDefined("attributes.is_submit")>
    <cffile action = "upload"
    fileField = "file_11"
    destination = "#expandPath("./ExDosyalar")#" 
    nameConflict = "Overwrite" result="resul"> 

    <cfspreadsheet  action="read" src = "#expandPath("./ExDosyalar/#attributes.fileName#")#" query = "res">

    <cfquery name = "get_invoice_no" dbtype = "query" result="ressa">
        SELECT * FROM res     
    </cfquery>  
<cfloop from="1" to="#get_invoice_no.recordCount#" index="ix">

<cfif get_invoice_no.COL_1[ix] eq 0>
    <cfset HIERARCHY=get_invoice_no.COL_3[ix]>
    
    <CFSET PROP_LIST="">

    <cfquery name="GETCAT" datasource="#DSN1#">
        SELECT PRODUCT_CAT_ID FROM PRODUCT_CAT WHERE HIERARCHY='#HIERARCHY#'
    </cfquery>
    <CFSET PROP_LIST=listAppend(PROP_LIST,GETCAT.PRODUCT_CAT_ID)>
</cfif>

<cfif get_invoice_no.COL_1[ix] eq 1>
    <cfquery name="GET_PROPERTY" datasource="#DSN1#">
        SELECT * FROM PRODUCT_PROPERTY WHERE PROPERTY='#get_invoice_no.COL_2[ix]#'
    </cfquery>

    <cfquery name="GET_PROPERTY_DETAIL" datasource="#DSN1#">
        select * from CatalystQA_product.PRODUCT_PROPERTY_DETAIL WHERE PRPT_ID=#GET_PROPERTY.PROPERTY_ID# AND PROPERTY_DETAIL='#get_invoice_no.COL_3[ix]#'
    </cfquery>

<CFSET PROP_LIST=listAppend(PROP_LIST,GET_PROPERTY_DETAIL.PROPERTY_DETAIL_ID)>


</cfif>
<cfif get_invoice_no.COL_1[ix] eq 2>
<cfdump var="#PROP_LIST#">
</cfif>

</cfloop>



</cfif>


<script>    
    $('#file_11').change(function(e){
    var fileName = e. target. files[0]. name;
    $("#FileName").val(fileName)
    });
    </script>