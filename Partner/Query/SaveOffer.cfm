<cfset ActiveCompany=FormData.ActiveCompany>
<cfset FORM.ACTIVE_COMPANY=ActiveCompany>
<cfset ATTRIBUTES.ACTIVE_COMPANY=ActiveCompany>
<CFSET DSN3=FormData.DATA_SOURCES.DSN3>
<cfquery name="getOfferC" datasource="#dsn3#">
select count(*) AS RC from PBS_OFFER
</cfquery>
<cfif isDefined("FormData.ORDER_ID")>
<cfelse>
    <cfset FormData.ORDER_ID=0>
</cfif>


<cfset FormData.PAYMETHOD_ID=1>     <!---//SOR ÖDEME YÖNTEMİ SEÇTİRELİM Mİ SEÇTİRECEKSEK BURADAKİ 1İ KALDIRIP FORMDAN GELEN VERİ OLACAK----->
<cfset FormData.PAYMETHOD="Nakit">  <!---//SOR ÖDEME YÖNTEMİ SEÇTİRELİM Mİ SEÇTİRECEKSEK BURADAKİ Metni KALDIRIP FORMDAN GELEN VERİ OLACAK----->
<cfset FormData.PROCESS_STAGE=260>  <!---//SOR SÜREÇ YÖNETİMİ NASIL OLACAK ŞUAN DEFAULT OLARAK KAYIT AŞAMASINDA OLACAK SAYFAYA SÜREÇ KOYALIM MI ---->
<CFSET FormData.CITY_ID=23>         <!--- //SOR WORKCUBE'ÜN STANDARTINDAKİ ADRESİN ŞEHRİ DEFAULT İSTANBUL GÖNDEREİYORUM NE YAPACAĞIZ ----->
<CFSET FormData.COUNTY_ID=1420>     <!--- //SOR WORKCUBE'ÜN STANDARTINDAKİ ADRESİN İLÇESİ DEFAULT TUZLA GÖNDEREİYORUM NE YAPACAĞIZ ----->
<!---- ---23 1420----->

<cfloop array="#FormData.KURLAR#" item="it" index="i">
    <cfset "attributes._hidden_rd_money_#i#"=it.MONEY>
    <cfset "attributes.hidden_rd_money_#i#"=it.MONEY>
    <cfset "attributes._txt_rate1_#i#"=it.RATE1>
    <cfset "attributes._txt_rate2_#i#"=it.RATE2>
    <cfset "attributes.txt_rate1_#i#"=it.RATE1>
    <cfset "attributes.txt_rate2_#i#"=it.RATE2>
    
</cfloop>
<cfset attributes.KUR_SAY=arrayLen(FormData.KURLAR)>

<cfset attributes.offer_id=FormData.ORDER_ID>
<cfset attributes.offer_date=FormData.OFFER_DATE>
<cfset attributes.deliverdate=FormData.DELIVERY_DATE>
<cfset attributes.ship_date=FormData.DELIVERY_DATE>
<cfset attributes.finishdate=FormData.VALID_DATE>
<cfset attributes.member_name=FormData.COMPANY_NAME>
<cfset attributes.OFFER_DESCRIPTION=FormData.OFFER_DETAIL>
<cfset attributes.company_id=FormData.COMPANY_ID>
<cfset attributes.partner_id=1> <!---//YAPILACAK TEKLİF EKRANINA GİZLİ ALAN OLARAK MÜŞTERİ YETKİLİ KONACAK---->



<cfset attributes.process_stage=FormData.PROCESS_STAGE>
<cfset attributes.price=0>
<cfset attributes.paymethod_id=FormData.PAYMETHOD_ID>
<cfset attributes.PAYMETHOD=FormData.PAYMETHOD>
<cfset attributes.ship_method_id=FormData.SHIP_METHOD_ID>
<cfset attributes.ship_method=FormData.SHIP_METHOD>
<cfset attributes.pay_method=FormData.PAYMETHOD>
<cfset attributes.card_paymethod_id="">
<cfset attributes.ship_address="Sevk Adresi">
<cfset attributes.ship_address_id=-1>
<cfset attributes.city_id=FormData.CITY_ID>
<cfset attributes.county_id=FormData.COUNTY_ID>
<cfset attributes.commission_rate="">

<cfset attributes.sales_add_option="">
<cfset attributes.offer_head="Teklifimiz">
<cfset attributes.offer_detail="">
<cfset attributes.offer_detail="#FormData.OFFER_DETAIL#">
<cfset attributes.basket_money=FormData.OFFER_MONEY>
<cfset attributes.basket_rate1=FormData.RATE1>
<cfset attributes.basket_rate2=FormData.RATE2>
<cfset attributes.basket_net_total=0>
<cfset attributes.basket_tax_total=0>
<cfset attributes.ref_member_type ="">
<cfset attributes.consumer_id="">
<cfset attributes.reserved=1>
<CFSET attributes.SALES_EMP_ID=FormData.SALES_EMP_ID>
<CFSET attributes.SALES_EMP =FormData.SALES_EMP>
<CFSET attributes.PROJECT_HEAD ="">
<CFSET attributes.WESSEL_ID=FormData.SHIP_ID>
<CFSET attributes.TRANSIT_WAREHOUSE=FormData.TRANSIT_WAREHOUSE>
<CFSET attributes.REF_NO=FormData.REF_NO>
<CFSET attributes.OFFER_CURRENCY=FormData.OFFER_CURRENCY>
<CFSET attributes.OFFER_CONDITION=FormData.OFFER_CONDITION>
<CFSET attributes.DELIVERY_PLACE=FormData.DELIVERY_PLACE>
<CFSET attributes.DELIVERY_ADDRESS=FormData.DELIVERY_ADDRESS>
<CFSET attributes.VALID_DAYS=FormData.VALID_DAYS>
<cfif not isDefined("FormData.SALES_EMP")>
    <cfquery name="EMP" datasource="#dsn#">
        SELECT EMPLOYEE_NAME,EMPLOYEE_SURNAME FROM EMPLOYEES WHERE EMPLOYEE_ID=#FormData.SALES_EMP_ID#
    </cfquery>
    <CFSET attributes.SALES_EMP="#EMP.EMPLOYEE_NAME# #EMP.EMPLOYEE_SURNAME#">
</cfif>
<cfset attributes.rows_="">
<cfif getOfferC.RC eq 0><cfset Num=1><cfelse>
    <cfset num=getOfferC.RC>
    <cfset Num=Num+1></cfif>
<cfset paper_fulbs="PBSTV-#Num#">
<cfif len(FormData.ORDER_ID) AND FormData.ORDER_ID NEQ 0>
<cfelse>    
    <cfquery name="get_offer_number" datasource="#dsn3#">
        EXEC GET_PAPER_NUMBER 1
    </cfquery>
    <cfset paper_fulbs=get_offer_number.PAPER_NO>
</cfif>
<cfinclude template="includes/add_offer.cfm">