getCatProperties

<cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>

<cfset CatProperties=ProductService.getCatProperties(PRODUCT_CATID=attributes.PRODUCT_CATID)>


<cfdump var="#CatProperties#">