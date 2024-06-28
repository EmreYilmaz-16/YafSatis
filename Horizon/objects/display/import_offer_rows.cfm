<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&LISTTYPE=import_offer_rows" enctype="multipart/form-data" >
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
    <CFSET OTC=structNew()>
    <cfset HIERARCHY=get_invoice_no.COL_3[ix]>
    
    <CFSET PROP_LIST="">
    <CFSET JSON_ARRA=arrayNew(1)>

    <cfquery name="GETCAT" datasource="#DSN1#">
        SELECT PRODUCT_CATID,PRODUCT_CAT FROM PRODUCT_CAT WHERE HIERARCHY='#HIERARCHY#'
    </cfquery>
    <CFSET OX=structNew()>
    <CFSET PROP_LIST=listAppend(PROP_LIST,GETCAT.PRODUCT_CATID)>
    <CFSET OX.PRODUCT_CAT=GETCAT.PRODUCT_CAT>
    <CFSET OX.PRODUCT_CATID=GETCAT.PRODUCT_CATID>
    <CFSET OX.PNAME="EQUIPMENT">
    <CFSET OX.PROP_ID=0>
    <CFSET OX.IS_OPTIONAL=0>
    <!----
         PRODUCT_CAT: PRODUCT_CAT,
    PRODUCT_CAT_ID: PRODUCT_CAT_ID,
    PNAME: "EQUIPMENT",
    PROP_ID: 0,
    IS_OPTIONAL: 0,---->

    <cfscript>
        arrayAppend(JSON_ARRA,OX);
    </cfscript>
    <cfset OTC.PRODUCT_CAT=GETCAT.PRODUCT_CAT>
<cfset OTC.PRODUCT_CAT_ID=GETCAT.PRODUCT_CATID>
</cfif>

<cfif get_invoice_no.COL_1[ix] eq 1>
    <cfquery name="GET_PROPERTY" datasource="#DSN1#">
        SELECT * FROM PRODUCT_PROPERTY WHERE PROPERTY='#get_invoice_no.COL_2[ix]#'
    </cfquery>
    <cfset PRTPT_ID=0>
<cfif GET_PROPERTY.recordCount>
    <cfset PRTPT_ID=GET_PROPERTY.PROPERTY_ID>
<cfelse>
    <cfquery name="ins" datasource="#dsn1#" result="PROPERTY_INSERT_RESULT">
        INSERT INTO PRODUCT_PROPERTY (PROPERTY,IS_ACTIVE,P_C) values('#get_invoice_no.COL_2[ix]#',1,'C')
    </cfquery>
    <CFSET PRTPT_ID=PROPERTY_INSERT_RESULT.IDENTITYCOL>

</cfif>
    

    <cfquery name="GET_PROPERTY_DETAIL" datasource="#DSN1#">
        select * from CatalystQA_product.PRODUCT_PROPERTY_DETAIL WHERE PRPT_ID=#PRTPT_ID# AND PROPERTY_DETAIL='#get_invoice_no.COL_3[ix]#'
    </cfquery>
    <cfset PRVTID=0>
<cfif GET_PROPERTY_DETAIL.recordCount>
    <cfset PRVTID=GET_PROPERTY_DETAIL.PROPERTY_DETAIL_ID>
<cfelse>
    <cfquery name="ins" datasource="#dsn1#" result="PROPERTY_DETAIL_INSERT_RESULT">
        INSERT INTO PRODUCT_PROPERTY_DETAIL (PRPT_ID,PROPERTY_DETAIL,IS_ACTIVE) VALUES (#PRTPT_ID#,'#get_invoice_no.COL_3[ix]#',1)
    </cfquery>
    <CFSET PRVTID=PROPERTY_DETAIL_INSERT_RESULT.IDENTITYCOL>
    
    <cfquery name="ins2" datasource="#dsn1#">
        INSERT INTO CatalystQA_product.PRODUCT_CAT_VARIATIONS (PRODUCT_CATID,PROPERTY_ID,VARIATION_ID) VALUES(#GETCAT.PRODUCT_CATID#,#PRTPT_ID#,#PRVTID#)
    </cfquery>
</cfif>

<CFSET PROP_LIST=listAppend(PROP_LIST,PRVTID)>
<cfset OX=structNew()>
<CFSET OX.PRODUCT_CAT=get_invoice_no.COL_3[ix]>
<CFSET OX.PRODUCT_CATID=PRVTID>
<CFSET OX.PNAME="#get_invoice_no.COL_2[ix]#">
<CFSET OX.PROP_ID=PRTPT_ID>
<CFSET OX.IS_OPTIONAL=0>
<cfscript>
    arrayAppend(JSON_ARRA,OX);
</cfscript>

</cfif>



<cfif get_invoice_no.COL_1[ix] eq 2>
<cfdump var="#PROP_LIST#">
<cfdump var="#OTC#">
<cfset OTC.PropList=PROP_LIST>
<cfset OTC.Filters=JSON_ARRA>

<cfset jstring=replace(serializeJSON(OTC),"//","")>
<cfquery name="ihvp" datasource="#dsn3#">
    SELECT * FROM STOCKS WHERE MANUFACT_CODE='#get_invoice_no.COL_2[ix]#'
</cfquery>
<script>
    var excalibur=<cfoutput>#jstring#</cfoutput>;
    window.opener.addEqRow_01(excalibur, JSON.stringify(excalibur)) 
<cfoutput>
    window.opener.addRowCrs('#PROP_LIST#', "<cfif len(ihvp.PRODUCT_ID)>#ihvp.PRODUCT_ID#<cfelse>0</cfif>",  "<cfif len(ihvp.PRODUCT_ID)>#ihvp.STOCK_ID#<cfelse>0</cfif>",  "#get_invoice_no.COL_3[ix]#", "#ihvp.TAX#",  "#get_invoice_no.COL_2[ix]#",  #get_invoice_no.COL_4[ix]#,  "#get_invoice_no.COL_5[ix]#",  #0#,  "#0#",  #0#,  #0#, #0#,  #0#,  "",0,0,<cfif ihvp.recordCount>0<cfelse>1</cfif>,'',<cfif ihvp.recordCount gt 1>1<cfelse>0</cfif>) 
</cfoutput>
   window.opener.AlayiniHesapla(); 
</script>
</cfif>


</cfloop>

<script>
    alert("Tamamlandı")
   // this.close();
</script>


</cfif>


<script>    
    $('#file_11').change(function(e){
    var fileName = e. target. files[0]. name;
    $("#FileName").val(fileName)
    });
    </script>





