<cf_box title="Resimler" scroll="1" collapsable="1" resize="1" popup_box="1">
<cfparam name="attributes.PRODUCT_ID" default="84">
<cfquery name="getProductImages" datasource="#dsn1#">
    select * from CatalystQA_product.PRODUCT_IMAGES where PRODUCT_ID=#attributes.PRODUCT_ID# AND IMAGE_SIZE=0
</cfquery>

<cfoutput query="getProductImages">
    <div class="col col-1 col-md-1 col-sm-2 col-xs-3">
    <div class="ui-cards">
        <div class="ui-cards-img">
            <a data-magnify="gallery_#attributes.PRODUCT_ID#" 
   data-caption="#DETAIL#" 
   data-group=""
   href="/Documents/product/#listgetat(PATH,1,"_")#_b.#listgetat(listgetat(PATH,2,"_"),2,".")#">
  <img src="/Documents/product/#PATH#" alt="">
</a>
        </div>
        <div class="ui-cards-text">
            <h1>Resim #currentrow#</h1>
            
        </div>
    </div>
</div>

</cfoutput>

<script>
    $('[data-magnify=gallery_<cfoutput>#attributes.PRODUCT_ID#</cfoutput>]').magnify();
</script>
</cf_box>

