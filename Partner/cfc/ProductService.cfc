<cfcomponent>
    <cfset dsn = application.systemParam.systemParam().dsn>
    <cfset DSN1 = "#DSN#_product">
    <cfset DSN2 = "#DSN#_#year(now())#_1">
    <cfset DSN3 = "#DSN#_1">
    <cffunction name="getCats" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="getAll" datasource="#dsn#">
            SELECT PRODUCT_CATID,PRODUCT_CAT FROM CatalystQA_product.PRODUCT_CAT ORDER BY PRODUCT_CAT
        </cfquery>
        <cfset ReturnArr=arrayNew(1)>
        <cfloop query="getAll">
            <cfscript>
                item={
                    PRODUCT_CATID=PRODUCT_CATID,
                    PRODUCT_CAT=PRODUCT_CAT
                };
                arrayAppend(ReturnArr,item);
            </cfscript>
        </cfloop>
        <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>
    <cffunction name="getCatProperties" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="PRODUCT_CATID">
        <cfquery name="getAll" datasource="#dsn#">
            select PP.PROPERTY,PP.PROPERTY_ID,PCP.IS_AMOUNT,PCP.IS_OPTIONAL from CatalystQA_product.PRODUCT_CAT_PROPERTY AS PCP
            LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY as PP ON PCP.PROPERTY_ID=PP.PROPERTY_ID
                where PRODUCT_CAT_ID=#arguments.PRODUCT_CATID# ORDER BY LINE_VALUE
        </cfquery>
             <cfset ReturnArr=arrayNew(1)>
             <cfloop query="getAll">
                 <cfscript>
                     item={
                        PROPERTY=PROPERTY,
                        PROPERTY_ID=PROPERTY_ID,
                        IS_AMOUNT=IS_AMOUNT,
                        IS_OPTIONAL=IS_OPTIONAL
                     };
                     arrayAppend(ReturnArr,item);
                 </cfscript>
             </cfloop>
             <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>
    <cffunction name="getPropDetails">
        <cfargument name="PROPERTY_ID">
        <cfquery name="getAll" datasource="#dsn#">
                SELECT PP1.PROPERTY_DETAIL,PP1.PROPERTY_DETAIL_ID,T.PRPT FROM CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PP1 
CROSS APPLY (
  SELECT DISTINCT(PRPT_ID) AS PRPT FROM   CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PP2 WHERE PP2.RELATED_VARIATION_ID=PP1.PROPERTY_DETAIL_ID ) AS T
