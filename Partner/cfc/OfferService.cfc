<cfcomponent>
    <cfset dsn = application.systemParam.systemParam().dsn>
    <cfset dsn3="#dsn#_1">
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
    <cfset ReturnData.OFFER_ID=RETURNED_OFFER_ID>
    <CFSET ReturnData.Message="Kayıt Başarılı">
    <cfset ReturnData.ErrorDetail="">
   <!---- -----><cfcatch>
        <cfset ReturnData.STATUS=0>
         <CFSET ReturnData.Message="Hata Oluştu">
         <cfset ReturnData.OFFER_ID=0>
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
<cffunction name="getPurchaseOfferListForSaleOffer" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
   <cfargument name="OFFER_ID">
    <cfquery name="OFFER_HEADER" datasource="#dsn3#">
        SELECT PO.OFFER_NUMBER,C.NICKNAME,PO.OFFER_ID,C.COMPANY_ID,C.MEMBER_CODE
FROM CatalystQA_1.PBS_OFFER AS PO
LEFT JOIN CatalystQA.COMPANY AS C ON C.COMPANY_ID IN (REPLACE(PO.OFFER_TO, ',', ''))
where FOR_OFFER_ID=#arguments.OFFER_ID#
    </cfquery>
    <CFSET RETURN_ARR=arrayNew(1)>
    <cfloop query="OFFER_HEADER">
        <cfquery name="OFFER_ROWS" datasource="#DSN3#">
            SELECT S.PRODUCT_NAME,S.PRODUCT_ID,S.STOCK_ID,S.MANUFACT_CODE,S.PRODUCT_CODE,UNIQUE_RELATION_ID,PU.MAIN_UNIT,CONVERT(decimal(18,2),POR.QUANTITY) QUANTITY,CONVERT(DECIMAL(18,4),POR.PRICE) PRICE,CONVERT(DECIMAL(18,4),POR.PRICE_OTHER) PRICE_OTHER ,POR.OTHER_MONEY 
            FROM CatalystQA_1.PBS_OFFER_ROW AS POR 
            LEFT JOIN CatalystQA_1.STOCKS AS S ON S.STOCK_ID=POR.STOCK_ID
            LEFT JOIN CatalystQA_1.PRODUCT_UNIT as PU ON PU.PRODUCT_ID=S.PRODUCT_ID AND PU.IS_MAIN=1
            WHERE POR.OFFER_ID=#OFFER_HEADER.OFFER_ID#
        </cfquery>
        <CFSET URUN_SAY=0>
        <CFSET FIYATLI_SAY=0>
        <cfscript>
            Ateklif=structNew();
            Ateklif.OFFER_NUMBER=OFFER_NUMBER;
            Ateklif.COMPANY_ID=COMPANY_ID;
            Ateklif.MEMBER_CODE=MEMBER_CODE;
            
            Ateklif.NICKNAME=NICKNAME;
            Ateklif.OFFER_ID=OFFER_HEADER.OFFER_ID;
            Ateklif.OFFER_ROWS.ROW_COUNT=OFFER_ROWS.recordcount;
            Ateklif.OFFER_ROWS.ROWS=arrayNew(1);
        </cfscript>
        <cfloop query="OFFER_ROWS">
            <cfscript>
                PAROW=structNew();
                PAROW.PRODUCT_NAME=PRODUCT_NAME;
                PAROW.PRODUCT_ID=PRODUCT_ID;
                PAROW.STOCK_ID=STOCK_ID;
                PAROW.MANUFACT_CODE=MANUFACT_CODE;
                PAROW.PRODUCT_CODE=PRODUCT_CODE;
                PAROW.QUANTITY=QUANTITY;
                PAROW.PRICE_OTHER=PRICE_OTHER;
                PAROW.OTHER_MONEY=OTHER_MONEY;
                PAROW.UNIQUE_RELATION_ID=UNIQUE_RELATION_ID;
                PAROW.MAIN_UNIT=MAIN_UNIT;
                PAROW.PRICE=PRICE;
            arrayAppend(Ateklif.OFFER_ROWS.ROWS,PAROW)
            IF(PRICE NEQ 0){
                FIYATLI_SAY=FIYATLI_SAY+1;
            }


            </cfscript>
        
        </cfloop>
        <cfscript>
            Ateklif.OFFER_ROWS.FIYAT_VERILEN=FIYATLI_SAY;
            arrayAppend(RETURN_ARR,Ateklif)
        </cfscript>
    </cfloop>
    <cfreturn replace(serializeJSON(RETURN_ARR),"//","")> <!----------->
    <cfreturn replace(serializeJSON(arguments),"//","")>
