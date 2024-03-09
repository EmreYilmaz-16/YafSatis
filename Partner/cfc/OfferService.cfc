<cfcomponent>
    <cfset dsn = application.systemParam.systemParam().dsn>
    <cffunction name="getOfferCurrencies" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="getAll" datasource="#dsn#">
            select OFFER_CURRENCY_ID,OFFER_CURRENCY  from CatalystQA_1.OFFER_CURRENCY
        </cfquery>
        <cfset ReturnArr=arrayNew(1)>
        <cfloop query="getAll">
            <cfscript>
                item={
                    OFFER_CURRENCY_ID=OFFER_CURRENCY_ID,
                    OFFER_CURRENCY=OFFER_CURRENCY
                };
                arrayAppend(ReturnArr,item);
            </cfscript>
        </cfloop>
        <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>
    <cffunction name="getOfferPriorities" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="getAll" datasource="#dsn#">
            select  PRIORITY_ID,PRIORITY from CatalystQA.SETUP_PRIORITY
        </cfquery>
        <cfset ReturnArr=arrayNew(1)>
        <cfloop query="getAll">
            <cfscript>
                item={
                    PRIORITY_ID=PRIORITY_ID,
                    PRIORITY=PRIORITY
                };
                arrayAppend(ReturnArr,item);
            </cfscript>
        </cfloop>
        <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>
    <cffunction name="getOfferMoney" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="getMoneyTypes" datasource="#dsn#">
            SELECT DISTINCT MONEY,RATE1,RATE2  FROM CatalystQA.SETUP_MONEY
        </cfquery>
        <cfset ReturnArr=arrayNew(1)>
        <cfloop query="getMoneyTypes">
            <cfscript>
                item={
                    MONEY=MONEY,
                    RATE1=RATE1,
                    RATE2=RATE2
                };
                arrayAppend(ReturnArr,item);
            </cfscript>
        </cfloop>
        <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>
    <cffunction name="getDeliveryPlaces" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="DeliveryPlaceId" default="">
        <cfquery name="getAll" datasource="#dsn#">
            SELECT DELIVERY_PLACE_ID,DELIVERY_PLACE FROM  CatalystQa.DELIVERY_PLACES
            <CFIF LEN(arguments.DeliveryPlaceId)>
                WHERE DELIVERY_PLACE_ID=#arguments.DeliveryPlaceId#
            </CFIF>
        </cfquery>
         <cfset ReturnArr=arrayNew(1)>
         <cfloop query="getAll">
             <cfscript>
                 item={
                    DELIVERY_PLACE_ID=DELIVERY_PLACE_ID,
                    DELIVERY_PLACE=DELIVERY_PLACE
                 };
                 arrayAppend(ReturnArr,item);
             </cfscript>
         </cfloop>
         <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>
    <cffunction name="getShipMethods" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="shipMethodID" default="">
        <cfquery name="getAll" datasource="#dsn#">
            select  SHIP_METHOD_ID,SHIP_METHOD from CatalystQA.SHIP_METHOD 
            <CFIF LEN(arguments.shipMethodID)>
                WHERE SHIP_METHOD_ID=#arguments.shipMethodID#
            </CFIF>
        </cfquery>
         <cfset ReturnArr=arrayNew(1)>
         <cfloop query="getAll">
             <cfscript>
                 item={
                    SHIP_METHOD_ID=SHIP_METHOD_ID,
                    SHIP_METHOD=SHIP_METHOD
                 };
                 arrayAppend(ReturnArr,item);
             </cfscript>
         </cfloop>
         <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>
    <cffunction name="getOfferConditions" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="ConditionID" default="">
        <cfquery name="getAll" datasource="#dsn#">
            select  ID,CONDITION from CatalystQA.PBS_OFFER_CONDITIONS 
            <CFIF LEN(arguments.ConditionID)>
                WHERE ID=#arguments.ConditionID#
            </CFIF>
        </cfquery>
         <cfset ReturnArr=arrayNew(1)>
         <cfloop query="getAll">
             <cfscript>
                 item={
                    ID=ID,
                    CONDITION=CONDITION
                 };
                 arrayAppend(ReturnArr,item);
             </cfscript>
         </cfloop>
         <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>
    <cffunction name="TarihIslem" access="remote" httpMethod="post" returntype="string" returnformat="plain">
        <cfargument name="Yil" required="true">
        <cfargument name="ay" required="true">
        <cfargument name="gun" required="true">
        <cfargument name="islem" default="0">
        <cfargument name="DatePart" default="d">
        <cfargument name="dValue" default="0">
        <cfset Tarih=createDate(arguments.yil,arguments.ay,arguments.gun)>
        <cfif arguments.islem eq 0>
            
        </cfif>
        <cfif arguments.islem eq 1>
            <cfset Tarih=dateAdd(arguments.DatePart,arguments.dValue,Tarih)>

        </cfif>
        
