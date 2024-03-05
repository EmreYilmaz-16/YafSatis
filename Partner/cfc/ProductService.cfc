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
            select PP.PROPERTY,PP.PROPERTY_ID from CatalystQA_product.PRODUCT_CAT_PROPERTY AS PCP
            LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY as PP ON PCP.PROPERTY_ID=PP.PROPERTY_ID
                where PRODUCT_CAT_ID=#arguments.PRODUCT_CATID#
        </cfquery>
             <cfset ReturnArr=arrayNew(1)>
             <cfloop query="getAll">
                 <cfscript>
                     item={
                        PROPERTY=PROPERTY,
                        PROPERTY_ID=PROPERTY_ID
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
    <cffunction name="getPropertyDetailsWithCatId">
        <cfargument name="PROPERTY_ID">
        <cfargument name="PRODUCT_CATID">
        <cfquery name="getAll" datasource="#dsn#">
            SELECT DISTINCT PPD.PROPERTY_DETAIL,PPD.PROPERTY_DETAIL_ID,T.PRPT FROM CatalystQA_product.PRODUCT_DT_PROPERTIES  PDP
INNER JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PPD ON PPD.PROPERTY_DETAIL_ID=PDP.VARIATION_ID
OUTER APPLY (
  SELECT DISTINCT(PRPT_ID) AS PRPT FROM   CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PP2 WHERE PP2.RELATED_VARIATION_ID=PPD.PROPERTY_DETAIL_ID ) AS T
WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM CatalystQA_product.PRODUCT WHERE PRODUCT_CATID=#arguments.PRODUCT_CATID#) AND PPD.PRPT_ID=#arguments.PROPERTY_ID#
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

    <cffunction name="SearchProduct" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="FormData">
        <cfdump var="#arguments.FormData#">
<cfset FData=deserializeJSON(arguments.FormData)>
<cfdump var="#FData#">
    </cffunction>
</cfcomponent>