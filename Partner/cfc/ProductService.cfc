<cfcomponent>
    <cfset dsn = application.systemParam.systemParam().dsn>
    <cffunction name="getCats" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="getAll" datasource="#dsn#">
            SELECT PRODUCT_CATID,PRODUCT_CAT FROM CatalystQA_product.PRODUCT_CAT
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
            select PP.PROPERTY,PP.PROPERTY_ID,PCP.IS_AMOUNT from CatalystQA_product.PRODUCT_CAT_PROPERTY AS PCP
            LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY as PP ON PCP.PROPERTY_ID=PP.PROPERTY_ID
                where PRODUCT_CAT_ID=#arguments.PRODUCT_CATID# ORDER BY LINE_VALUE
        </cfquery>
             <cfset ReturnArr=arrayNew(1)>
             <cfloop query="getAll">
                 <cfscript>
                     item={
                        PROPERTY=PROPERTY,
                        PROPERTY_ID=PROPERTY_ID,
                        IS_AMOUNT:IS_AMOUNT
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
/*WHERE PRODUCT_ID IN (
		SELECT PRODUCT_ID
		FROM CatalystQA_product.PRODUCT
		WHERE PRODUCT_CATID = #arguments.PRODUCT_CATID#
		) */--AND PPD.PRPT_ID = 4
   <cfif len(arguments.RELATED_PROP_ID)> 
        AND PPD.PRPT_ID IN (#arguments.RELATED_PROP_ID#) <cfelse> AND PPD.PRPT_ID = #arguments.PROPERTY_ID# </cfif> <cfif len(arguments.RELATED_VAR_ID) > 
            AND  PPD.PROPERTY_DETAIL_ID IN(
                <cfloop list="#GETrELPRPR.RELATED_VARIATION_ID#" item="it">
                    #it#,
                </cfloop>
                0
            )
        /*AND PPD.RELATED_VARIATION_ID LIKE '%#arguments.RELATED_VAR_ID#%'*/ </cfif>
        </cfquery>
        <cfif getAll.recordCount eq 0>
            <cfquery name="getAll" datasource="#dsn#">
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
/*WHERE PRODUCT_ID IN (
		SELECT PRODUCT_ID
		FROM CatalystQA_product.PRODUCT
		WHERE PRODUCT_CATID = #arguments.PRODUCT_CATID#
		) --AND PPD.PRPT_ID = 4*/
   <cfif len(arguments.RELATED_PROP_ID)> 
        AND PPD.PRPT_ID IN (#arguments.RELATED_PROP_ID#) <cfelse> AND PPD.PRPT_ID = #arguments.PROPERTY_ID# </cfif>
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
                     RELATED_VARIATION_ID=RELATED_VARIATION_ID

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
            select S.PRODUCT_ID,S.STOCK_ID,S.MANUFACT_CODE,S.PRODUCT_NAME,POR.PROP_LIST,POR.JSON_STRINGIM,PU.MAIN_UNIT,S.PRODUCT_CODE,S.TAX,S.PRODUCT_CODE_2 from CatalystQA_1.PBS_OFFER_ROW AS POR 
        INNER JOIN CatalystQA_1.PBS_OFFER AS PO ON POR.OFFER_ID=PO.OFFER_ID
        INNER JOIN CatalystQA_1.STOCKS AS S ON S.STOCK_ID=POR.STOCK_ID
        INNER JOIN CatalystQA_product.PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=S.PRODUCT_ID AND PU.IS_MAIN=1
        WHERE PO.WESSEL_ID=#arguments.WesselId#
        </cfquery>
        <cfset ReturnArr=arrayNew(1)>
        <cfloop query="getProd">
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
            arrayAppend(ReturnArr,P);
        </cfscript>
        </cfloop>
        <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>

    <cffunction name="SearchProduct" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="FormData">
        <cfset FData=deserializeJSON(arguments.FormData)>
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
                        ) AS DTP
                FROM CatalystQA_product.PRODUCT AS P
                LEFT JOIN CatalystQA_product.STOCKS AS S ON S.PRODUCT_ID=P.PRODUCT_ID
                LEFT JOIN CatalystQA_product.PRODUCT_UNIT AS PU
                    ON PU.PRODUCT_ID = P.PRODUCT_ID AND PU.IS_MAIN = 1
                WHERE PRODUCT_CATID = #FData.SearchMainValue.PRODUCT_CAT_ID#
                ) AS TT
            WHERE 1 = 1 AND MANUFACT_CODE = '#FData.keyword#' 
            <cfloop array="#FData.SearchMainValue.Filters#" item="it">
            <cfif it.PNAME.trim() neq "EQUIPMENT"> AND DTP LIKE '%#it.PRODUCT_CAT_ID#,%'</cfif>
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
        <cfset P.RECORD_COUNT=getProd.recordcount>
        <cfreturn replace(serializeJSON(P),"//","")>
    </cffunction>
    <cffunction name="SearchProductPopup" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="FormData">
        <cfset FData=deserializeJSON(arguments.FormData)>
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
                        ) AS DTP,(
                        SELECT  '<button> <b>'+CONVERT(VARCHAR, PROPERTY) + '</b><br>'+PROPERTY_DETAIL+'</button>'
                        FROM CatalystQA_product.PRODUCT_DT_PROPERTIES
                        INNER JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PPD ON PPD.PROPERTY_DETAIL_ID=PRODUCT_DT_PROPERTIES.VARIATION_ID
                        INNER JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PPD.PRPT_ID
                        WHERE PRODUCT_ID = P.PRODUCT_ID
                        FOR XML PATH('')
                        ) AS DTP2
                FROM CatalystQA_product.PRODUCT AS P
                LEFT JOIN CatalystQA_product.STOCKS AS S ON S.PRODUCT_ID=P.PRODUCT_ID
                LEFT JOIN CatalystQA_product.PRODUCT_UNIT AS PU
                    ON PU.PRODUCT_ID = P.PRODUCT_ID AND PU.IS_MAIN = 1
                WHERE PRODUCT_CATID = #FData.SearchMainValue.PRODUCT_CAT_ID#
                ) AS TT
            WHERE 1 = 1 <cfif len(FData.keyword)>
                 AND (
                    MANUFACT_CODE LIKE '%#FData.keyword#%' OR
                    PRODUCT_NAME LIKE '%#FData.keyword#%' 
                    )
                </cfif>
            <cfloop array="#FData.SearchMainValue.Filters#" item="it">
            <cfif it.PNAME.trim() neq "EQUIPMENT"> AND DTP LIKE '%#it.PRODUCT_CAT_ID#,%'</cfif>
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
</cfcomponent>