<cfset Tarih=dateFormat(Tarih,"yyyy-mm-dd")>
        <cfreturn Tarih>
    </cffunction>

<cffunction name="SaveOfferHeader" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
    <cfargument name="FData">

    <cfset FormData=deserializeJSON(arguments.FData)>
   
    <cfset ReturnData=structNew()>
  <cftry>
      <cfinclude template="../Query/SaveOffer.cfm">
    <cfset ReturnData.STATUS=1>
    <CFSET ReturnData.Message="Kayıt Başarılı">
    <cfset ReturnData.ErrorDetail="">
   <!---- -----><cfcatch>
        <cfset ReturnData.STATUS=0>
         <CFSET ReturnData.Message="Hata Oluştu">
        <cfset ReturnData.ErrorDetail="#cfcatch.message#">
        </cfcatch><!---
    <cfreturn replace(serializeJSON(ReturnData),"//","")>----->
</cftry>
</cffunction>
<cffunction name="getOfferDashBoard" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
  <cfquery name="QUERY_0" datasource="#DSN#">
   WITH CTE1 AS 
(
SELECT * FROM (
select STAGE,PROCESS_ROW_ID,1 AS OFFER_CURRENCY from CatalystQA.PROCESS_TYPE_ROWS where PROCESS_ID=193 AND DETAIL LIKE '%1%'
UNION ALL
select STAGE,PROCESS_ROW_ID,2 AS OFFER_CURRENCY from CatalystQA.PROCESS_TYPE_ROWS where PROCESS_ID=193 AND DETAIL LIKE '%2%'
) AS T 
CROSS APPLY(
    SELECT COUNT(*) AS QC FROM CatalystQA_1.PBS_OFFER WHERE OFFER_STAGE=T.PROCESS_ROW_ID AND OFFER_CURRENCY=T.OFFER_CURRENCY
    
) AS TF 

) ,CTE2 AS (
    SELECT SUM(QC) AS QCS,OFFER_CURRENCY FROM CTE1 GROUP BY OFFER_CURRENCY
)
 SELECT
				CTE2.*,CTE1.*

			FROM
				CTE2,
				CTE1 
            WHERE CTE2.OFFER_CURRENCY=CTE1.OFFER_CURRENCY
			
    </cfquery>
    <cfquery name="GETQS" dbtype="query">
        SELECT DISTINCT QCS,OFFER_CURRENCY FROM QUERY_0
    </cfquery>
<CFSET ReturnData=structNew()>
<CFSET ReturnData.OFFER_CURRENCY_TOTALS=arrayNew(1)>
<cfloop query="GETQS">
    <cfset ITEM=structNew()>
    <CFSET ITEM.CURRENCY_ID=OFFER_CURRENCY>
    <CFSET ITEM.CURRENCY_COUNT=QCS>
    <cfscript> arrayAppend(ReturnData.OFFER_CURRENCY_TOTALS,ITEM)</cfscript>
</CFLOOP>


    <cfreturn replace(serializeJSON(ReturnData),"//","")>
</cffunction>
<cffunction name="wrk_eval" returntype="string" output="false">
	<!--- loop inen donen satirlarda evaluatten kaynaklanan tirnak isareti sorununu cozer --->
	<cfargument name="gelen" required="no" type="string">
	<cfset wrk_sql_value = "#replaceNoCase(trim(evaluate("#gelen#")),"'","''","ALL")#">
	<cfreturn wrk_sql_value>
</cffunction>
</cfcomponent>

