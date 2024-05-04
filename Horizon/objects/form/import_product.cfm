<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#" enctype="multipart/form-data" >
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
		SELECT *                 
		FROM
			res     
	</cfquery>

<cfdump var="#ressa#">

<cfloop query="get_invoice_no">
    <cfif currentrow neq 1>
    <div class="alert alert-danger">
        <CFSET VARIATION_ID_LIST="">
<cfloop from="7" to="#listLen(ressa.COLUMNLIST)#" index="i" step="4">
    <cfset IS_IMPORTANT=evaluate("get_invoice_no.COL_#i#")>
    <cfset CP=evaluate("get_invoice_no.COL_#i+1#")>
    <cfset PROPERTY=evaluate("get_invoice_no.COL_#i+2#")>
    <cfset VARIATION=evaluate("get_invoice_no.COL_#i+3#")>
<cfoutput>
    
    IS_IMPORTANT: #IS_IMPORTANT#<br>
    C/P: #CP#<br>
    PROPERTY: #PROPERTY#<br>
    VARIATION: #VARIATION#<br>

</cfoutput>
<cfquery name="isHvProperty" datasource="#dsn1#">  
SELECT * FROM PRODUCT_PROPERTY WHERE PROPERTY='#PROPERTY#' AND P_C='#CP#'
</cfquery>
<cfif isHvProperty.recordCount>
    <CFSET PROPERTY_ID=isHvProperty.PROPERTY_ID>
<cfelse>
    <cfquery name="ins" datasource="#dsn1#" result="PROPERTY_INSERT_RESULT">
        INSERT INTO PRODUCT_PROPERTY (PROPERTY,IS_ACTIVE,P_C) values('#PROPERTY#',1,'#CP#')
    </cfquery>
    <CFSET PROPERTY_ID=PROPERTY_INSERT_RESULT.IDENTITYCOL>
</cfif>

<cfif len(VARIATION)>
<cfquery name="isHvVariation" datasource="#dsn1#">
    SELECT * FROM PRODUCT_PROPERTY_DETAIL WHERE PROPERTY_DETAIL='#VARIATION#' AND PRPT_ID=#PROPERTY_ID#
</cfquery>
<cfif isHvVariation.recordCount>
    <CFSET PROPERTY_DETAIL_ID=isHvVariation.PROPERTY_DETAIL_ID>