WHERE PP1.PRPT_ID=#arguments.PROPERTY_ID# 
        ORDER BY PROPERTY_DETAIL
        </cfquery>
               <cfset ReturnArr=arrayNew(1)>
               <cfloop query="getAll">
                   <cfscript>
                       item={
                        PROPERTY_DETAIL=PROPERTY_DETAIL,
                          PROPERTY_DETAIL_ID=PROPERTY_DETAIL_ID,
                          IS_SUB_PRPT=PRPT
                       };
                       arrayAppend(ReturnArr,item);
                   </cfscript>
               </cfloop>
               <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction> 
    <cffunction name="getPropertyDetailsWithCatId"  access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="PROPERTY_ID">
        <cfargument name="PRODUCT_CATID">
        <cfargument name="RELATED_VAR_ID" default="">
        <cfargument name="RELATED_PROP_ID" default="">
        <CFIF LEN(arguments.RELATED_VAR_ID)>
            <cfquery name="GETrELPRPR" datasource="#DSN#">
                SELECT RELATED_VARIATION_ID FROM CatalystQA_product.PRODUCT_PROPERTY_DETAIL WHERE PROPERTY_DETAIL_ID=#arguments.RELATED_VAR_ID#
            </cfquery>
        </CFIF>
        <cfquery name="getAll" datasource="#dsn#">
          SELECT * FROM (
            SELECT DISTINCT PPD.PROPERTY_DETAIL
            ,PPD.PROPERTY_DETAIL_ID
            ,T.PRPT
            ,PP.PROPERTY
            ,PP.PROPERTY_ID
            ,RELATED_VARIATION_ID
            ,ISNULL(PCP.IS_AMOUNT,0) IS_AMOUNT
            FROM  CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PPD
            INNER JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP
            ON PP.PROPERTY_ID = PPD.PRPT_ID
            LEFT JOIN CatalystQA_product.PRODUCT_CAT_PROPERTY AS PCP ON PCP.PROPERTY_ID=PP.PROPERTY_ID AND PCP.PRODUCT_CAT_ID=#arguments.PRODUCT_CATID#
            OUTER APPLY (
                SELECT DISTINCT (PRPT_ID) AS PRPT
                FROM CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PP2
                WHERE PP2.RELATED_VARIATION_ID LIKE '%'+CONVERT(VARCHAR,PPD.PROPERTY_DETAIL_ID)+'%'
            ) AS T WHERE 1=1        
            <cfif len(arguments.RELATED_PROP_ID)> 
            AND PPD.PRPT_ID IN (#arguments.RELATED_PROP_ID#) <cfelse> AND PPD.PRPT_ID = #arguments.PROPERTY_ID# </cfif> <cfif len(arguments.RELATED_VAR_ID) > 
            AND  PPD.PROPERTY_DETAIL_ID IN(
            <cfloop list="#GETrELPRPR.RELATED_VARIATION_ID#" item="it">
            #it#,
            </cfloop>
            0
            )
            </cfif>) as ttt
            WHERE PROPERTY_DETAIL_ID IN (
                select VARIATION_ID from CatalystQA_product.PRODUCT_CAT_VARIATIONS WHERE PRODUCT_CATID=#arguments.PRODUCT_CATID#
            )
            ORDER BY PROPERTY_DETAIL
        </cfquery>
        <cfif getAll.recordCount eq 0>
            <cfquery name="getAll" datasource="#dsn#">
             SELECT * FROM (
                SELECT DISTINCT PPD.PROPERTY_DETAIL
                ,PPD.PROPERTY_DETAIL_ID
                ,T.PRPT
                ,PP.PROPERTY
                ,PP.PROPERTY_ID
                ,RELATED_VARIATION_ID
                FROM  CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PPD
                INNER JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP
                ON PP.PROPERTY_ID = PPD.PRPT_ID
                OUTER APPLY (
                    SELECT DISTINCT (PRPT_ID) AS PRPT
                    FROM CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PP2
                    WHERE PP2.RELATED_VARIATION_ID LIKE '%'+CONVERT(VARCHAR,PPD.PROPERTY_DETAIL_ID)+'%'
                ) AS T WHERE 1=1        
                <cfif len(arguments.RELATED_PROP_ID)> 
                AND PPD.PRPT_ID IN (#arguments.RELATED_PROP_ID#) <cfelse> AND PPD.PRPT_ID = #arguments.PROPERTY_ID# </cfif>
             ) as ttt
             WHERE PROPERTY_DETAIL_ID IN (
                select VARIATION_ID from CatalystQA_product.PRODUCT_CAT_VARIATIONS WHERE PRODUCT_CATID=#arguments.PRODUCT_CATID#
            )
                    ORDER BY PROPERTY_DETAIL

                </cfquery>
        
        </cfif>
        

        <cfset Listem="">
        <cfset ReturnArr=arrayNew(1)>
        <cfloop query="getAll">
        <cfset LISTEX=RELATED_VARIATION_ID>
        <cfset LISTEX=listRemoveDuplicates(LISTEX)>
        <CFSET RLPRP="">
        <CFIF LISTLEN(LISTEX) GT 0>
        <cfquery name="GETPRPT" datasource="#DSN#">
        SELECT DISTINCT PRPT_ID FROM CatalystQA_product.PRODUCT_PROPERTY_DETAIL WHERE PROPERTY_DETAIL_ID IN (#LISTEX#)
        </cfquery>
        <CFSET RLPRP=valueList(GETPRPT.PRPT_ID)>
        </CFIF>

        <cfscript>
        item={
        PROPERTY_DETAIL=PROPERTY_DETAIL,
        PROPERTY_DETAIL_ID=PROPERTY_DETAIL_ID,
        IS_SUB_PRPT=RLPRP,
        PROPERTY=PROPERTY,
        PROPERTY_ID=PROPERTY_ID,
        RELATED_VARIATION_ID=RELATED_VARIATION_ID,
        IS_AMOUNT=IS_AMOUNT

        };
        arrayAppend(ReturnArr,item);
        </cfscript>
        <cfset Listem=listAppend(Listem,RELATED_VARIATION_ID)>
        </cfloop>

        <cfset Listem=listRemoveDuplicates(Listem)>

        <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>
    <cffunction name="getWesselProducts" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="WesselId">
        <cfquery name="getProd" datasource="#dsn#">
            select S.PRODUCT_ID,S.STOCK_ID,S.MANUFACT_CODE,S.PRODUCT_NAME,S.PRODUCT_CATID,PC.PRODUCT_CAT,POR.PROP_LIST,POR.JSON_STRINGIM,PU.MAIN_UNIT,S.PRODUCT_CODE,S.TAX,S.PRODUCT_CODE_2 from CatalystQA_1.PBS_OFFER_ROW AS POR 
        INNER JOIN CatalystQA_1.PBS_OFFER AS PO ON POR.OFFER_ID=PO.OFFER_ID
        INNER JOIN CatalystQA_1.STOCKS AS S ON S.STOCK_ID=POR.STOCK_ID
        LEFT JOIN CatalystQA_product.PRODUCT_CAT AS PC ON PC.PRODUCT_CATID=S.PRODUCT_CATID
        INNER JOIN CatalystQA_product.PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=S.PRODUCT_ID AND PU.IS_MAIN=1
        WHERE PO.WESSEL_ID=#arguments.WesselId#
        </cfquery>
        <cfset ReturnArr=arrayNew(1)>
        <cfloop query="getProd" group="PRODUCT_CATID">
            <CFSET PA=structNew()>
            <CFSET PA.PRODUCT_CAT=PRODUCT_CAT>
            <CFSET PA.PRODUCT_ARR=arrayNew(1)>
            <cfloop>
        <cfset P=structNew()>
            <cfset P.MANUFACT_CODE=getProd.MANUFACT_CODE>
        <cfset P.PRODUCT_ID=getProd.PRODUCT_ID>
        <cfset P.STOCK_ID=getProd.STOCK_ID>
        <cfset P.PRODUCT_NAME=getProd.PRODUCT_NAME>
        <cfset P.PRODUCT_CODE=getProd.PRODUCT_CODE>
        <CFSET P.TAX=getProd.TAX>
        <cfset P.PRODUCT_CODE_2=getProd.PRODUCT_CODE_2>
        <cfset P.MAIN_UNIT=getProd.MAIN_UNIT>
        <cfset P.RECORD_COUNT=getProd.recordcount>
        <cfset P.PROP_LIST=getProd.PROP_LIST>
        <cfset P.JSON_STRINGIM=getProd.JSON_STRINGIM>
        <cfscript>
            arrayAppend(PA.PRODUCT_ARR,P);
        </cfscript>
    </cfloop>
    <cfscript>
        arrayAppend(ReturnArr,PA);
    </cfscript>
        </cfloop>
        <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>

    <cffunction name="SearchProduct" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="FormData">
        <cfset FData=deserializeJSON(arguments.FormData)>
        <cfquery name="getpcs" datasource="#dsn#_1">
            SELECT *,(SELECT COUNT(*) FROM CatalystQA_product.PRODUCT_IMAGES WHERE PRODUCT_ID=P.PRODUCT_ID) AS IMG_COUNT FROM STOCKS as P
            LEFT JOIN CatalystQA_product.PRODUCT_UNIT AS PU
                    ON PU.PRODUCT_ID = P.PRODUCT_ID AND PU.IS_MAIN = 1
            WHERE MANUFACT_CODE ='#FData.keyword#' AND PRODUCT_CATID=83
        </cfquery>
        <CFIF getpcs.recordCount>
            <CFSET P=structNew()>
            <cfset P.MANUFACT_CODE=getpcs.MANUFACT_CODE>
            <cfset P.PRODUCT_ID=getpcs.PRODUCT_ID>
            <cfset P.STOCK_ID=getpcs.STOCK_ID>
            <cfset P.PRODUCT_NAME=getpcs.PRODUCT_NAME>
            <cfset P.IS_VIRTUAL=0>
            <cfset P.PRODUCT_CODE=getpcs.PRODUCT_CODE>
            <CFSET P.TAX=getpcs.TAX>
            <cfset P.PRODUCT_CODE_2=getpcs.PRODUCT_CODE_2>
            <cfset P.MAIN_UNIT=getpcs.MAIN_UNIT>
            <CFSET P.EXTRA_PROPT=0>
            <CFSET P.IMG_COUNT=getpcs.IMG_COUNT>
            <cfset P.RECORD_COUNT=getpcs.recordcount>
            <cfreturn replace(serializeJSON(P),"//","")>
    
        </cfif>
      
      
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
LEFT JOIN CatalystQA_product.PRODUCT_CAT_PROPERTY AS PP ON PDP.PROPERTY_ID=PP.PROPERTY_ID AND PP.PRODUCT_CAT_ID=#FData.SearchMainValue.PRODUCT_CAT_ID#
WHERE PDP.PRODUCT_ID=P.PRODUCT_ID AND PP.PROPERTY_ID IS NULL


                        ) AS EXTRA_PROPT
                        ,(SELECT COUNT(*) FROM CatalystQA_product.PRODUCT_IMAGES WHERE PRODUCT_ID=P.PRODUCT_ID) AS IMG_COUNT
                FROM CatalystQA_product.PRODUCT AS P
                LEFT JOIN CatalystQA_product.STOCKS AS S ON S.PRODUCT_ID=P.PRODUCT_ID
                LEFT JOIN CatalystQA_product.PRODUCT_UNIT AS PU
                    ON PU.PRODUCT_ID = P.PRODUCT_ID AND PU.IS_MAIN = 1
                WHERE PRODUCT_CATID = #FData.SearchMainValue.PRODUCT_CAT_ID#
                ) AS TT
            WHERE 1 = 1  AND MANUFACT_CODE = '#FData.keyword#' 
            <cfloop array="#FData.SearchMainValue.Filters#" item="it">
            <cfif it.PNAME.trim() neq "EQUIPMENT"> 
                <cfif isDefined("it.IS_OPTIONAL") and it.IS_OPTIONAL eq 0>
                AND DTP LIKE '%<cfif isdefined("it.PRODUCT_CAT_ID")>#it.PRODUCT_CAT_ID#<cfelse>#it.PRODUCT_CATID#</cfif>,%'
            </cfif>
            
        </cfif>
            </cfloop>
        </cfquery>
        <cfsavecontent  variable="control5">
            <cfdump  var="#CGI#">                
            <cfdump  var="#getProd#">
            <cfdump  var="#FData#">    
        </cfsavecontent>
        <cffile action="write" file = "c:\SearchProduct.html" output="#control5#"></cffile>
        <CFSET P=structNew()>
        <cfset P.MANUFACT_CODE=getProd.MANUFACT_CODE>
        <cfset P.PRODUCT_ID=getProd.PRODUCT_ID>
        <cfset P.STOCK_ID=getProd.STOCK_ID>
        <cfset P.PRODUCT_NAME=getProd.PRODUCT_NAME>
        <cfset P.IS_VIRTUAL=0>
        <cfset P.PRODUCT_CODE=getProd.PRODUCT_CODE>
        <CFSET P.TAX=getProd.TAX>
        <cfset P.PRODUCT_CODE_2=getProd.PRODUCT_CODE_2>
        <cfset P.MAIN_UNIT=getProd.MAIN_UNIT>
        <CFSET P.EXTRA_PROPT=getProd.EXTRA_PROPT>
        <cfset P.RECORD_COUNT=getProd.recordcount>
        <CFSET P.IMG_COUNT=getProd.IMG_COUNT>
        <cfreturn replace(serializeJSON(P),"//","")>
    </cffunction>
    <cffunction name="SearchProductPopup" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="FormData">
        <cfset FData=deserializeJSON(arguments.FormData)>
        
        
        <cfquery name="getProd" datasource="#dsn#">
            SELECT *
            FROM (
                SELECT PRODUCT_NAME, P.MANUFACT_CODE, PRODUCT_CODE, PRODUCT_CODE_2,P.PRODUCT_ID,S.STOCK_ID,P.PRODUCT_CATID, PU.MAIN_UNIT,P.TAX, (
                        SELECT CONVERT(VARCHAR,PP.PROPERTY )+'-' + CONVERT(VARCHAR, PROPERTY_DETAIL_ID) + ','
                        FROM CatalystQA_product.PRODUCT_DT_PROPERTIES
                        INNER JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PPD ON PPD.PROPERTY_DETAIL_ID=PRODUCT_DT_PROPERTIES.VARIATION_ID
                        INNER JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PPD.PRPT_ID
                        WHERE PRODUCT_ID = P.PRODUCT_ID
                        FOR XML PATH('')
                        ) AS DTP,(
                            select DISTINCT PROPERTY,PP.PROPERTY_ID,PROPERTY_DETAIL,ISNULL(PCP.IS_AMOUNT,PDP.IS_EXIT) AS IS_AMOUNT from CatalystQA_product.PRODUCT_DT_PROPERTIES AS PDP
 LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL PPD ON PPD.PROPERTY_DETAIL_ID=PDP.VARIATION_ID
 LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PPD.PRPT_ID
 LEFT JOIN CatalystQA_product.PRODUCT_CAT_PROPERTY AS PCP ON PCP.PRODUCT_CAT_ID=P.PRODUCT_CATID AND PCP.PROPERTY_ID=PP.PROPERTY_ID
  WHERE PDP.PRODUCT_ID=P.PRODUCT_ID AND PDP.VARIATION_ID IS NOT NULL
                         
                        FOR JSON PATH 
                        ) AS DTP2
                FROM CatalystQA_product.PRODUCT AS P
                LEFT JOIN CatalystQA_product.STOCKS AS S ON S.PRODUCT_ID=P.PRODUCT_ID
                LEFT JOIN CatalystQA_product.PRODUCT_UNIT AS PU
                    ON PU.PRODUCT_ID = P.PRODUCT_ID AND PU.IS_MAIN = 1
                WHERE PRODUCT_CATID = #FData.SearchMainValue.PRODUCT_CAT_ID#
                ) AS TT
            WHERE 1 = 1 <cfif isDefined("FData.keyword") and len(FData.keyword)>
                 AND (
                    MANUFACT_CODE LIKE '%#FData.keyword#%' OR
                    PRODUCT_NAME LIKE '%#FData.keyword#%' 
                    )
                </cfif>
            <cfloop array="#FData.SearchMainValue.Filters#" item="it">
            <cfif it.PNAME.trim() neq "EQUIPMENT"> 
                <cfif isDefined("it.IS_OPTIONAL") and it.IS_OPTIONAL eq 0>
            AND DTP LIKE '%#it.PRODUCT_CAT_ID#,%'</cfif>
            </cfif>
            </cfloop>
        </cfquery>
        <cfset PID_LIST=valueList(getProd.PRODUCT_ID)>

        <cfsavecontent  variable="control5">
            <cfdump  var="#CGI#">                
            <cfdump  var="#getProd#">
            <cfdump  var="#FData#">    
        </cfsavecontent>
        <CFSET PID_LIST=listAppend(PID_LIST,"0")>
        <cffile action="write" file = "c:\SearchProduct.html" output="#control5#"></cffile>
        <cfquery name="getOtherProperties" datasource="#dsn#">
            SELECT DISTINCT PDP.PROPERTY_ID,PROPERTY,(SELECT PROPERTY_DETAIL_ID,PROPERTY_DETAIL FROM CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PPD WHERE PPD.PRPT_ID=PDP.PROPERTY_ID FOR JSON PATH) as TKFS FROM CatalystQA_product.PRODUCT_DT_PROPERTIES AS PDP
INNER JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PDP.PROPERTY_ID
 WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM CatalystQA_product.PRODUCT WHERE PRODUCT_CATID=#FData.SearchMainValue.PRODUCT_CAT_ID#)
AND PDP.PROPERTY_ID NOT IN (SELECT PROPERTY_ID FROM CatalystQA_product.PRODUCT_CAT_PROPERTY WHERE PRODUCT_CAT_ID=#FData.SearchMainValue.PRODUCT_CAT_ID#)
        </cfquery> 
        <CFSET ReturnData=structNew()>
        <cfset PSA=arrayNew(1)>
        <cfloop query="getOtherProperties">
            <cfset PP=structNew()>
            <cfset PP.PROPERTY=PROPERTY>
            <cfset PP.PROPERTY_ID=PROPERTY_ID>
            <cfset PP.VARIATIONS=deserializeJSON(TKFS)>
            <cfscript>
                arrayAppend(PSA,PP);
            </cfscript>
        </cfloop>
        <cfset ReturnData.OTHER_PROPERTIES=PSA>
        <cfset ReturnData.PRODUCT_COUNT=getProd.recordcount>
        <CFSET PRODUCTS=arrayNew(1)>
        <cfloop query="getProd">
        <CFSET P=structNew()>
        <cfset P.MANUFACT_CODE=getProd.MANUFACT_CODE>
        <cfset P.PRODUCT_ID=getProd.PRODUCT_ID>
        <cfset P.STOCK_ID=getProd.STOCK_ID>
        <cfset P.PRODUCT_NAME=getProd.PRODUCT_NAME>
        <cfset P.PRODUCT_CODE=getProd.PRODUCT_CODE>
        <CFSET P.TAX=getProd.TAX>
        <CFSET P.PRODUCT_CATID=PRODUCT_CATID>
        <cfset P.DTP=DTP2>
        <cfset P.PRODUCT_CODE_2=getProd.PRODUCT_CODE_2>
        <cfset P.MAIN_UNIT=getProd.MAIN_UNIT>
        
        <cfscript>
            arrayAppend(PRODUCTS,P);
        </cfscript>        
    </cfloop>
    <CFSET ReturnData.PRODUCTS=PRODUCTS>
        <cfreturn replace(serializeJSON(ReturnData),"//","")>
    </cffunction>
    <cffunction name="getCatalogs" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="CatalogId" default="">
            <cfquery name="getCatalog" datasource="#dsn#">
                select PCP.*,PS.SHIP_NAME,PM.MACHINE_NAME,PC.PRODUCT_CAT,PC.PRODUCT_CATID,SEQ.JSON_STRINGIM from CatalystQA_product.PRODUCT_CATALOG_PBS AS PCP
                LEFT JOIN CatalystQA.PBS_SHIPS AS PS ON PS.SHIP_ID=PCP.SHIP_ID
                LEFT JOIN  CatalystQA.PBS_SHIP_MACHINES AS PM ON PM.SM_ID=PCP.MACHINE_ID
                LEFT JOIN CatalystQA_product.PRODUCT_CAT AS PC ON PC.PRODUCT_CATID=PM.MACHINE_CAT
                LEFT JOIN CatalystQA_1.SHIP_EQUIPMENTS_PBS AS SEQ ON SEQ.SM_ID=PM.SM_ID
                WHERE 1=1 <CFIF LEN(arguments.CatalogId)>AND PCP.CATALOG_ID=#arguments.CatalogId#</CFIF>
            </cfquery>
            <cfset CatalogArr=arrayNew(1)>
            <cfloop query="getCatalog">
                <cfscript>
                    Catalog={
                    CATALOG_ID=CATALOG_ID,
                    CATALOG_NAME=CATALOG_NAME,
                    SHIP_NAME=SHIP_NAME,
                    SHIP_ID=SHIP_ID,
                    MACHINE_NAME=MACHINE_NAME,
                    MACHINE_ID=MACHINE_ID,
                    PRODUCT_CAT=PRODUCT_CAT,
                    PRODUCT_CATID=PRODUCT_CATID
                    
                };                
                if(isJSON(JSON_STRINGIM)){
                    Catalog.JSON_STRINGIM=deserializeJSON(JSON_STRINGIM)
                }else{
                    Catalog.JSON_STRINGIM={}
                }
                    arrayAppend(CatalogArr,Catalog);
                </cfscript>
            </cfloop>
            <cfreturn replace(serializeJSON(CatalogArr),"//","")>
    </cffunction>
    <cffunction name="CreateProduct"  access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="PRODUCT_NAME">
        <cfargument name="PRODUCT_CATID">
        <cfargument name="MANUFACT_CODE">
        <cfargument name="PROPS">
        <cfargument name="EXTRA_PROPS">
<cftry>
        <cfquery name="GETPCAT" datasource="#DSN#_product">
            SELECT * FROM PRODUCT_CAT WHERE PRODUCT_CATID=#arguments.PRODUCT_CATID#
        </cfquery>
        <cfset barcode=getBarcode()>
        <cfset UrunAdi=arguments.PRODUCT_NAME>
        <cfscript>
            kategori_id=arguments.PRODUCT_CATID;   
            urun_adi=UrunAdi; 
            detail=''; 
            detail_2='';
            satis_kdv=0;
            ALIS_KDV=0;
            is_inventory=1;
            is_production=0;
            is_sales=1;
            is_purchase=1;
            is_internet=0;
            is_extranet=0;
            birim = "Adet";
            dimention = "";
            volume = "";
            weight = "";
            surec_id=29;
            fiyat_yetkisi = 1;
            uretici_urun_kodu="#arguments.MANUFACT_CODE#";
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
        <cfset attributes.HIERARCHY =GETPCAT.HIERARCHY>
        <cfinclude template="../../Horizon/objects/query/add_import_product.cfm">

        


        <cfset RECORDED_PRODUCT_ID=GET_PID.PRODUCT_ID>
        <cfset RECORDED_STOCK_ID=get_max_stck.max_stck>
        <cfset PropArr=deserializeJSON(arguments.PROPS)>
        <cfloop array="#PropArr#" item="it" index="ix">
           <cfif it.PNAME neq "EQUIPMENT">
            <cfquery name="GETPCDA" datasource="#DSN1#">
                SELECT ISNULL(IS_OPTIONAL,0) IS_OPTIONAL,ISNULL(IS_AMOUNT,0) IS_AMOUNT FROM CatalystQA_product.PRODUCT_CAT_PROPERTY WHERE PRODUCT_CAT_ID=#arguments.PRODUCT_CATID# AND PROPERTY_ID=#it.PROP_ID#
            </cfquery>
           <cfquery name="ins" datasource="#dsn1#">
                INSERT INTO PRODUCT_DT_PROPERTIES (PRODUCT_ID,PROPERTY_ID,VARIATION_ID,LINE_VALUE,IS_OPTIONAL,IS_EXIT)
                VALUES (
                    #RECORDED_PRODUCT_ID#,
                    #it.PROP_ID#,
                    <cftry>#it.PRODUCT_CATID#<cfcatch>#it.PRODUCT_CAT_ID#</cfcatch></cftry>,
                    #ix#,
                    <cfif len(GETPCDA.IS_OPTIONAL)>#GETPCDA.IS_OPTIONAL#<cfelse>0</cfif>,
                    <cfif len(GETPCDA.IS_AMOUNT)>#GETPCDA.IS_AMOUNT#<cfelse>0</cfif>
                ) 
            </cfquery>
            </cfif>
        </cfloop>
        <cfset ExtraPropArr=deserializeJSON(arguments.EXTRA_PROPS)>
        <cfloop array="#ExtraPropArr#" item="it2" index="ixx">
           
           
           <cfquery name="ins" datasource="#dsn1#">
                INSERT INTO PRODUCT_DT_PROPERTIES (PRODUCT_ID,PROPERTY_ID,VARIATION_ID,LINE_VALUE,IS_OPTIONAL,IS_EXIT)
                VALUES (
                    #RECORDED_PRODUCT_ID#,
                    #it2.PROPERTY_ID#,
                    #it2.VARIATION_ID#,
                    #ixx#,
                    0,
                    0
                ) 
            </cfquery>
           
        </cfloop>

        <cfset ReturnData.STATUS=1>
        <cfset ReturnData.MESSAGE="Ürün Oluşturuldu">
        <cfset ReturnData.ErrorMessage="">
        <cfset ReturnData.PRODUCT_ID=RECORDED_PRODUCT_ID>
        <cfset ReturnData.STOCK_ID=RECORDED_STOCK_ID>
        <cfreturn replace(serializeJSON(ReturnData),"//","")>
        <cfcatch>
         
        <cfsavecontent  variable="control5">
            <cfdump  var="#arguments#">                
            <cfdump  var="#cfcatch#">
            
        </cfsavecontent>
        
        <cffile action="write" file = "c:\CreateProduct.html" output="#control5#"></cffile>   
    <cfset ReturnData.STATUS=0>
    <cfset ReturnData.MESSAGE="Ürün Oluşturulurken Bir Hata Oluştu">
    <cfset ReturnData.ErrorMessage=cfcatch.message>
    <cfset ReturnData.PRODUCT_ID="">
    <cfset ReturnData.STOCK_ID="">
    <cfreturn replace(serializeJSON(ReturnData),"//","")>
</cfcatch>
    </cftry>
    </cffunction>

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

</cfcomponent>