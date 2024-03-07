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
        <cfquery name="getAll" datasource="#dsn#">
            SELECT DISTINCT PPD.PROPERTY_DETAIL,PPD.PROPERTY_DETAIL_ID,T.PRPT,PP.PROPERTY FROM CatalystQA_product.PRODUCT_DT_PROPERTIES  PDP
INNER JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PPD ON PPD.PROPERTY_DETAIL_ID=PDP.VARIATION_ID
INNER JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PPD.PROPERTY_ID
OUTER APPLY (
  SELECT DISTINCT(PRPT_ID) AS PRPT FROM   CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PP2 WHERE PP2.RELATED_VARIATION_ID=PPD.PROPERTY_DETAIL_ID ) AS T
WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM CatalystQA_product.PRODUCT WHERE PRODUCT_CATID=#arguments.PRODUCT_CATID#) <cfif len(arguments.RELATED_PROP_ID)>AND PPD.PRPT_ID=#arguments.RELATED_PROP_ID#<cfelse> AND PPD.PRPT_ID=#arguments.PROPERTY_ID#</cfif>
<cfif len(arguments.RELATED_VAR_ID)> AND PPD.RELATED_VARIATION_ID=#arguments.RELATED_VAR_ID# </cfif>
        </cfquery>
          <cfset ReturnArr=arrayNew(1)>
          <cfloop query="getAll">
              <cfscript>
                  item={
                   PROPERTY_DETAIL=PROPERTY_DETAIL,
                     PROPERTY_DETAIL_ID=PROPERTY_DETAIL_ID,
                     IS_SUB_PRPT=PRPT,
                     PROPERTY_ID=PROPERTY_ID

                  };
                  arrayAppend(ReturnArr,item);
              </cfscript>
          </cfloop>
          <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>

    <cffunction name="SearchProduct" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="FormData">

<cfset FData=deserializeJSON(arguments.FormData)>

<cfquery name="getSearchParams" datasource="#dsn#">
    select PP.PROPERTY+'-'+CONVERT(VARCHAR,PPD.PROPERTY_DETAIL_ID) as SEARCH_PARAM from CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PPD
INNER JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PPD.PRPT_ID

  WHERE 1=1
  <cfif arrayLen(FData.SearchMainValue.Filters) gt 1>
  AND  PROPERTY_DETAIL_ID IN (
        <cfloop array="#FData.SearchMainValue.Filters#" item="it"><cfif it.PNAME neq "EQUIPMENT"></cfif>
        #it.PRODUCT_CAT_ID#,
        </cfloop>0
)
</cfif>

</cfquery>




<cfquery name="getProd" datasource="#dsn#">
 SELECT *
FROM (
	SELECT PRODUCT_NAME, MANUFACT_CODE, PRODUCT_CODE, PRODUCT_CODE_2, PU.MAIN_UNIT, (
			SELECT CONVERT(VARCHAR,PP.PROPERTY )+'-' + CONVERT(VARCHAR, PROPERTY_DETAIL_ID) + ','
			FROM CatalystQA_product.PRODUCT_DT_PROPERTIES
            INNER JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PPD ON PPD.PROPERTY_DETAIL_ID=PRODUCT_DT_PROPERTIES.VARIATION_ID
			INNER JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PPD.PRPT_ID
			WHERE PRODUCT_ID = P.PRODUCT_ID
			FOR XML PATH('')
			) AS DTP
	FROM CatalystQA_product.PRODUCT AS P
	LEFT JOIN CatalystQA_product.PRODUCT_UNIT AS PU
		ON PU.PRODUCT_ID = P.PRODUCT_ID AND PU.IS_MAIN = 1
	WHERE PRODUCT_CATID = #FData.SearchMainValue.PRODUCT_CAT_ID#
	) AS TT
WHERE 1 = 1 AND MANUFACT_CODE = '#FData.keyword#' 
<cfloop query ="getSearchParams" > 
    
        AND DTP LIKE '%#SEARCH_PARAM#,%' 
    
</cfloop>

</cfquery>

<!-----
    	INNER JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PPD ON PPD.PROPERTY_DETAIL_ID=PRODUCT_DT_PROPERTIES.VARIATION_ID
			INNER JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PPD.PRPT_ID

            ----->
<CFSET P=structNew()>
<cfset P.MANUFACT_CODE=getProd.MANUFACT_CODE>
<cfset P.PRODUCT_NAME=getProd.PRODUCT_NAME>
<cfset P.PRODUCT_CODE=getProd.PRODUCT_CODE>
<cfset P.PRODUCT_CODE_2=getProd.PRODUCT_CODE_2>
<cfset P.MAIN_UNIT=getProd.MAIN_UNIT>
<cfset P.RECORD_COUNT=getProd.recordcount>
<cfreturn replace(serializeJSON(P),"//","")>
    </cffunction>
</cfcomponent>