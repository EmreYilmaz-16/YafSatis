<cfcomponent>
    <cfset dsn = application.systemParam.systemParam().dsn>
    <cffunction name="getShipCatalogs" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="SHIP_ID">
        <cfquery name="getAll" datasource="#dsn#_product">
            select * from CatalystQA_product.PRODUCT_CATALOG_PBS WHERE SHIP_ID=#arguments.SHIP_ID#
        </cfquery>

    </cffunction>
    
    <cffunction name="AddProductToCatalog"  access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="Data">
        <cfset FormData=deserializeJSON(arguments.data)>
        
<cfif len(FormData.ProductId)>
    <!------Ürünü Direk Kataloğa Koyacağız
        CREATE TABLE CatalystQA_product.PRODUCT_CATALOG_ROWS(
    CATALOG_ROW_ID INT PRIMARY KEY IDENTITY(1,1),
    CATALOG_ID INT,
    PRODUCT_ID INT,
    STOCK_ID INT,
    JSON_STRINGIM NVARCHAR(max)

)

        
        
        ----->
    <cftry>
    <cfquery name="ins" datasource="#dsn#_product">
        INSERT INTO PRODUCT_CATALOG_ROWS (CATALOG_ID,PRODUCT_ID,STOCK_ID,JSON_STRINGIM)
        VALUES (#FormData.CatalogId#,#FormData.ProductId#,#FormData.StockId#,'#replace(serializeJSON(FormData.JSON_STRINGIM.ReturnObject.Filters),"//","")#')
    </cfquery>
    <cfset ReturnData.STATUS=1>
    <cfset ReturnData.MESSAGE="Ürün Başarı İle Kataloğa Eklenmiştir">
    <cfset ReturnData.ErrorMessage="">
    <cfset ReturnData.PRODUCT_ID="#FormData.ProductId#">
    <cfset ReturnData.STOCK_ID="#FormData.StockId#">
    <cfreturn replace(serializeJSON(ReturnData),"//","")>
    <cfcatch>
        <cfset ReturnData.STATUS=0>
        <cfset ReturnData.MESSAGE="Ürün Kataloğa Eklenirken Bir Hata Oluştu">
        <cfset ReturnData.ErrorMessage=cfcatch.message>
        <cfset ReturnData.PRODUCT_ID="">
        <cfset ReturnData.STOCK_ID="">
        <cfreturn replace(serializeJSON(ReturnData),"//","")>
    </cfcatch>
</cftry>



<cfelse>
    <cfset ProductService=createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>
    <cfset UrunKayit=ProductService.CreateProduct(PRODUCT_NAME='#FormData.ProductName#',PRODUCT_CATID=FormData.JSON_STRINGIM.ReturnObject.PRODUCT_CAT_ID,MANUFACT_CODE='#FormData.ManufactCode#',PROPS='#replace(serializeJSON(FormData.JSON_STRINGIM.ReturnObject.Filters),"//","")#',EXTRA_PROPS="#replace(serializeJSON(FormData.ExtraPropArr),"//","")#")>
    <cfset UrunKayitO=deserializeJSON(UrunKayit)>
    <cfif UrunKayitO.STATUS eq 1>
        <cftry>
        <cfquery name="ins" datasource="#dsn#_product">
            INSERT INTO PRODUCT_CATALOG_ROWS (CATALOG_ID,PRODUCT_ID,STOCK_ID,JSON_STRINGIM)
            VALUES (#FormData.CatalogId#,#UrunKayitO.PRODUCT_ID#,#UrunKayitO.STOCK_ID#,'#replace(serializeJSON(FormData.JSON_STRINGIM.ReturnObject.Filters),"//","")#')
        </cfquery>
           <cfset ReturnData.STATUS=1>
           <cfset ReturnData.MESSAGE="Ürün Başarı İle Kataloğa Eklenmiştir">
           <cfset ReturnData.ErrorMessage="">
           <cfset ReturnData.PRODUCT_ID="#UrunKayitO.PRODUCT_ID#">
           <cfset ReturnData.STOCK_ID="#UrunKayitO.STOCK_ID#">
           <cfreturn replace(serializeJSON(ReturnData),"//","")>
        <cfcatch>
            <cfset ReturnData.STATUS=0>
            <cfset ReturnData.MESSAGE="Ürün Kataloğa Eklenirken Bir Hata Oluştu">
            <cfset ReturnData.ErrorMessage=cfcatch.message>
            <cfset ReturnData.PRODUCT_ID="">
            <cfset ReturnData.STOCK_ID="">
            
            <cfreturn replace(serializeJSON(ReturnData),"//","")>
            
        </cfcatch>
        
        </cftry>
    <cfelse>
        <cfset ReturnData=UrunKayitO>
        <cfreturn replace(serializeJSON(ReturnData),"//","")>
    </cfif>
    
  
</cfif>

    </cffunction>
</cfcomponent>