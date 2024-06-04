<cfcomponent>
    <cfset dsn = application.systemParam.systemParam().dsn>
    <cfset dsn3="#dsn#_1">

<cffunction name="SaveSaleOrder" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
    <cfargument name="OFFER_ID">
    <cfquery name="OFFER_HEADER" datasource="#dsn3#">
        SELECT * FROM CatalystQA_1.PBS_OFFER WHERE OFFER_ID=#arguments.OFFER_ID#
    </cfquery>

    <cfdump var="#arguments#">
    <cfquery name="getSepet" datasource="#dsn3#">
        SELECT * FROM PBS_OFFER_ROW WHERE OFFER_ID=#arguments.OFFER_ID#
    </cfquery>
    <cfif getSepet.recordcount>
    <CFSET session.EP.OUR_COMPANY_INFO.SPECT_TYPE =0>
    <cfset attributes.COMPANY_ID=OFFER_HEADER.COMPANY_ID>
    <cfset attributes.PARTNER_ID=OFFER_HEADER.PARTNER_ID>
    <!---
    <cfquery name="getCompKur" datasource="#dsn#">
        select MONEY,PAYMETHOD_ID,SHIP_METHOD_ID,PAYMENT_RATE_TYPE,PRICE_CAT,REVMETHOD_ID from #dsn#.COMPANY_CREDIT where COMPANY_ID=#arguments.company_id#            
    </cfquery>
    ---->
    <cfif len(day(now())) eq 1>
        <cfset gun="0#day(now())#">
    <cfelse>
        <cfset gun="#day(now())#">
    </cfif>
    <cfif len(month(now())) eq 1>
        <cfset ay="0#month(now())#">
    <cfelse>
        <cfset ay="#month(now())#">
    </cfif>     
    <cfset attributes.ship_method_id=OFFER_HEADER.SHIP_METHOD >
    <cfset attributes.paymethod_id = OFFER_HEADER.PAYMETHOD>
    <cfset attributes.deliver_dept_id = 2>
    <cfset attributes.deliver_loc_id = 1>
    <cfquery name="getPm" datasource="#dsn#">
    select DUE_DAY from #dsn#.SETUP_PAYMETHOD where PAYMETHOD_ID=#OFFER_HEADER.PAYMETHOD#
    </cfquery>
    <cfset attributes.basket_due_value_date_="#DateAdd("d", getPm.DUE_DAY, now())#">
    <cfset attributes.reserved=1>
    <cfquery name="getKur" datasource="#dsn#">
        SELECT RATE2 AS SATIS_KUR ,RATE3 AS ALIS_KUR ,RATE1,EFFECTIVE_SALE,EFFECTIVE_PUR,MONEY FROM SETUP_MONEY  WHERE CONVERT(DATE,UPDATE_DATE) >='#year(now())#-#ay#-#gun#' AND CONVERT(DATE,UPDATE_DATE) <='#year(now())#-#ay#-#gun#'
          UNION   
            SELECT 
            1 AS SATIS_KUR,
            1 AS RATE3,
            1 AS ALIS_KUR,
            1 AS EFFECTIVE_SALE,
            1 AS EFFECTIVE_PUR,
            'TL' AS  MONEY

    </cfquery>
    <cfquery name="getKU" dbtype="query">
        SELECT * FROM getKur WHERE MONEY='#OFFER_HEADER.OTHER_MONEY#'
    </cfquery>  
   
        <cfset Rate_21=getKU.SATIS_KUR>
           
    <cfloop query="getKur">
        <cfset "PRICEL.#MONEY#" = SATIS_KUR>
        <cfset "T_FIYAT.#MONEY#"=0>
        <cfset "attributes.hidden_rd_money_#currentrow#"="#MONEY#">
        <cfset "attributes.txt_rate1_#currentrow#"=RATE1>
        <cfset "attributes.txt_rate2_#currentrow#"=SATIS_KUR>
    </cfloop>
    <cfset attributes.basket_net_total=0>
    <cfset attributes.basket_discount_total=0>
    <cfset attributes.basket_money = OFFER_HEADER.OTHER_MONEY>
    <cfset attributes.STOCK_ID_LIST="">
    <cfset attributes.vergiii_toplam=0>
    <cfset attributes.indirim_toplammm=0>
    <cfset attributes.basket_gross_total=0>
    <cfset i=1>
    <cftry>
    <cfloop query="getSepet">
        <cfquery name="getK" dbtype="query">
            SELECT * FROM getKur WHERE MONEY='#OTHER_MONEY#'
        </cfquery>        
        <cfquery name="getStock" datasource="#dsn3#">
            select S.*,pu.MAIN_UNIT from #dsn#_1.STOCKS as s left join #dsn#_product.PRODUCT_UNIT as pu on pu.PRODUCT_ID=s.PRODUCT_ID WHERE S.PRODUCT_ID=#PRODUCT_ID#
        </cfquery>
        
        <cfset attributes.STOCK_ID_LIST = listAppend(attributes.STOCK_ID_LIST, getStock.STOCK_ID)>
       
            <cfset Rate_2=getK.SATIS_KUR>
        
        <cfset Rate_1=getK.RATE1>
            <cfset "attributes.price#i#"=getSepet.PRICE>
            <cfset "attributes.manufact_code#i#"=getStock.MANUFACT_CODE>
            <cfset kindirim1=getSepet.DISCOUNT_1>
            <cfset dprice=evaluate("attributes.price#i#")>
            <cfset "attributes.AMOUNT#i#"=getSepet.AMOUNT>
            <cfset "attributes.priceDisk#i#"=numberformat(dprice,"9.99")>
           
            <cfset "attributes.indirim_tutar#i#"=(evaluate("attributes.price#i#")-evaluate("attributes.priceDisk#i#"))*evaluate("attributes.amount#i#")>
            <cfset "attributes.row_nettotal#i#"=evaluate("attributes.priceDisk#i#")*evaluate("attributes.AMOUNT#i#")>
            <cfset "attributes.other_money_value_#i#" = numberformat(evaluate("attributes.row_nettotal#i#")/evaluate("PRICEL.#getSepet.OTHER_MONEY#"),"9.99")>
            <cfset "attributes.price_other#i#"=numberformat(getSepet.STD_PRICE,"9.99")>
            <cfset "attributes.tax#i#"=getStock.TAX>
            <cfif len(evaluate("attributes.tax#i#"))>
            <cfelse>
                <cfset "attributes.tax#i#"=0>
            </cfif>
            <cfset "attributes.vergiii#i#"=(evaluate("attributes.row_nettotal#i#")*evaluate("attributes.tax#i#"))/100>
            <cfset "attributes.unit#i#"="#getStock.MAIN_UNIT#">
            <cfset "attributes.indirim1#i#"=getSepet.DISCOUNT_RATE>
            <cfset "attributes.product_name_other#i#"=getSepet.ROW_DETAIL>
            <!----<cfset "attributes.row_nettotal#i#"=numberformat(evaluate("attributes.price#i#")-((evaluate("attributes.price#i#")*getSepet.DISCOUNT_RATE)/100),'9.99')*>numberformat(getSepet.AMOUNT*evaluate("PRICEL.#getSepet.OTHER_MONEY#")*getSepet.PRICE,'9.99')>---->
            <cfset "attributes.duedate#i#"=getPm.DUE_DAY>
             
              <cfset "attributes.reserve_type#i#"="-1">
              <cfset 'attributes.price_cat#i#'="#getCompKur.PRICE_CAT#">
            <cfset "attributes.order_currency#i#"="-1">
            <cfset "attributes.deliver_dept#i#"="26-3">
            <CFSET "attributes.lot_no#i#"=''>
            
            <cfset 'attributes.WRK_ROW_ID#i#' = "#round(rand()*65)##dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHmmssL')#1#round(rand()*100)#">
            <cfset "attributes.other_money_#i#" = getSepet.OTHER_MONEY>
            
            <cfset attributes.basket_net_total=attributes.basket_net_total+evaluate("attributes.row_nettotal#i#")>
            <cfset attributes.vergiii_toplam=attributes.vergiii_toplam+evaluate("attributes.vergiii#i#")>
            <cfset attributes.indirim_toplammm=attributes.indirim_toplammm+evaluate("attributes.indirim_tutar#i#")>
           <cfset attributes.basket_gross_total=attributes.basket_gross_total+evaluate("attributes.price#i#")*evaluate("attributes.AMOUNT#i#")>
            <!----<cfset attributes.basket_discount_total=numberformat(attributes.basket_discount_total+(((getSepet.STD_PRICE-getSepet.PRICE)*Rate_2)/Rate_1),"9.99")>
            <cfset  attributes.basket_net_total= numberformat(attributes.basket_net_total+(((getSepet.AMOUNT*getSepet.PRICE)*Rate_2)/Rate_1)-attributes.basket_discount_total,"9.99")>---->
            
            <cfset i=i+1>
    </cfloop>
    <cfcatch>
        <cfsavecontent  variable="control5">
            <cfoutput>
                <h3>#i#</h3>
            </cfoutput>
            <cfdump  var="#cfcatch#">
            <cfdump  var="#getCompKur#">
            <cfdump  var="#attributes#">
           
           </cfsavecontent>
           <cffile action="write" file = "c:\SiparisEkle.html" output="#control5#"></cffile>
           <cfabort>
    </cfcatch>