</cffunction>
  <cffunction name="getOfferList" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
    <cfargument name="SALES_EMP_ID" default="">
    <cfargument name="OFFER_CURRENCY" default="">
    <cfargument name="OFFER_STAGE" default="">
    <cfargument name="OFFER_NUMBER" default="">
    <cfargument name="REF_NO" default="">
    <cfargument name="COMPANY_ID" default="">
   <cfargument name="START_DATE" default="">
    <cfargument name="FINISH_DATE" default="">
    <cfargument name="START_ROW" default="1">
    <cfargument name="MAX_ROW" default="20">
    
 <cfquery name="getOffers" datasource="#dsn#">
        	WITH CTE1 AS(
            SELECT
			C.NICKNAME,C.FULLNAME,PO.OFFER_HEAD,PO.OFFER_ID,PO.REF_NO AS OREF ,PO.OFFER_NUMBER as ONUM,E.EMPLOYEE_NAME,E.EMPLOYEE_SURNAME,SM.SHIP_METHOD,PO.OFFER_CURRENCY OCUUR,PO.OFFER_STAGE,PO.OFFER_DATE,PO.DELIVERY_ADDRESS,DP.DELIVERY_PLACE
			FROM 
				CatalystQA_1.PBS_OFFER AS PO
                INNER JOIN CatalystQA.COMPANY AS C ON C.COMPANY_ID=PO.COMPANY_ID
                INNER JOIN CatalystQA.EMPLOYEES AS E ON E.EMPLOYEE_ID=PO.SALES_EMP_ID
                INNER JOIN CatalystQA.SHIP_METHOD AS SM ON SM.SHIP_METHOD_ID=PO.SHIP_METHOD
                LEFT JOIN CatalystQA.DELIVERY_PLACES AS DP ON DP.DELIVERY_PLACE_ID=PO.DELIVERY_PLACE
			WHERE 
			1=1
            <CFIF LEN(arguments.SALES_EMP_ID)> and PO.SALES_EMP_ID=#arguments.SALES_EMP_ID#</CFIF>
            <CFIF LEN(arguments.COMPANY_ID)> and PO.COMPANY_ID=#arguments.COMPANY_ID#</CFIF>
            <CFIF LEN(arguments.OFFER_CURRENCY) and OFFER_CURRENCY neq 0>  AND PO.OFFER_CURRENCY=#arguments.OFFER_CURRENCY#</CFIF>
            <CFIF LEN(arguments.OFFER_STAGE) and OFFER_STAGE NEQ 0> AND PO.OFFER_STAGE=#arguments.OFFER_STAGE#</CFIF>
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
     <cfsavecontent  variable="control5">
        <cfdump  var="#CGI#">                
        <cfdump  var="#arguments#">
        <cfdump  var="#getOffers#">
        
       </cfsavecontent>
       <cffile action="write" file = "c:\GetOfferList.html" output="#control5#"></cffile>
       <cfset ReturnData.QUERY_COUNT=getOffers.QUERY_COUNT>
    <cfset ReturnArr=arrayNew(1)>
    <CFLOOP query="getOffers">
        <cfscript>
            OfferItem=structNew();
            OfferItem={
                NICKNAME=NICKNAME,
                FULLNAME=FULLNAME,
                OFFER_HEAD=OFFER_HEAD,
                OFFER_ID=OFFER_ID,
                REF_NO=OREF,
                OFFER_NUMBER=ONUM,
                EMPLOYEE_NAME=EMPLOYEE_NAME,
                EMPLOYEE_SURNAME=EMPLOYEE_SURNAME,
                SHIP_METHOD=SHIP_METHOD,
                OFFER_CURRENCY=OCUUR,
                OFFER_STAGE=OFFER_STAGE,
                OFFER_DATE=dateFormat(OFFER_DATE,"dd/mm/yyyy"),
                DELIVERY_ADDRESS=DELIVERY_ADDRESS,
                DELIVERY_PLACE=DELIVERY_PLACE,
                ROW_NUMBER=RowNum
            };
            arrayAppend(ReturnArr,OfferItem);
        </cfscript>
        
    </CFLOOP>
    <cfset ReturnData.OFFERS=ReturnArr>
    <cfreturn replace(serializeJSON(ReturnData),"//","")><!--- ---->
</cffunction>
<cffunction name="getOfferWithOfferId" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
    <cfargument name="OFFER_ID" required="true">
 
 <cfquery name="getOfferHead" datasource="#dsn#">
      WITH CTE1
AS (
	SELECT C.NICKNAME
		,C.FULLNAME
        ,C.COMPANY_ADDRESS
		,PO.OFFER_HEAD
		,PO.OFFER_ID
		,PO.REF_NO AS OREF
        ,PO.OTHER_MONEY_VALUE
		,PO.OFFER_NUMBER AS ONUM
		,E.EMPLOYEE_NAME
		,E.EMPLOYEE_SURNAME
		,SM.SHIP_METHOD
		,PO.OFFER_CURRENCY OCUUR
		,PO.OFFER_STAGE
		,PO.OFFER_DATE
		,PO.DELIVERY_ADDRESS
		,DP.DELIVERY_PLACE
		,POC.CONDITION
		,OCUR.OFFER_CURRENCY AS OFFCRRCNCY
		,PS.SHIP_NAME
        ,PS.IMO_NUMBER
        ,PO.WESSEL_ID
		,PO.OTHER_MONEY
		,PO.VALID_DAYS
		,PO.OFFER_DETAIL
		,PO.DELIVERDATE
	FROM CatalystQA_1.PBS_OFFER AS PO
	INNER JOIN CatalystQA.COMPANY AS C
		ON C.COMPANY_ID = PO.COMPANY_ID
	INNER JOIN CatalystQA.EMPLOYEES AS E
		ON E.EMPLOYEE_ID = PO.SALES_EMP_ID
	INNER JOIN CatalystQA.SHIP_METHOD AS SM
		ON SM.SHIP_METHOD_ID = PO.SHIP_METHOD
	LEFT JOIN CatalystQA.DELIVERY_PLACES AS DP
		ON DP.DELIVERY_PLACE_ID = PO.DELIVERY_PLACE
	LEFT JOIN CatalystQA.PBS_OFFER_CONDITIONS AS POC
		ON POC.ID = PO.OFFER_CONDITION
	LEFT JOIN CatalystQA_1.OFFER_CURRENCY AS OCUR
		ON OCUR.OFFER_CURRENCY_ID = PO.OFFER_CURRENCY
	LEFT JOIN CatalystQA.PBS_SHIPS AS PS
		ON PS.SHIP_ID = PO.WESSEL_ID
	WHERE 1 = 1 AND PO.OFFER_ID = #arguments.OFFER_ID#
	)
	,CTE2
AS (
	SELECT CTE1.*
		,ROW_NUMBER() OVER (
			ORDER BY OFFER_ID
			) AS RowNum
		,(
			SELECT COUNT(*)
			FROM CTE1
			) AS QUERY_COUNT
	FROM CTE1
	)
SELECT CTE2.*
FROM CTE2
WHERE 1 = 1

                
    </cfquery>
     <cfsavecontent  variable="control5">
        <cfdump  var="#CGI#">                
        <cfdump  var="#arguments#">
        <cfdump  var="#getOfferHead#">
        
       </cfsavecontent>
       <cffile action="write" file = "c:\GetOfferList.html" output="#control5#"></cffile>
      <cfset OfferItem=structNew()>
    <CFLOOP query="getOfferHead">
        <cfscript>
            
            OfferItem={
                NICKNAME=NICKNAME,
                FULLNAME=FULLNAME,
                OFFER_HEAD=OFFER_HEAD,
                OFFER_ID=OFFER_ID,
                REF_NO=OREF,
                OFFER_NUMBER=ONUM,
                EMPLOYEE_NAME=EMPLOYEE_NAME,
                EMPLOYEE_SURNAME=EMPLOYEE_SURNAME,
                SHIP_METHOD=SHIP_METHOD,
                OTHER_MONEY_VALUE=OTHER_MONEY_VALUE,
                OFFER_CURRENCY=OFFCRRCNCY,
                OFFER_CURRENCY_ID=OCUUR,
                OFFER_STAGE=OFFER_STAGE,
                COMPANY_ADDRESS=COMPANY_ADDRESS,
                IMO_NUMBER=IMO_NUMBER,
                OFFER_DATE=dateFormat(OFFER_DATE,"dd/mm/yyyy"),
                DELIVERY_ADDRESS=DELIVERY_ADDRESS,
                DELIVERY_PLACE=DELIVERY_PLACE,
                DELIVERDATE=dateFormat(DELIVERDATE,"dd/mm/yyyy"),
                OFFER_DETAIL=OFFER_DETAIL,
                VALID_DAYS=VALID_DAYS,
                OTHER_MONEY=OTHER_MONEY,
                SHIP_NAME=SHIP_NAME,
                CONDITION=CONDITION,
                WESSEL_ID=WESSEL_ID,
                ROW_NUMBER=RowNum
            };
            
        </cfscript>
        
    </CFLOOP>
    <cfreturn replace(serializeJSON(OfferItem),"//","")>
</cffunction>

<cffunction name="SAVE_OFFER_ROWS" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
    <cfargument name="Data">
    <cfset FormData=deserializeJSON(arguments.Data)>
    <cfdump var="#FormData#">
    <CFSET attributes.OFFER_ID=FormData.OFFER_HEADER.OFFER_ID>
    <cfquery name="UP" datasource="#DSN3#">
        UPDATE PBS_OFFER SET NETTOTAL=#FormData.OFFER_FOOTER.brut_total_wanted_#,PRICE=#FormData.OFFER_FOOTER.brut_total_wanted_#,OTHER_MONEY_VALUE=#FormData.OFFER_FOOTER.net_total_wanted#
        WHERE OFFER_ID=#attributes.OFFER_ID#
    </cfquery>
    

    <cfset attributes.ROWS_=arrayLen(FormData.ROWS)>
    
    <cfloop array="#FormData.ROWS#" item="it" index="i">
       
       <cfquery name="GETU" datasource="#dsn#">
            SELECT * FROM CatalystQA.CatalystQA_product.PRODUCT_UNIT WHERE PRODUCT_ID=#it.PRODUCT_ID# AND IS_MAIN=1
        </cfquery>
        <cfset "attributes.deliver_date#i#"=dateFormat(now(),"dd/mm/yyyy")>
        <cfset "attributes.price#i#"=it.PRICE>
        <cfset "attributes.product_id#i#"=it.PRODUCT_ID>
        <cfset "attributes.stock_id#i#"=it.STOCK_ID>
        <cfset "attributes.amount#i#"=it.AMOUNT>
        <cfset UNITA="">
        <cfif it.STOCK_ID eq 0>
            <cfset "attributes.unit#i#"=it.PRODUCT_UNIT>
            <cfset "attributes.unit_id#i#"=0>
            <cfset UNITA=it.PRODUCT_UNIT>
        <cfelse>
        <cfset "attributes.unit#i#"=GETU.MAIN_UNIT>
        <cfset "attributes.unit_id#i#"=GETU.PRODUCT_UNIT_ID>
        <cfset UNITA=GETU.MAIN_UNIT>
    </cfif>
        <cfset "attributes.tax#i#"=it.TAX>
        <cfset "attributes.product_name#i#"=it.PRODUCT_NAME>
        <cfset "attributes.other_money_#i#"=it.OTHER_MONEY>
        <cfset "attributes.other_money_value_#i#"=it.OTHER_MONEY_VALUE>
        <cfset "attributes.price_other#i#"=it.PRICE_OTHER>
        <cfset "attributes.iskonto_tutar#i#"=it.SALE_DISCOUNT>
        <CFSET 'attributes.ROW_NUMBER_PBS#i#'=it.SEPET_SIRA>
        <CFSET 'attributes.PROP_LIST#i#'=it.PROP_LIST>
        <CFSET 'attributes.JSON_STRINGIM#i#'=serializeJSON(it.JSON_STRINGIM)>
        <CFSET 'attributes.IS_VIRTUAL#i#'=it.IS_VIRTUAL>
        <cfset 'attributes.row_unique_relation_id#i#'=it.UNIQUE_RELATION_ID>
        <cfset 'attributes.wrk_row_id#i#'=it.UNIQUE_RELATION_ID>
        <cfif it.IS_VIRTUAL eq 1>
           <cfquery name="ihbgs" datasource="#dsn3#">
                SELECT * FROM VIRTUAL_PRODUCTS_PBS WHERE OFFER_ROW_REL='#it.UNIQUE_RELATION_ID#'
           </cfquery>
           <CFIF ihbgs.recordCount neq 0>

           <cfelse>
           <cfquery name="INS" datasource="#dsn#" result="RES">
                INSERT INTO CatalystQA_1.VIRTUAL_PRODUCTS_PBS (
                    PRODUCT_NAME,PRODUCT_UNIT,OFFER_ROW_REL,JSON_STRINGIM,PART_NUMBER
                )
                VALUES (
                    '#it.PRODUCT_NAME#','#UNITA#','#it.UNIQUE_RELATION_ID#','#serializeJSON(it.JSON_STRINGIM)#','#it.PRODUCT_CODE_2#'
                )
            </cfquery>
              <cfset "attributes.product_id#i#"=RES.GENERATEDKEY>
              <cfset "attributes.stock_id#i#"=RES.GENERATEDKEY>
            </CFIF>
        </cfif>
    </cfloop>
    <cfdump var="#attributes#">
    <cftry>
    <cfinclude template="../Query/Add_Offer_Rows.cfm">

    <cfcatch>
        <cfdump var="#cfcatch#">
    </cfcatch>
</cftry>
    <cfreturn replace(serializeJSON(FormData),"//","")>

</cffunction>

<cffunction name="SetOfferStage" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
    <cfargument name="OfferId">
    <cfargument name="Stage">
    <cfquery name="up" datasource="#DSN3#">
        UPDATE PBS_OFFER SET OFFER_STAGE=#arguments.Stage# WHERE OFFER_ID=#arguments.OfferId#
    </cfquery>
</cffunction> 
<cffunction name="UseThis" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
    <cfargument name="FData">
    <cfset FormData=deserializeJSON(arguments.FData)>

    <cfif FormData.Tip eq 1>
        <!---
            Teklifi Güncellee    
        ---->
        <cfquery name="Up" datasource="#dsn3#">
            UPDATE PBS_OFFER_ROW SET IS_VIRTUAL=0,PRODUCT_ID=#FormData.PRODUCT_ID#,STOCK_ID=#FormData.STOCK_ID#
            WHERE UNIQUE_RELATION_ID='#FormData.UNIQUE_RELATION_ID#'
        </cfquery>
    
    <cfelseif FormData.Tip eq 2>
        <cfloop array="#FormData.AddedProperties#" item="it">
            <cfquery name="ishvpp" datasource="#dsn#">
                SELECT PRODUCT_ID,PROPERTY_ID,VARIATION_ID,RECORD_EMP,RECORD_DATE,AMOUNT FROM CatalystQA_product.PRODUCT_DT_PROPERTIES WHERE PRODUCT_ID=#FORMDATA.PRODUCT_ID#
                AND PROPERTY_ID=#it.PROPERTY_ID# AND VARIATION_ID=#it.VARIATION_ID#
            </cfquery>
            <cfif ishvpp.recordCount eq 0>
<cfquery name="INS" datasource="#DSN#">
 INSERT INTO CatalystQA_product.PRODUCT_DT_PROPERTIES (
    PRODUCT_ID,PROPERTY_ID,VARIATION_ID,RECORD_EMP,RECORD_DATE,AMOUNT
 )
 values(
    #FORMDATA.PRODUCT_ID#,#it.PROPERTY_ID#,#it.VARIATION_ID#,#FormData.RECORD_EMP#,GETDATE(),0
 )
</cfquery>
<cfquery name="Up" datasource="#dsn3#">
    UPDATE PBS_OFFER_ROW SET IS_VIRTUAL=0,PRODUCT_ID=#FormData.PRODUCT_ID#,STOCK_ID=#FormData.STOCK_ID#
    WHERE UNIQUE_RELATION_ID='#FormData.UNIQUE_RELATION_ID#'
</cfquery>

</cfif>
        </cfloop>
        <!---
            Ürün Özelliklerini Aktar Teklifi Güncelle
        ---->
    <cfelseif FormData.Tip eq 3>
        <!---
            Yeni Ürün Oluştur Teklifi Güncelle
        --->

    </cfif>


</cffunction>

<cffunction name="AddPurchaseOffer" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
    <cfdump var="#arguments#">
    <cfset __FormData=deserializeJSON(arguments.FormData)>
    <cfset _FormData=__FormData.FormData>
<cfset form.active_company=1>

<CFSET attributes.to_comp_ids="">
<CFSET attributes.to_par_ids="">
<cfset FORM.OFFER_HEAD="Teklif İstiyoruz">
<cfset FORM.OFFER_DETAIL ="">
<cfset FORM.PROCESS_STAGE  =269>
<cfset attributes.PROCESS_STAGE  =269>
<cfset attributes.PROCESS_STAGE  =269>
<cfset attributes.OPPORTUNITY_ID   ="">
<cfset attributes.OFFER_DATE  =dateFormat(now(),"dd/mm/yyyy")>

<cfloop from="1" to="#arrayLen(_FormData)#" index="ix">
    
    <cfset Item=_FormData[ix]>
    <cfdump var="#Item#">
    <cfif not isDefined("item.IS_PURCHASE_SAVED")>
        <cfset item.IS_PURCHASE_SAVED=0>
    </cfif>
    <cfif Item.IS_PURCHASE_SAVED eq 0>
    
    <cfquery name="getCompanyInfo" datasource="#dsn#">
        SELECT * FROM COMPANY WHERE COMPANY_ID=#Item.COMPANY_ID#
    </cfquery>
    <cfdump var="#getCompanyInfo#">
   <cfset attributes.COMPANY_ID=Item.COMPANY_ID>
   <cfset attributes.PARTNER_ID=getCompanyInfo.MANAGER_PARTNER_ID>
   <cfset attributes.related_offer_id=__FormData.OFFER_ID>
   <CFSET CC_COMP=Item.COMPANY_ID>
   <CFSET CC_PART=getCompanyInfo.MANAGER_PARTNER_ID>
   <CFSET CC_CONS ="">
    <CFSET attributes.ROWS_ =arrayLen(Item.PIDS)>
    <cfloop from="1" to="#attributes.ROWS_#" index="iy">
        <cfset Pr=ITEM.PIDS[iy]>
      
        <cfset "attributes.spect_id#iy#"="">
        <cfset "attributes.price#iy#"=0>
        <cfset "attributes.product_id#iy#"=PR.PID>
        <cfset "attributes.stock_id#iy#"=PR.SID>
        <cfset "attributes.amount#iy#"=PR.QUANTITY>
        <cfquery name="getu" datasource="#dsn#">
            select * from CatalystQA_product.PRODUCT_UNIT WHERE PRODUCT_ID=#PR.PID# AND IS_MAIN=1
        </cfquery>
        <cfquery name="GETP" datasource="#DSN#">
            SELECT * FROM CatalystQA_product.PRODUCT WHERE PRODUCT_ID=#PR.PID#
        </cfquery>
        <CFIF isDefined("PR.PRODUCT_UNIT") and len(PR.PRODUCT_UNIT)>
        <cfset "attributes.unit#iy#"=PR.PRODUCT_UNIT>
        <CFELSE>
            <cfset "attributes.unit#iy#"=getu.MAIN_UNIT>
        </CFIF>
        <cfset "attributes.unit_id#iy#"=getu.PRODUCT_UNIT_ID>
        <cfset "attributes.tax#iy#"=GETP.TAX>
        <cfset "attributes.product_name#iy#"=PR.PRODUCT_NAME>
        <cfset 'attributes.row_unique_relation_id#iy#'=PR.UNIQUE_RELATION_ID>
        <cfset 'attributes.wrk_row_relation_id#iy#'=PR.UNIQUE_RELATION_ID>
    </cfloop>
    <cftry>
    <cfinclude template="/AddOns/YafSatis/Partner/Query/includes/add_purchase_offer.cfm">
<cfcatch>
    <cfdump var="#cfcatch#">
</cfcatch>
</cftry>
</cfif>
</cfloop>
<cfdump var="#attributes#">
    
</cffunction>

<cffunction name="getPurchaseOffer" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
<cfargument name="offer_id">
<cfquery name="getOffer" datasource="#dsn3#">
    SELECT C.NICKNAME,C.FULLNAME,DELIVERDATE,OFFER_ID,DELIVER_FEE,TAX_STATUS,GENERAL_DISCOUNT_RATE,OTHER_MONEY,OFFER_STAGE,OFFER_DATE,PO.REF_NO,E.EMPLOYEE_NAME,E.EMPLOYEE_SURNAME  FROM CatalystQA_1.PBS_OFFER AS PO 
LEFT JOIN CatalystQA.COMPANY AS C ON C.COMPANY_ID IN(REPLACE(PO.OFFER_TO,',',''))
LEFT JOIN CatalystQA.EMPLOYEES AS E ON E.EMPLOYEE_ID=PO.SALES_EMP_ID
WHERE PO.OFFER_ID=#arguments.OFFER_ID#
</cfquery>
<cfquery name="getOfferROW" datasource="#dsn3#">
SELECT POR1.PRODUCT_NAME
	,POR1.QUANTITY
    
	,POR2.PROP_LIST
	,POR2.JSON_STRINGIM
	,ISNULL(POR1.PRICE,0)  AS PRICE
	,ISNULL(POR1.PRICE_OTHER,0) AS PRICE_OTHER
	,ISNULL(POR1.DISCOUNT_COST,0) DISCOUNT_COST
    ,POR1.OTHER_MONEY
	,POR2.UNIT
    ,POR2.IS_VIRTUAL
    ,POR2.WRK_ROW_ID
	,CASE WHEN POR2.IS_VIRTUAL = 1 THEN VP.PART_NUMBER ELSE S.MANUFACT_CODE END AS PART_NUMBER
	,POR2.UNIQUE_RELATION_ID
    ,POR2.PRODUCT_ID
    ,POR2.STOCK_ID
FROM CatalystQA_1.PBS_OFFER_ROW AS POR1
LEFT JOIN CatalystQA_1.PBS_OFFER AS PO
	ON PO.OFFER_ID = POR1.OFFER_ID
LEFT JOIN CatalystQA_1.PBS_OFFER_ROW AS POR2
	ON POR2.WRK_ROW_ID = POR1.WRK_ROW_RELATION_ID
LEFT JOIN CatalystQA_1.STOCKS AS S
	ON S.STOCK_ID = POR2.STOCK_ID
LEFT JOIN CatalystQA_1.VIRTUAL_PRODUCTS_PBS AS VP
	ON VP.VP_ID = POR2.STOCK_ID
WHERE POR1.OFFER_ID=#arguments.OFFER_ID#
</cfquery>
<CFSET OFFER_DATA=structNew()>
<CFSET OFFER_DATA.NICKNAME=getOffer.NICKNAME>
<CFSET OFFER_DATA.OFFER_ID=getOffer.OFFER_ID>
<CFSET OFFER_DATA.FULLNAME=getOffer.FULLNAME>
<CFSET OFFER_DATA.DELIVERDATE=getOffer.DELIVERDATE>
<CFSET OFFER_DATA.OFFER_DATE=getOffer.OFFER_DATE> 
<CFSET OFFER_DATA.OFFER_STAGE=getOffer.OFFER_STAGE> 
<CFSET OFFER_DATA.EMPLOYEE_NAME=getOffer.EMPLOYEE_NAME> 
<CFSET OFFER_DATA.EMPLOYEE_SURNAME=getOffer.EMPLOYEE_SURNAME> 
<CFSET OFFER_DATA.REF_NO=getOffer.REF_NO> 
<CFSET OFFER_DATA.TAX_STATUS=getOffer.TAX_STATUS>
<CFSET OFFER_DATA.GENERAL_DISCOUNT_RATE=getOffer.GENERAL_DISCOUNT_RATE>
<CFSET OFFER_DATA.DELIVER_FEE=getOffer.DELIVER_FEE>
<cfset OFFER_DATA.OTHER_MONEY =getOffer.OTHER_MONEY>
<CFSET OFFER_DATA.PROP_ARR=arrayNew(1)>
<CFLOOP query="getOfferROW" group="PROP_LIST">
   <CFSET PROP_ITEM=structNew()>
    <cfset PROP_ITEM.PROP_LIST=PROP_LIST>
    <cfset PROP_ITEM.JSON_STRINGIM=JSON_STRINGIM>
    <cfset PROP_ITEM.OFFER_ROWS=arrayNew(1)>
    <cfloop>
        <CFSET RowItem=structNew()>
        <cfset RowItem.PRODUCT_NAME=PRODUCT_NAME>
        <cfset RowItem.QUANTITY=QUANTITY>
        <cfset RowItem.PRICE=PRICE>
        <cfset RowItem.PRICE_OTHER=PRICE_OTHER>
        <cfset RowItem.DISCOUNT_COST=DISCOUNT_COST>
        <cfset RowItem.UNIT=UNIT>
        <cfset RowItem.IS_VIRTUAL=IS_VIRTUAL>
        <cfset RowItem.PRODUCT_ID=PRODUCT_ID>
        <cfset RowItem.STOCK_ID=STOCK_ID>
        <cfset RowItem.OTHER_MONEY=OTHER_MONEY>
        <cfset RowItem.UNIQUE_RELATION_ID=WRK_ROW_ID>
        <cfset RowItem.PART_NUMBER=PART_NUMBER>
        <cfscript>
            arrayAppend(PROP_ITEM.OFFER_ROWS,RowItem);
        </cfscript>
    </cfloop>
    <cfscript>
        arrayAppend(OFFER_DATA.PROP_ARR,PROP_ITEM);
    </cfscript>
</CFLOOP>
<cfreturn replace(serializeJSON(OFFER_DATA),"//","")>
</cffunction>

<cffunction name="listPurchaseOffers" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
    <cfquery name="GETPO" datasource="#DSN3#">
        SELECT PO.OFFER_NUMBER AS PURCHASE_OFFER_NUMBER
    ,C.NICKNAME AS PURCHASE_COMPANY_NICKNAME    
	,C.FULLNAME AS PURCHASE_COMPANY_FULLNAME
	,PO.OFFER_DATE AS PURHASE_OFFER_DATE
    ,PO.DELIVERDATE AS PURCHASE_DELIVER_DATE
	,PO.OFFER_ID AS PURCHASE_OFFER_ID
    ,PO.OFFER_STAGE AS PURCHASE_STAGE
    ,'----------' AS AYRIM
    ,C2.NICKNAME AS SALES_COMPANY_NICKNAME
    ,C2.FULLNAME AS SALES_COMPANY_FULLNAME
	,PO2.OFFER_NUMBER AS SALES_OFFER_NUMBER
    ,PO2.OFFER_DATE AS SALES_OFFER_DATE
    ,PO2.DELIVERDATE AS SALES_DELIVER_DATE
    ,PO2.OFFER_ID AS SALES_OFFER_ID
    ,PO2.OFFER_STAGE AS SALES_STAGE
FROM CatalystQA_1.PBS_OFFER AS PO
LEFT JOIN CatalystQA.COMPANY AS C ON C.COMPANY_ID IN (REPLACE(PO.OFFER_TO, ',', ''))
LEFT JOIN CatalystQA_1.PBS_OFFER AS PO2 ON PO2.OFFER_ID = PO.FOR_OFFER_ID
LEFT JOIN CatalystQA.COMPANY AS C2 ON C2.COMPANY_ID = PO2.COMPANY_ID
WHERE 1=1
AND PO2.OFFER_NUMBER IS NOT NULL
ORDER BY PO2.OFFER_ID
    </cfquery>
    <CFSET RETURN_ARR=arrayNew(1)>
    <CFLOOP query="GETPO" group="SALES_OFFER_ID">
        <CFSET MAIN_OFFER=structNew()>
        <cfset MAIN_OFFER.OFFER_ID=SALES_OFFER_ID>
        <cfset MAIN_OFFER.COMPANY_NICKNAME=SALES_COMPANY_NICKNAME>
        <cfset MAIN_OFFER.COMPANY_FULLNAME=SALES_COMPANY_FULLNAME>
        <cfset MAIN_OFFER.OFFER_NUMBER=SALES_OFFER_NUMBER>
        <cfset MAIN_OFFER.OFFER_DATE=SALES_OFFER_DATE>
        <cfset MAIN_OFFER.DELIVER_DATE=SALES_DELIVER_DATE>
        <cfset MAIN_OFFER.STAGE=SALES_STAGE>
        <CFSET MAIN_OFFER.REL_OFFERS=arrayNew(1)>
        <cfloop>
            <CFSET SUB_OFFER=structNew()>
            <cfset SUB_OFFER.OFFER_ID=PURCHASE_OFFER_ID>
            <cfset SUB_OFFER.COMPANY_NICKNAME=PURCHASE_COMPANY_NICKNAME>
            <cfset SUB_OFFER.COMPANY_FULLNAME=PURCHASE_COMPANY_FULLNAME>
            <cfset SUB_OFFER.OFFER_NUMBER=PURCHASE_OFFER_NUMBER>
            <cfset SUB_OFFER.OFFER_DATE=PURHASE_OFFER_DATE>
            <cfset SUB_OFFER.DELIVER_DATE=PURCHASE_DELIVER_DATE>
            <cfset SUB_OFFER.STAGE=PURCHASE_STAGE>
            <cfscript>
                arrayAppend(MAIN_OFFER.REL_OFFERS,SUB_OFFER);
            </cfscript>
        </cfloop>

        <cfscript>
            arrayAppend(RETURN_ARR,MAIN_OFFER);
        </cfscript>
    </CFLOOP>
    <cfreturn replace(serializeJSON(RETURN_ARR),"//","")>
</cffunction>

<cffunction name="SAVE_PURCHASE_OFFER_PRICES" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
    <cfargument name="data">
    <cfset FormData=deserializeJSON(arguments.data)>
    <cfdump var="#FormData#">
    <CFSET attributes.OFFER_ID=FormData.OFFER_ID>
    <cfquery name="UP" datasource="#DSN3#">
        UPDATE PBS_OFFER SET NETTOTAL=#FormData.OFFER_FOOTER.brut_total_wanted_#,PRICE=#FormData.OFFER_FOOTER.brut_total_wanted_#,OTHER_MONEY_VALUE=#FormData.OFFER_FOOTER.net_total_wanted#,OTHER_MONEY='#FORMDATA.AKTIF_KUR#',
        DELIVER_FEE='#FORMDATA.DELIVER_FEE#' ,TAX_STATUS ='#FORMDATA.TAX_STATUS#',GENERAL_DISCOUNT_RATE =<CFIF LEN(FORMDATA.GENERAL_DISCOUNT)>#FORMDATA.GENERAL_DISCOUNT#<CFELSE>0</CFIF>
        WHERE OFFER_ID=#attributes.OFFER_ID#
    </cfquery>

    <cfloop array="#FormData.ROWS#" item="it" index="i">
      
        <cfquery name="GETU" datasource="#dsn#">
            SELECT * FROM CatalystQA.CatalystQA_product.PRODUCT_UNIT WHERE PRODUCT_ID=#it.PRODUCT_ID# AND IS_MAIN=1
        </cfquery>
        <cfset "attributes.deliver_date#i#"=dateFormat(now(),"dd/mm/yyyy")>
        <cfset "attributes.price#i#"=it.PRICE>
        <cfset "attributes.product_id#i#"=it.PRODUCT_ID>
        <cfset "attributes.stock_id#i#"=it.STOCK_ID>
        <cfset "attributes.amount#i#"=it.AMOUNT>
        <cfset UNITA="">
        <cfif it.STOCK_ID eq 0>
            <cfset "attributes.unit#i#"=it.PRODUCT_UNIT>
            <cfset "attributes.unit_id#i#"=0>
            <cfset UNITA=it.PRODUCT_UNIT>
        <cfelse>
        <cfset "attributes.unit#i#"=GETU.MAIN_UNIT>
        <cfset "attributes.unit_id#i#"=GETU.PRODUCT_UNIT_ID>
        <cfset UNITA=GETU.MAIN_UNIT>
    </cfif>
        <cfset "attributes.tax#i#"=it.TAX>
        <cfset "attributes.product_name#i#"=it.PRODUCT_NAME>
        <cfset "attributes.other_money_#i#"=it.SALE_MONEY>
        <cfset "attributes.other_money_value_#i#"=it.OTHER_MONEY_VALUE>
        <cfset "attributes.price_other#i#"=it.PRICE_OTHER>
        <cfset "attributes.iskonto_tutar#i#"=it.SALE_DISCOUNT>
        <CFSET 'attributes.ROW_NUMBER_PBS#i#'=it.SEPET_SIRA>
        <CFSET 'attributes.PROP_LIST#i#'=it.PROP_LIST>
        <CFSET 'attributes.JSON_STRINGIM#i#'=serializeJSON(it.JSON_STRINGIM)>
        <CFSET 'attributes.IS_VIRTUAL#i#'=it.IS_VIRTUAL>
        <cfset 'attributes.row_unique_relation_id#i#'=it.UNIQUE_RELATION_ID>
        <cfset 'attributes.wrk_row_id#i#'=it.UNIQUE_RELATION_ID>
      
        <cfquery name="updrows" datasource="#dsn3#">
           UPDATE PBS_OFFER_ROW SET PRICE=#evaluate('attributes.price#i#')#, 
           PRICE_OTHER=#evaluate('attributes.price_other#i#')#,
           TAX=#evaluate('attributes.tax#i#')#,
           OTHER_MONEY='#evaluate('attributes.other_money_#i#')#',
           OTHER_MONEY_VALUE=#evaluate('attributes.other_money_value_#i#')#,
           DISCOUNT_COST=#evaluate('attributes.iskonto_tutar#i#')#,
           EXTRA_PRICE_TOTAL=0
           
           WHERE OFFER_ID=#attributes.OFFER_ID# AND UNIQUE_RELATION_ID='#it.UNIQUE_RELATION_ID#'
        </cfquery>
    </cfloop>
    <cfquery name="ihv" datasource="#dsn3#">
        SELECT * FROM PBS_OFFER_MONEY WHERE ACTION_ID=#attributes.OFFER_ID# 
    </cfquery>
    <CFIF ihv.recordCount EQ 0>
    <cfloop from="1" to="#arrayLen(FORMDATA.Kurlar)#"  index="fnc_i">
		<CFSET it=FormData.Kurlar[fnc_i]>
        <cfquery name="add_money_obj_bskt" datasource="#dsn3#">
			INSERT INTO PBS_OFFER_MONEY
			(
				ACTION_ID,
				MONEY_TYPE,
				RATE2,
				RATE1,
				IS_SELECTED
			)
			VALUES
			(
				#attributes.OFFER_ID#,
				'#it.MONEY#',
				#it.RATE2#,
				#it.RATE1#,
				<cfif it.MONEY EQ FORMDATA.AKTIF_KUR>
					1
				<cfelse>
					0
				</cfif>					
			)
		</cfquery>
	</cfloop>
</CFIF>
</cffunction>

<cffunction name="sendPurchaseOffer" access="remote" httpMethod="Post" returntype="any" returnFormat="json">

<cfargument name="formData">
<CFSET FORMDATAM=deserializeJSON(arguments.formData)>
<cfset attributes.OFFER_ID=FORMDATAM.OfferId>
<cfset FNMN=CreateUUID()>

<cfhtmltopdf pageType="A4"  destination="C:/W3/PROD/devcatalyst/MailPdf/#FNMN#.pdf" name="PDF_BURASU">
    <cfinclude template="/AddOns/YafSatis/Horizon/Pages/PdfDesign/PdfPrint.cfm">
</cfhtmltopdf>

<cfset MailService=createObject("component","AddOns.YafSatis.Partner.cfc.mailService")>

<cfscript>
    MailService.SendMail(MailBody=FORMDATAM.FHtml,FromMail="info@partnerbilgisayar.com",ToMailList="#FORMDATAM.MailTOList#",ToCCMailList="#FORMDATAM.CClist#",ToBCCMailList="#FORMDATAM.BCClist#",fffile="#FNMN#.pdf",ffftype="application/pdf",fffcontent="#PDF_BURASU#",subject="Deneme Mailidir")
</cfscript>
<!--------
        <cffunction name="SendMail" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="MailBody" required="true">
        <cfargument name="FromMail" required="true">
        <cfargument name="ToMailList" required="true">
        <cfargument name="ToCCMailList">
        <cfargument name="ToBCCMailList">        
        <cfargument name="fffile" default="">
        <cfargument name="ffftype">
        <cfargument name="fffcontent">
        <cfargument name="subject" required="true">
    -------------->

</cffunction>

<cffunction name="AddShipToFilter"  access="remote" httpMethod="Post" returntype="any" returnFormat="json">

<CFSET FORMDATA=deserializeJSON(arguments.data)>


<cftry>
    <cfquery name="INS" datasource="#DSN3#">
        DELETE FROM CatalystQA_1.SHIP_EQUIPMENTS_PBS WHERE SHIP_ID=#FORMDATA.WESSEL_ID# AND PRODUCT_CATID=#FORMDATA.PRODUCT_CAT_ID# AND SM_ID=#FORMDATA.SM_ID#
    </cfquery>    
<cfquery name="INS" datasource="#DSN3#">
    INSERT INTO CatalystQA_1.SHIP_EQUIPMENTS_PBS(SHIP_ID,PRODUCT_CATID,JSON_STRINGIM,SM_ID) VALUES (#FORMDATA.WESSEL_ID#,#FORMDATA.PRODUCT_CAT_ID#,'#serializeJSON(FORMDATA)#',#FORMDATA.SM_ID#)
</cfquery>
<cfset RO.STATUS=true>
    <cfset RO.Message="Başarılı">
    <cfreturn replace(serializeJSON(RO),"//","")>
<cfcatch>
    <cfset RO.STATUS=false>
    <cfset RO.Message=cfcatch.message>
    <cfdump var="#cfcatch#">
    <cfreturn replace(serializeJSON(RO),"//","")>
</cfcatch>
</cftry>

</cffunction>
<!----
    CREATE TABLE CatalystQA_1.SHIP_EQUIPMENTS_PBS(
    S_ID INT PRIMARY KEY IDENTITY(1,1),SHIP_ID INT,PRODUCT_CATID INT ,JSON_STRINGIM NVARCHAR(MAX)
);

    
    -------->
<cffunction name="getShipFilters" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
<cfargument name="SHIP_ID">
<cfargument name="PRODUCT_CATID">
<cfargument name="SM_ID" default="">

<cfquery name="getSh" datasource="#dsn3#">
    SELECT * FROM CatalystQA_1.SHIP_EQUIPMENTS_PBS WHERE SHIP_ID=#arguments.SHIP_ID# AND PRODUCT_CATID=#arguments.PRODUCT_CATID# 
    <cfif len(arguments.SM_ID)>
       AND SM_ID=#arguments.SM_ID#
    </cfif>
</cfquery>

<cfset ReturnData=structNew()>
<cfif getSh.recordcount>
    <cfset ReturnData.STATUS=1>
    <cfset ReturnData.RECORD_COUNT=getSh.recordCount>
    <CFSET ReturnData.JSON_STRINGIM=deserializeJSON(getSh.JSON_STRINGIM)>
<CFELSE>
    <cfset ReturnData.STATUS=0>
    <CFSET ReturnData.JSON_STRINGIM="">
    <cfset ReturnData.RECORD_COUNT=0>
</cfif>
<cfreturn replace(serializeJSON(ReturnData),"//","")>


</cffunction>

<cffunction name="VirtualOperations" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
<cfargument name="Data">
    <cfset FormData=deserializeJSON(arguments.Data)>



<cfif FormData.Tip eq 3>
<cfquery name="getVPData" datasource="#dsn3#">
    select * from CatalystQA_1.VIRTUAL_PRODUCTS_PBS
WHERE OFFER_ROW_REL='#FORMDATA.OFFER_ROW_REL#'
</cfquery>
<CFSET JSON_STRINGIM=deserializeJSON(getVPData.JSON_STRINGIM)>

<cfset ProductService=createObject("component","AddOns.YafSatis.Partner.cfc.ProductService_V1")>
    <cfset UrunKayit=ProductService.CreateProduct(PRODUCT_NAME='#getVPData.PRODUCT_NAME#',PRODUCT_CATID=JSON_STRINGIM.PRODUCT_CAT_ID,MANUFACT_CODE='#getVPData.PART_NUMBER#',PROPS='#replace(serializeJSON(JSON_STRINGIM.Filters),"//","")#',EXTRA_PROPS="[]")>
    <cfset UrunKayitO=deserializeJSON(UrunKayit)>
    <cfif UrunKayitO.STATUS eq 1>
        <cfquery name="UPDA" datasource="#DSN3#">
            UPDATE PBS_OFFER_ROW SET PRODUCT_ID=#UrunKayitO.PRODUCT_ID#,STOCK_ID=#UrunKayitO.STOCK_ID#,IS_VIRTUAL=0 WHERE UNIQUE_RELATION_ID='#FORMDATA.OFFER_ROW_REL#'
        </cfquery>
<cfset ReturnData.STATUS=1>
<cfset ReturnData.MESSAGE="Ürün Başarı İle Eklenmiştir">
<cfset ReturnData.ErrorMessage="">
<cfset ReturnData.PRODUCT_ID="#UrunKayitO.PRODUCT_ID#">
<cfset ReturnData.STOCK_ID="#UrunKayitO.STOCK_ID#">
<cfreturn replace(serializeJSON(ReturnData),"//","")>
    <cfelse>
        <cfset ReturnData=UrunKayitO>
        <cfreturn replace(serializeJSON(ReturnData),"//","")> 
    </cfif>

</cfif>


</cffunction>



<cffunction name="wrk_eval" returntype="string" output="false">
	<!--- loop inen donen satirlarda evaluatten kaynaklanan tirnak isareti sorununu cozer --->
	<cfargument name="gelen" required="no" type="string">
	<cfset wrk_sql_value = "#replaceNoCase(trim(evaluate("#gelen#")),"'","''","ALL")#">
	<cfreturn wrk_sql_value>
</cffunction>
<cffunction name="TLFormat" returntype="string" output="false">
    <!--- <cfargument name="money" type="numeric" required="true"> sorunlar duzelince alttaki yerine acilacak--->
    <cfargument name="money">
    <cfargument name="no_of_decimal" required="no" default="2">
    <cfargument name="is_round" type="boolean" required="no" default="true">
    <cfscript>
    /*
    notes :
        negatif sayıları algılar, para birimi degerleri icin istenen degeri istenen kadar virgulle geri dondurur,
        ondalikli kisim default olarak yuvarlanir, ancak istenirse is_round false edilerek ondalik kadar kisimdan 
        yuvarlama olmasizin kesilebilir.
    parameters :
        1) money:formatlı yazdırılacak sayı (int veya float)
        2) no_of_decimal:ondalikli hane sayisi (int)
        3) is_round:yuvarlama yapilsin mi (boolean)
    usage : 
        <cfinput type="text" name="total" value="#TLFormat(x)#" validate="float">
        veya
        <cfinput type="text" name="total" value="#TLFormat(-123123.89)#" validate="float">
    revisions :
        20031105 - Temizlendi, uç nokta kontrolleri eklendi
        20031107 - 9 Katrilyon üstü desteği eklendi
        20031209 - 3 haneden küçük sayılar için negatif sayı desteği eklendi
        20041201 - Kurus (decimal) duzeltmeleri yapildi.
        20041201 - Genel duzenleme, kurus duzeltmelerine uygun yuvarlama .
        OZDEN 20070316 - round sorunlarının duzeltilmesi 
    */
    /*if (not len(arguments.money)) return 0;*/
    if (not len(arguments.money)) return '';
    arguments.money = trim(arguments.money);
    if (arguments.money contains 'E') arguments.money = ReplaceNoCase(NumberFormat(arguments.money),',','','all');
    if (arguments.money contains '-'){
        negativeFlag = 1;
        arguments.money = ReplaceNoCase(arguments.money,'-','','all');}
    else negativeFlag = 0;
    if(not isnumeric(arguments.no_of_decimal)) arguments.no_of_decimal= 2;	
    nokta = Find('.', arguments.money);
    if (nokta)
        {
        if(arguments.is_round) /* 20050823 and arguments.no_of_decimal */ 
        {
            rounded_value = CreateObject("java", "java.math.BigDecimal");
            rounded_value.init(arguments.money);
            rounded_value = rounded_value.setScale(arguments.no_of_decimal, rounded_value.ROUND_HALF_UP);
            rounded_value = rounded_value.toString();
            if(rounded_value contains '.') /*10.00 degeri yerine 10 dondurmek icin*/
            {
                if(listlast(rounded_value,'.') eq 0)
                    rounded_value = listfirst(rounded_value,'.');
            }
            arguments.money = rounded_value;
            if (arguments.money contains 'E') 
            {
                first_value = listgetat(arguments.money,1,'E-');
                first_value = ReplaceNoCase(first_value,',','.');
                last_value = ReplaceNoCase(listgetat(arguments.money,2,'E-'),'0','','all');
                for(kk_float=1;kk_float lte last_value;kk_float=kk_float+1)
                {
                    zero_info = ReplaceNoCase(first_value,'.','');
                    first_value = '0.#zero_info#';
                }
                arguments.money = first_value;
                first_value = listgetat(arguments.money,1,'.');
                arguments.money = "#first_value#.#Left(listgetat(arguments.money,2,'.'),8)#";
                if(arguments.money lt 0.00000001) arguments.money = 0;
                if(Find('.', arguments.money))
                {
                    arguments.money = "#first_value#,#Left(listgetat(arguments.money,2,'.'),8)#";
                    return arguments.money;
                }
            }
        }
        if(arguments.money neq 0) nokta = Find('.', arguments.money);
        if(ceiling(arguments.money) neq arguments.money){
            tam = ceiling(arguments.money)-1;
            onda = Mid(arguments.money, nokta+1,arguments.no_of_decimal);
            if(len(onda) lt arguments.no_of_decimal)
                onda = onda & RepeatString(0,arguments.no_of_decimal-len(onda));
            }
        else{
            tam = arguments.money;
            onda = RepeatString(0,arguments.no_of_decimal);}
        }
    else{
        tam = arguments.money;
        onda = RepeatString(0,arguments.no_of_decimal);
        }
    textFormat='';
    t=0;
    if (len(tam) gt 3) 
        {
        for (k=len(tam); k; k=k-1)
            {
            t = t+1;
            if (not (t mod 3)) textFormat = '.' & mid(tam, k, 1) & textFormat; 
            else textFormat = mid(tam, k, 1) & textFormat;
            } 
        if (mid(textFormat, 1, 1) is '.') textFormat =  "#right(textFormat,len(textFormat)-1)#,#onda#";
        else textFormat =  "#textFormat#,#onda#";
        }
    else
        textFormat = "#tam#,#onda#";
        
    if (negativeFlag) textFormat =  "-#textFormat#";
    
    if (not arguments.no_of_decimal) 
        textFormat = ListFirst(textFormat,',');
    
    if(isdefined("moneyformat_style") and moneyformat_style eq 1)
        {
            textFormat = replace(textFormat,'.','*','all');
            textFormat = replace(textFormat,',','.','all');
            textFormat = replace(textFormat,'*',',','all');
        }
    return textFormat;
    </cfscript>
</cffunction>

</cfcomponent>

