<cfset ActiveCompany=FormData.ActiveCompany>
<cfset FORM.ACTIVE_COMPANY=ActiveCompany>
<cfset ATTRIBUTES.ACTIVE_COMPANY=ActiveCompany>
<CFSET DSN3=FormData.DataSources.DSN3>
<cfquery name="getOfferC" datasource="#dsn3#">
select count(*) AS RC from PBS_OFFER
</cfquery>
<cfif isDefined("FormData.ORDER_ID")>
<cfelse>
    <cfset FormData.ORDER_ID=0>
</cfif>


<cfset FormData.PAYMETHOD_ID=1> <!---//SOR ÖDEME YÖNTEMİ SEÇTİRELİM Mİ SEÇTİRECEKSEK BURADAKİ 1İ KALDIRIP FORMDAN GELEN VERİ OLACAK----->
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
<cfset attributes.partner_id=FormData.COMPANY_PARTNER_ID>



<cfset attributes.process_stage=FormData.OrderHeader.PROCESS_STAGE>
<cfset attributes.price=0>
<cfset attributes.paymethod_id=FormData.PAYMETHOD_ID>
<cfset attributes.PAYMETHOD=FormData.OrderHeader.PAYMETHOD>
<cfset attributes.ship_method_id=FormData.OrderHeader.SHIP_METHOD_ID>
<cfset attributes.ship_method=FormData.OrderHeader.SHIP_METHOD>
<cfset attributes.pay_method=FormData.OrderHeader.PAYMETHOD>
<cfset attributes.card_paymethod_id="">
<cfset attributes.ship_address=FormData.OrderHeader.SHIP_ADDRESS>
<cfset attributes.ship_address_id=FormData.OrderHeader.SHIP_ADDRESS_ID>
<cfset attributes.city_id=FormData.OrderHeader.CITY_ID>
<cfset attributes.county_id=FormData.OrderHeader.COUNTY_ID>
<cfset attributes.commission_rate="">

<cfset attributes.sales_add_option="">
<cfset attributes.offer_head=FormData.OrderHeader.OFFER_HEAD>
<cfset attributes.offer_detail="">
<cfset attributes.offer_detail="#FormData.OrderHeader.ISLEM_TIPI_PBS#">
<cfset attributes.basket_money=FormData.OrderFooter.BASKET_MONEY>
<cfset attributes.basket_rate1=FormData.OrderFooter.BASKET_RATE_1>
<cfset attributes.basket_rate2=FormData.OrderFooter.BASKET_RATE_2>
<cfset attributes.basket_net_total=FormData.OrderFooter.TOTAL_WITH_KDV>
<cfset attributes.basket_tax_total=FormData.OrderFooter.TAX_TOTAL>
<cfset attributes.ref_member_type ="">
<cfset attributes.consumer_id="">
<cfset attributes.reserved=1>
<cfset attributes.rows_=arrayLen(BasketRows)>