<cfparam name="attributes.PRODUCT_ID" default="84">
<cfquery name="getProductImages" datasource="#dsn1#">
    select * from CatalystQA_product.PRODUCT_IMAGES where PRODUCT_ID=#attributes.PRODUCT_ID# AND IMAGE_SIZE=0
</cfquery>

<cfoutput query="getProductImages">

<a data-magnify="gallery_#attributes.PRODUCT_ID#" 
   data-caption="#DETAIL#" 
   data-group=""
   href="/Documents/product/#listgetat(PATH,1,"_")#_b.#listgetat(listgetat(PATH,2,"_"),2,".")#">
  <img src="#PATH#" alt="">
</a>
</cfoutput>

<script>
    $('[data-magnify=gallery_<cfoutput>#attributes.PRODUCT_ID#</cfoutput>]').magnify();
</script>