</cftry>
    <cfset attributes.basket_gross_total_doviz=numberformat(attributes.basket_gross_total/evaluate("PRICEL.#getCompKur.MONEY#"),"9.99")>
    
    <cfset attributes.indirim_toplam_doviz=numberformat(attributes.INDIRIM_TOPLAMMM/evaluate("PRICEL.#getCompKur.MONEY#"),"9.99")>
    <cfset attributes.basket_net_total_doviz=numberformat(attributes.BASKET_NET_TOTAL/evaluate("PRICEL.#getCompKur.MONEY#"),"9.99")>
    <cfset attributes.vergi_toplam_doviz=numberformat(attributes.VERGIII_TOPLAM/evaluate("PRICEL.#getCompKur.MONEY#"),"9.99")>
     <cfset attributes.basket_om= attributes.basket_gross_total_doviz+attributes.vergi_toplam_doviz-attributes.indirim_toplam_doviz>
    <cfset form.basket_gross_total=attributes.BASKET_GROSS_TOTAL>
    <cfset attributes.sales_add_option="2">
    <cfset form.basket_otv_total = 0>
    <cfif getCompKur.MONEY eq "TL">
        <cfset form.basket_discount_total=attributes.indirim_toplammm> <!---Toplam İndirim ---->
            <cfset form.basket_net_total=attributes.basket_net_total> <!---NET TOPLAM ---->
    <cfelse>
        <cfset form.basket_discount_total = 0>  <!---Toplam İndirim ---->
        <cfset form.basket_net_total=0>  <!---NET TOPLAM ---->
    </cfif>

          
            <cfset form.basket_money =getCompKur.MONEY >
            <cfset form.basket_rate1 = 1>
            <cfset form.basket_rate2 = evaluate("PRICEL.#getCompKur.MONEY#")>
            <cfset DSN_ALIAS =dsn>
            <cfset DSN3_ALIAS =dsn3>
            <cfset DSN1 ="#dsn#_product">
            <cfset attributes.kur_say=getKur.recordcount>
            <cfset attributes.kur_say=getKur.recordcount>
            <cfset DSN1_ALIAS ="#dsn#_product">
            <cfset attributes.order_employee="00">
            <cfset attributes.order_employee_id=1>
            <cfset attributes.detail=arguments.bilgi>
            <cfset specer =  CreateObject("component", "mmFunctions")>
            <cfset specer = specer.specer>  
            <cfset attributes.ROWS_=listLen(attributes.STOCK_ID_LIST)>
     
 <!----
    <cfif getCompKur.MONEY eq "TL">
        <cfset form.basket_net_total=0>
        <cfset form.basket_tax_total=0>
    <cfelse>
        <cfset form.basket_net_total=numberformat(attributes.basket_om*evaluate("PRICEL.#getCompKur.MONEY#"),"9.99")>
    </cfif>
      
  

    <cfset form.basket_tax_total=(attributes.BASKET_NET_TOTAL*18)/100>          
            
           
            <cfset form.basket_discount_total = 0>
            <cfset attributes.basket_net_total_kdvsiz=attributes.basket_net_total>
            <cfset attributes.basket_net_total=attributes.vergiii_toplam+attributes.basket_net_total>
            <cfset form.basket_net_total = attributes.BASKET_NET_TOTAL*1.18>
            <CFSET form.basket_gross_total = attributes.BASKET_NET_TOTAL>
            <cfset form.basket_discount_total = 0>
            ---->   
                                  <cfdump  var="#getSepet#">
        <cfdump  var="#attributes#">
        <cfdump  var="#T_FIYAT#">
        <cfdump  var="#PRICEL#">
 
                 <cftry>
                        <cfinclude  template="add_order_pda.cfm">   
                     <cfquery name="passiveeee" datasource="#dsn#">
                        UPDATE  COMPANY_SEPET_B2B SET IS_ACTIVE=0,W3_ORDER_ID=#GET_MAX_ORDER.MAX_ID# WHERE COMPANY_ID=#arguments.company_id# AND PARTNER_ID=#arguments.partner_id# and IS_ACTIVE=1
                     </cfquery>
                     <cfscript>
                        DONEN=structNew();
                        DONEN.SONUC=1;
                        DONEN.ORDER_ID=GET_MAX_ORDER.MAX_ID;
                        DONEN.ARGS=arguments;
                     </cfscript>
                     
                      <cfreturn Replace(SerializeJSON(DONEN),'//','')>     
                 <cfcatch type="exception">
                    <cfsavecontent  variable="control5">
                        <cfdump  var="#cfcatch#">
                       
                       </cfsavecontent>
                       <cffile action="write" file = "c:\WebSite\siparisekle.html" output="#control5#"></cffile>
                  <cfreturn Replace(SerializeJSON({sonuc:0}),'//','')>     
                 </cfcatch>
                 </cftry>
        </cfif>      
 <cfreturn Replace(SerializeJSON({sonuc:0,order_id=0}),'//','')>      

</cffunction>


</cfcomponent>