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
		,PO.OFFER_HEAD
		,PO.OFFER_ID
		,PO.REF_NO AS OREF
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
                OFFER_CURRENCY=OFFCRRCNCY,
                OFFER_CURRENCY_ID=OCUUR,
                OFFER_STAGE=OFFER_STAGE,
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
    <cfset _FormData=deserializeJSON(arguments.FormData)>
    <cfdump var="#_FormData#">
<cfset form.active_company=1>

<CFSET attributes.to_comp_ids=",">
<CFSET attributes.to_par_ids=",">
<cfloop from="1" to="#arrayLen(_FormData)#" index="ix">
    <cfset Item=_FormData[ix]>
    <cfdump var="#Item#">
    <cfquery name="getCompanyInfo" datasource="#dsn#">
        SELECT * FROM COMPANY WHERE COMPANY_ID=#Item.COMPANY_ID#
    </cfquery>
    <cfdump var="#getCompanyInfo#">
    <CFSET attributes.to_comp_ids="#attributes.to_comp_ids#,#Item.COMPANY_ID#">
    <CFSET attributes.to_par_ids="#attributes.to_par_ids#,#getCompanyInfo.MANAGER_PARTNER_ID#">
</cfloop>
<cfdump var="#attributes#">
    
</cffunction>
<cffunction name="wrk_eval" returntype="string" output="false">
	<!--- loop inen donen satirlarda evaluatten kaynaklanan tirnak isareti sorununu cozer --->
	<cfargument name="gelen" required="no" type="string">
	<cfset wrk_sql_value = "#replaceNoCase(trim(evaluate("#gelen#")),"'","''","ALL")#">
	<cfreturn wrk_sql_value>
</cffunction>


</cfcomponent>