<cfelse>
    <cfquery name="ins" datasource="#dsn1#" result="PROPERTY_DETAIL_INSERT_RESULT">
        INSERT INTO PRODUCT_PROPERTY_DETAIL (PRPT_ID,PROPERTY_DETAIL,IS_ACTIVE) VALUES (#PROPERTY_ID#,'#VARIATION#',1)
    </cfquery>
    <CFSET PROPERTY_DETAIL_ID=PROPERTY_DETAIL_INSERT_RESULT.IDENTITYCOL>
</cfif>

<CFSET VARIATION_ID_LIST=listAppend(VARIATION_ID_LIST,PROPERTY_DETAIL_ID)>

</cfif>


</cfloop>
<cfquery name="is_hv_product_cat" datasource="#dsn1#">
    SELECT * FROM CatalystQA_product.PRODUCT_CAT WHERE HIERARCHY='#COL_3#'
</cfquery>
<cfif is_hv_product_cat.recordCount>
    <CFSET PRODUCT_CATID=is_hv_product_cat.PRODUCT_CATID>
    <cfquery name="getProd" datasource="#dsn#">
        SELECT *
        FROM (
            SELECT PRODUCT_NAME, P.MANUFACT_CODE, PRODUCT_CODE, PRODUCT_CODE_2,P.PRODUCT_ID,S.STOCK_ID, PU.MAIN_UNIT,P.TAX, (
                    SELECT CONVERT(VARCHAR,PP.PROPERTY )+'-' + CONVERT(VARCHAR, PROPERTY_DETAIL_ID) + ','
                    FROM CatalystQA_product.PRODUCT_DT_PROPERTIES
                    INNER JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PPD ON PPD.PROPERTY_DETAIL_ID=PRODUCT_DT_PROPERTIES.VARIATION_ID
                    INNER JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PPD.PRPT_ID
                    WHERE PRODUCT_ID = P.PRODUCT_ID
                    FOR XML PATH('')
                    ) AS DTP,
                    (
                        SELECT COUNT(*) FROM CatalystQA_product.PRODUCT_DT_PROPERTIES AS PDP
LEFT JOIN CatalystQA_product.PRODUCT_CAT_PROPERTY AS PP ON PDP.PROPERTY_ID=PP.PROPERTY_ID AND PP.PRODUCT_CAT_ID=#PRODUCT_CATID#
WHERE PDP.PRODUCT_ID=P.PRODUCT_ID AND PP.PROPERTY_ID IS NULL


                    ) AS EXTRA_PROPT
            FROM CatalystQA_product.PRODUCT AS P
            LEFT JOIN CatalystQA_product.STOCKS AS S ON S.PRODUCT_ID=P.PRODUCT_ID
            LEFT JOIN CatalystQA_product.PRODUCT_UNIT AS PU
                ON PU.PRODUCT_ID = P.PRODUCT_ID AND PU.IS_MAIN = 1
            WHERE PRODUCT_CATID = #PRODUCT_CATID#
            ) AS TT
        WHERE 1 = 1 AND MANUFACT_CODE = '#COL_4#' 
        <cfloop list="#VARIATION_ID_LIST#" item="it">                
            AND DTP LIKE '%#it#,%'                    
        </cfloop>
    </cfquery>
    >
<cfif getProd.recordCount>
  
<cfelse>
    <cfset barcode=getBarcode()>
    <cfset UrunAdi=COL_1>
    <cfscript>
        kategori_id=PRODUCT_CATID;   
        urun_adi=UrunAdi; 
        detail='#COL_6#'; 
        detail_2='';
        satis_kdv=0;
        ALIS_KDV=0;
        is_inventory=1;
        is_production=0;
        is_sales=1;
        is_purchase=1;
        is_internet=0;
        is_extranet=0;
        birim = COL_2;
        dimention = "";
        volume = "";
        weight = "";
        surec_id=29;
        fiyat_yetkisi = 1;
        uretici_urun_kodu="#COL_4#";
        brand_id="";
        short_code = '';
        short_code_id = '';
        product_code_2='';
        is_limited_stock="";
        min_margin="";
        max_margin="";
        shelf_life="";
        segment_id="";
        bsmv="";
        oiv="";
        IS_ZERO_STOCK=0;
        IS_QUALITY=0;
        alis_fiyat_kdvsiz = 0
        satis_fiyat_kdvli = 0
        alis_fiyat_kdvli = 0
        sales_money = "TL"
        cesit_adi='';
        purchase_money = "TL"
    </cfscript>
    <cfset attributes.HIERARCHY =is_hv_product_cat.HIERARCHY>
    <cfinclude template="../query/add_import_product.cfm">
</cfif>



</cfif>
</div>
</cfif>
</cfloop>


</cfif>

<cffunction name="getBarcode">
      
    <cfif  1 eq 1>
        <cfquery name="get_barcode_no" datasource="#dsn1#">
            SELECT PRODUCT_NO AS BARCODE FROM PRODUCT_NO
        </cfquery>
        <cfset barcode_on_taki = '100000000000'>
        <cfset barcode = get_barcode_no.barcode>
        <cfset barcode_len = len(barcode)>
        <cfset barcode = left(barcode_on_taki,12-barcode_len)&barcode> 
    <cfelse>
        <cfquery name="get_barcode_no" datasource="#dsn1#">
            SELECT LEFT(BARCODE, 12) AS BARCODE FROM PRODUCT_NO
        </cfquery>
        <cfset barcode = (get_barcode_no.barcode*1)+1>
        <cfquery name="upd_barcode_no" datasource="#dsn1#">
            UPDATE PRODUCT_NO SET BARCODE = '#barcode#X'
        </cfquery>
    </cfif>

        <cfset barcode_tek = 0>
        <cfset barcode_cift =0>
        <cfif len(barcode) eq 12>
            <cfloop from="1" to="11" step="2" index="i">
                <cfset barcode_kontrol_1 = mid(barcode,i,1)>
                <cfset barcode_kontrol_2 = mid(barcode,i+1,1)>
                <cfset barcode_tek = (barcode_tek*1) + (barcode_kontrol_1*1)>
                <cfset barcode_cift = (barcode_cift*1) + (barcode_kontrol_2*1)>
            </cfloop>
            <cfset barcode_toplam = (barcode_cift*3)+(barcode_tek*1)>
            <cfset barcode_control_char = right(barcode_toplam,1)*1>
            <cfif barcode_control_char gt 0>
            <cfset barcode_control_char = 10-barcode_control_char>
        <cfelse>
            <cfset barcode_control_char = 0>
        </cfif>
        <cfset barcode_no = '#barcode##barcode_control_char#'>
    <cfelse>
        <cfset barcode_no = ''>
    </cfif>
    

</cffunction>


<script>    
    $('#file_11').change(function(e){
            var fileName = e. target. files[0]. name;
            $("#FileName").val(fileName)
        });
    </script>