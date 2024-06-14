<cfparam name="attributes.is_sale" default="1">
<style>
    body{
        background:white !important;
    }
</style>
<cfparam name="attributes.is_sub" default="0">
<cfif attributes.is_sub eq 0>
<div style="display:flex">
    <cfif isDefined("attributes.is_sale") and attributes.is_sale eq 1>
        <button onclick="window.location.href='/index.cfm?fuseaction=<cfoutput>#attributes.fuseaction#&offer_id=#attributes.offer_id#</cfoutput>&is_sub=1&ppp=pdf2'"class="ui-wrk-btn ui-wrk-btn-success">Müşteri Teklifi</button> 
        <button onclick="window.location.href='/index.cfm?fuseaction=<cfoutput>#attributes.fuseaction#&offer_id=#attributes.offer_id#</cfoutput>&is_sub=1&ppp=pdf3'"class="ui-wrk-btn ui-wrk-btn-success">Satış Order Confirmation</button> 
        <button onclick="window.location.href='/index.cfm?fuseaction=<cfoutput>#attributes.fuseaction#&offer_id=#attributes.offer_id#</cfoutput>&is_sub=1&ppp=pdf6'"class="ui-wrk-btn ui-wrk-btn-success">Proforma Fatura Gönderim</button> 
    <cfelse>
        <button onclick="window.location.href='/index.cfm?fuseaction=<cfoutput>#attributes.fuseaction#&offer_id=#attributes.offer_id#</cfoutput>&is_sale=1&is_sub=1&ppp=pdf1'" class="ui-wrk-btn ui-wrk-btn-success">İkmalci Fiyat Talebi</button> 
        <button onclick="window.location.href='/index.cfm?fuseaction=<cfoutput>#attributes.fuseaction#&offer_id=#attributes.offer_id#</cfoutput>&is_sale=1&is_sub=1&ppp=pdf4'"class="ui-wrk-btn ui-wrk-btn-success">Satınalma Order Confirmation</button> 
    </cfif>





</div>
<cfelse>
    <cfset OfferService = createObject("component","AddOns.YafSatis.Partner.cfc.OfferService")>

    <cfif isDefined("attributes.is_sale") and attributes.is_sale eq 1>
<cfset OfferList=OfferService.getOfferWithOfferId(attributes.OFFER_ID)>
<script>
    var OfferData=<cfoutput>#OfferList#</cfoutput>
</script>
<cfset Offer=deserializeJSON(OfferList)>
<cfset attributes.preview=1>
EMRE
    <cfinclude template="PdfDesign/#attributes.ppp#.cfm">


<cfelse>
    EMRE2
    <cfset OfferList=OfferService.getPurchaseOffer(attributes.OFFER_ID)>
    <script>
        var OfferData=<cfoutput>#OfferList#</cfoutput>
    </script>
    <cfset Offer=deserializeJSON(OfferList)>
    <cfset attributes.preview=1>
    <cfinclude template="PdfDesign/#attributes.ppp#.cfm">
</cfif>
</cfif>