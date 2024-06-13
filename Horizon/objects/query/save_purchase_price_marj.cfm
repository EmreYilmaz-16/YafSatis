<cfdump var="#attributes#">

<cfloop from="1" to="#attributes.ROW_COUNT#" index="i">
    <cfset WRK_ROW_ID=evaluate("attributes.WrkRowId_#i#")>
    <cfset SALE_PRICE=evaluate("attributes.SalePrice_#i#")>
    <cfset DISCOUNTED_PRICE=evaluate("attributes.DiscountedsPrice_#i#")>
    <cfset MARJA=evaluate("attributes.MARJUK_#i#")>
    <cfquery name="ins" datasource="#dsn3#">
        INSERT INTO FIYAT_ONERME_HISTORY_PBS (
            FIYAT_ONERME_ID,
	WRK_ROW_ID,
	OFFER_ID ,
	FOR_OFFER_ID ,
	SECEN_EMP,
	SECEN_DATE,
	MARJ_EMP,
	MARJ_DATE,
	MARJ_ORAN,
    SON_FIYAT
        )
        SELECT    ID AS   FIYAT_ONERME_ID,
        WRK_ROW_ID,
        OFFER_ID ,
        FOR_OFFER_ID ,
        SECEN_EMP,
        SECEN_DATE,
        MARJ_EMP,
        MARJ_DATE,
        MARJ_ORAN,
        SON_FIYAT FROM FIYAT_ONERME_PBS WHERE FOR_OFFER_ID=#attributes.offer_id# AND WRK_ROW_ID='#WRK_ROW_ID#'
    </cfquery>

   <cfquery name="UP" datasource="#DSN3#">
        UPDATE CatalystQA_1.FIYAT_ONERME_PBS SET MARJ_EMP=#session.ep.userid#,MARJ_DATE= GETDATE(),MARJ_ORAN=#MARJA#,SON_FIYAT=#filterNum(SALE_PRICE)# WHERE FOR_OFFER_ID=#attributes.offer_id# AND WRK_ROW_ID='#WRK_ROW_ID#'
    </cfquery>
  
   
    <cfif attributes.tip eq 2>
        <cfquery name="up2" datasource="#dsn3#">
            UPDATE PBS_OFFER_ROW SET PURCHASE_PRICE=#filterNum(DISCOUNTED_PRICE)# WHERE OFFER_ID =#attributes.offer_id# AND WRK_ROW_ID='#WRK_ROW_ID#'
        </cfquery>
    </cfif>

</cfloop>