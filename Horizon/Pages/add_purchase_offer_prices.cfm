<cfset attributes.offer_id=32>
<CFSET OfferService=createObject("component","AddOns.YafSatis.Partner.cfc.OfferService")>

<cfset OfferData=OfferService.getPurchaseOffer(attributes.offer_id)>




