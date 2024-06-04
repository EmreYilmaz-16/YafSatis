<cfparam name="SendMail" default="0"> 
<cfparam name="attributes.preview" default="0"> 
<cfset OfferService = createObject("component","AddOns.YafSatis.Partner.cfc.OfferService")>
<cfset OfferList=OfferService.getOfferWithOfferId(attributes.OFFER_ID)>
<script>
    var OfferData=<cfoutput>#OfferList#</cfoutput>
</script>
<cfset Offer=deserializeJSON(OfferList)>


<cfif Offer.OFFER_STAGE eq 266>
    <cfinclude template="pdf1.cfm">    
<cfelseif Offer.OFFER_STAGE eq 262>
    <cfinclude template="pdf3.cfm">
</cfif>
