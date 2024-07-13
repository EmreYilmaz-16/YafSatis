<cf_box title="Ürünler">
<cf_box_search>
    <cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&event=list_special" name="form1" id="form1" style="width:100%">
<div class="row">
    <div class="col col-2">
        <div class="form-group col col-12">
            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                <label class="margin-bottom-5 bold font-sm">EQUIPMENT</label>
                <div class="input-group">
                <select name="PRODUCT_CAT" id="PRODUCT_CAT" onchange="getCatProperties(this.value)">
                    
                </select>
            </div>
            </div>
        </div>
        
    </div>
    <div class="col col-9">
        <div id="PROP_AREA">

        </div>
    </div>
    <div class="col col-1">
        <label><input type="checkbox" name="is_excel" value="1">Excell Getir</label>
        <a id="BUTON_1" href="javascript://" onclick="AraBeni()" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left"><i class="fa fa-repeat"></i>Ara</a>
    </div>
</div>
<input type="hidden" name="FormData" id="FormData">
<input type="hidden" name="is_submit" id="is_submit">
</cfform>
</cf_box_search>
<cfif isDefined("attributes.is_submit")>
    

    <cfset ProductService = createObject("component","AddOns.YafSatis.Partner.cfc.ProductService")>
    <cfset ProductList_=ProductService.SearchProductPopup(FormData=attributes.FormData)>
    
    <cfset ProductList=deserializeJSON(ProductList_)>
    
</cfif>
<cf_big_list>
    <thead>
        <tr>
            <th>
                Part No
            </th>
            <th>
                Product Code
            </th>
            <th>
                Product Name
            </th>
        <cfif isDefined("attributes.is_submit")>
            <cfquery name="getpc" datasource="#dsn1#">
                SELECT PP.PROPERTY_ID,PP.PROPERTY FROM CatalystQA_product.PRODUCT_CAT_PROPERTY AS PCP 
LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PCP.PROPERTY_ID
where PRODUCT_CAT_ID=#attributes.PRODUCT_CAT#
            </cfquery>
<cfloop query="getpc">
    <th>
        <cfoutput>#PROPERTY#</cfoutput>
    </th>
</cfloop>
<cfloop array="#ProductList.OTHER_PROPERTIES#" item="it3">
    <th>
        <cfoutput>#it3.PROPERTY#</cfoutput>
    </th>
</cfloop>
<cfif isDefined("attributes.is_excel")>
    <cfscript>
        theSheet = SpreadsheetNew("Products");
        SatirSayaci=1;
        Sutun=1;
        spreadsheetSetCellValue(theSheet,"Part No",SatirSayaci,Sutun);
        Sutun=Sutun+1;
        spreadsheetSetCellValue(theSheet,"Product Code",SatirSayaci,Sutun);
        Sutun=Sutun+1;
        spreadsheetSetCellValue(theSheet,"Product Name",SatirSayaci,Sutun);
        Sutun=Sutun+1;
        for (i = 1; i <=getpc.recordCount ; i++) {
            spreadsheetSetCellValue(theSheet,"#getpc.PROPERTY[i]#",SatirSayaci,Sutun);
            Sutun=Sutun+1;
        }
        for (i = 1; i <=arrayLen(ProductList.OTHER_PROPERTIES) ; i++) {
            spreadsheetSetCellValue(theSheet,"#ProductList.OTHER_PROPERTIES[i].PROPERTY#",SatirSayaci,Sutun);
            Sutun=Sutun+1;
        }
        SatirSayaci=SatirSayaci+1;
    </cfscript>
