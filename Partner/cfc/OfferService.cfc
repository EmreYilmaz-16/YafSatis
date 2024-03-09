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
    <cfdump var="#FormData#">
    <cfinclude template="../Query/SaveOffer.cfm">

</cffunction>

</cfcomponent>

