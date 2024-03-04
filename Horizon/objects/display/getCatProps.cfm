getCatProperties

<cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>

<cfset CatProperties=ProductService.getCatProperties(attributes.PRODUCT_CAT_ID)>


<cfdump var="#CatProperties#">