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
        </cfcatch>
        
</cftry>
<cfreturn replace(serializeJSON(ReturnData),"//","")>
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
<CFSET ReturnData.OFFER_STAGE_TOTALS=arrayNew(1)>
<cfloop query="GETQS">
    <cfset ITEM=structNew()>
    <CFSET ITEM.CURRENCY_ID=OFFER_CURRENCY>
    <CFSET ITEM.CURRENCY_COUNT=QCS>
    <cfscript> arrayAppend(ReturnData.OFFER_CURRENCY_TOTALS,ITEM)</cfscript>
</CFLOOP>
<cfloop query="QUERY_0">
    <cfset ITEM=structNew()>
    <CFSET ITEM.CURRENCY_ID=OFFER_CURRENCY>
    <cfset ITEM.STAGE=STAGE>
    <cfset ITEM.PROCESS_ROW_ID=PROCESS_ROW_ID>
    <cfset ITEM.STAGE_COUNT=QC>
    <cfscript> arrayAppend(ReturnData.OFFER_STAGE_TOTALS,ITEM)</cfscript>
</CFLOOP>

    <cfreturn replace(serializeJSON(ReturnData),"//","")>
</cffunction>
<cffunction name="getOfferList" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
    <cfargument name="SALES_EMP_ID" default="">
    <cfargument name="OFFER_CURRENCY" default="">
    <cfargument name="OFFER_STAGE" default="">
    <cfargument name="OFFER_NUMBER" default="">
    <cfargument name="REF_NO" default="">
    <cfargument name="SALES_EMP_ID" default="">
    <cfargument name="START_DATE" default="">
    <cfargument name="FINISH_DATE" default="">
    <cfargument name="START_ROW" default="1">
    <cfargument name="MAX_ROW" default="20">
  <!--- <cfquery name="getOffers" datasource="#dsn#">
        	WITH CTE1 AS(
            SELECT
			C.NICKNAME,C.FULLNAME,PO.OFFER_HEAD,PO.OFFER_ID,PO.REF_NO,PO.OFFER_NUMBER,E.EMPLOYEE_NAME,E.EMPLOYEE_SURNAME,SM.SHIP_METHOD,PO.OFFER_CURRENCY,PO.OFFER_STAGE,PO.OFFER_DATE,PO.DELIVERY_ADDRESS,DP.DELIVERY_PLACE
			FROM 
				CatalystQA_1.PBS_OFFER AS PO
                INNER JOIN CatalystQA.COMPANY AS C ON C.COMPANY_ID=PO.COMPANY_ID
                INNER JOIN CatalystQA.EMPLOYEES AS E ON E.EMPLOYEE_ID=PO.SALES_EMP_ID
                INNER JOIN CatalystQA.SHIP_METHOD AS SM ON SM.SHIP_METHOD_ID=PO.SHIP_METHOD
                LEFT JOIN CatalystQA.DELIVERY_PLACES AS DP ON DP.DELIVERY_PLACE_ID=PO.DELIVERY_PLACE
			WHERE 
			1=1
            <CFIF LEN(arguments.SALES_EMP_ID)> and PO.SALES_EMP_ID=#arguments.SALES_EMP_ID#</CFIF>
            <CFIF LEN(arguments.OFFER_CURRENCY)>  AND PO.OFFER_CURRENCY=#arguments.OFFER_CURRENCY#</CFIF>
            <CFIF LEN(arguments.OFFER_STAGE)> AND PO.OFFER_STAGE=#arguments.OFFER_STAGE#</CFIF>
            <CFIF LEN(arguments.OFFER_NUMBER)>AND PO.OFFER_NUMBER='#arguments.OFFER_NUMBER#'</CFIF>
            <CFIF LEN(arguments.REF_NO)> AND PO.REF_NO='#arguments.REF_NO#'</CFIF>
            <CFIF LEN(arguments.START_DATE)>
                AND CONVERT(DATE,PO.OFFER_DATE)>=CONVERT(DATE,'#arguments.START_DATE#')
            </CFIF>
            <CFIF LEN(arguments.FINISH_DATE)>
                AND CONVERT(DATE,PO.OFFER_DATE)<=CONVERT(DATE,'#arguments.FINISH_DATE#')
            </CFIF>
            
             ),
			CTE2 AS 
			(
				SELECT
					CTE1.*,
					ROW_NUMBER() OVER (ORDER BY OFFER_ID) AS RowNum,(SELECT COUNT(*) FROM CTE1) AS QUERY_COUNT
				FROM
					CTE1
			)
			SELECT
				CTE2.*
			FROM
				CTE2
			WHERE
				
                RowNum BETWEEN #ARGUMENTS.START_ROW# and #ARGUMENTS.START_ROW#+(#ARGUMENTS.MAX_ROW#-1)

                
    </cfquery>
    <cfset ReturnArr=arrayNew(1)>
    <CFLOOP query="getOffers">
        <cfscript>
            OfferItem=structNew();
            OfferItem={
                NICKNAME=NICKNAME,
                FULLNAME=FULLNAME,
                OFFER_HEAD=OFFER_HEAD,
                OFFER_ID=OFFER_ID,
                REF_NO=REF_NO,
                OFFER_NUMBER=OFFER_NUMBER,
                EMPLOYEE_NAME=EMPLOYEE_NAME,
                EMPLOYEE_SURNAME=EMPLOYEE_SURNAME,
                SHIP_METHOD=SHIP_METHOD,
                OFFER_CURRENCY=OFFER_CURRENCY,
                OFFER_STAGE=OFFER_STAGE,
                OFFER_DATE=dateFormat(OFFER_DATE,"yyyy-mm-dd"),
                DELIVERY_ADDRESS=DELIVERY_ADDRESS,
                DELIVERY_PLACE=DELIVERY_PLACE
            };
            arrayAppend(ReturnArr,OfferItem);
        </cfscript>
        
    </CFLOOP>---->
    <cfreturn replace(serializeJSON(ReturnArr),"//","")>
</cffunction>
<cffunction name="wrk_eval" returntype="string" output="false">
	<!--- loop inen donen satirlarda evaluatten kaynaklanan tirnak isareti sorununu cozer --->
	<cfargument name="gelen" required="no" type="string">
	<cfset wrk_sql_value = "#replaceNoCase(trim(evaluate("#gelen#")),"'","''","ALL")#">
	<cfreturn wrk_sql_value>
</cffunction>
</cfcomponent>