</cfif>
</cfif>


        </tr>
    </thead>
    <tbody>
        <cfif isDefined("attributes.is_submit")>
        <cfloop array="#ProductList.PRODUCTS#" item="it">
            <tr>
                <td><cfoutput>#it.MANUFACT_CODE#</cfoutput></td>
                <td><cfoutput>#it.PRODUCT_CODE#</cfoutput></td>
                <td><cfoutput>#it.PRODUCT_NAME#</cfoutput></td>
                <cfif isDefined("attributes.is_excel")>
                    <cfscript>
                        Sutun=1;
                        spreadsheetSetCellValue(theSheet,"#it.MANUFACT_CODE#",SatirSayaci,Sutun);
                        Sutun=Sutun+1;
                        spreadsheetSetCellValue(theSheet,"#it.PRODUCT_CODE#",SatirSayaci,Sutun);
                        Sutun=Sutun+1;
                        spreadsheetSetCellValue(theSheet,"#it.PRODUCT_NAME#",SatirSayaci,Sutun);
                        Sutun=Sutun+1;
                    </cfscript>

                </cfif>
                <cfset PPLIST=deserializeJSON(it.DTP)>
                <cfloop query="getpc">
                    <td>
                        <cfset IIIS=arrayFilter(PPLIST,function(item){
                            return item.PROPERTY_ID==getpc.PROPERTY_ID
                        })>
                        <cfset STR_PRP="">
                        <cfloop array="#IIIS#" item="it2">
                        <cfoutput>#it2.PROPERTY_DETAIL#</cfoutput>
                            <CFSET STR_PRP="#STR_PRP# #it2.PROPERTY_DETAIL#"> 
                        </cfloop>
                        <cfif isDefined("attributes.is_excel")>
                            <cfscript> 
                                spreadsheetSetCellValue(theSheet,"#STR_PRP#",SatirSayaci,Sutun);
                                Sutun=Sutun+1;
                            </cfscript>

                        </cfif>
                    </td>
                </cfloop>
                <cfloop array="#ProductList.OTHER_PROPERTIES#" item="it3">
                    <td>
                        <cfquery name="getpp" datasource="#dsn1#">
                        
                            SELECT DISTINCT PP.PROPERTY,PPD.PROPERTY_DETAIL FROM CatalystQA_product.PRODUCT_DT_PROPERTIES PDP
                            LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL AS PPD ON PPD.PROPERTY_DETAIL_ID=PDP.VARIATION_ID
                            LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY AS PP ON PP.PROPERTY_ID=PDP.PROPERTY_ID
                            WHERE PDP.PROPERTY_ID  NOT IN (SELECT PROPERTY_ID FROM CatalystQA_product.PRODUCT_CAT_PROPERTY WHERE PRODUCT_CAT_ID=#it.PRODUCT_CATID#)
                        
    AND PRODUCT_ID=#it.PRODUCT_ID# AND PP.PROPERTY_ID=#it3.PROPERTY_ID#
                        </cfquery>
                        <cfoutput>#getpp.PROPERTY_DETAIL#</cfoutput>
                        
                    </td>
                    <cfif isDefined("attributes.is_excel")>
                        <cfscript> 
                            spreadsheetSetCellValue(theSheet,"#getpp.PROPERTY_DETAIL#",SatirSayaci,Sutun);
                            Sutun=Sutun+1;
                        </cfscript>
                    </cfif>
                </cfloop>
                <td>
                   
                    
                    
            </tr>
            <cfif isDefined("attributes.is_excel")>
                <cfset SatirSayaci=SatirSayaci+1>
            </cfif>
        </cfloop>
        <cfif isDefined("attributes.is_excel") and attributes.is_excel eq 1>
            <cfset file_name = "Ürünler#dateformat(now(),'ddmmyyyy')#.xls">
               <cfset drc_name_ = "#dateformat(now(),'yyyymmdd')#">
               <cfif not directoryexists("#upload_folder#reserve_files#dir_seperator##drc_name_#")>
               <cfdirectory action="create" directory="#upload_folder#reserve_files#dir_seperator##drc_name_#">
               </cfif>
           <cfspreadsheet action="write" filename="#upload_folder#reserve_files#dir_seperator##drc_name_#/#file_name#" name="theSheet"
               sheetname="Ürünler" overwrite=true>
           
              <script type="text/javascript">
               <cfoutput>
               get_wrk_message_div("Excel","Excel","documents/reserve_files/#drc_name_#/#file_name#");
               </cfoutput>
               </script>
           
           </cfif>
    </cfif>
    </tbody>

</cf_big_list>

</cf_box>

<script src="/AddOns/YafSatis/Horizon/js/list_product.js"></script>
