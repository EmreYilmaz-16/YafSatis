

<cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>

<cfset getWesselProducts=ProductService.getWesselProducts(attributes.WesselId)>
<cfset WesselProducts=deserializeJSON(getWesselProducts)>
<cf_box title="Ürünler">
<cfdump var="#WesselProducts#">


</cf_box>