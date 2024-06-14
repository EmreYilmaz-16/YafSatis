<cfparam name="attributes.START_ROW" default="1">
<cfparam name="attributes.Sayfa" default="1">
<input type="hidden" name="Sayfa" id="Sayfa" value="<cfoutput>#attributes.Sayfa#</cfoutput>">
<input type="hidden" name="START_ROW" id="START_ROW" value="<cfoutput>#attributes.START_ROW#</cfoutput>">

<cfset OfferService = createObject("component","AddOns.YafSatis.Partner.cfc.OfferService")>
<cfset Fdata=deserializeJSON(attributes.FormData)>
<cfset OfferList=arrayNew(1)>
<cfset OfferList=OfferService.getOfferList(SALES_EMP_ID:iif(len(Fdata.SalesPartnername),Fdata.SalesPartnerId,""),
OFFER_CURRENCY:Fdata.ForCustomer,
OFFER_STAGE:Fdata.Stage,
OFFER_NUMBER:Fdata.PaperNo,
REF_NO:Fdata.RefNo,
START_DATE:Fdata.StartDate,
FINISH_DATE:Fdata.FinishDate,
COMPANY_ID:Fdata.COMPANY_ID,
START_ROW:attributes.START_ROW,MAX_ROW:100)>
<cfset OfferData=deserializeJSON(OfferList)><!------>
<cfset OfferList=OfferData.OFFERS>


<!---
<cfargument name="SALES_EMP_ID" default="">
<cfargument name="OFFER_CURRENCY" default="">
<cfargument name="OFFER_STAGE" default="">
<cfargument name="OFFER_NUMBER" default="">
<cfargument name="REF_NO" default="">

<cfargument name="START_DATE" default="">
<cfargument name="FINISH_DATE" default="">
<cfargument name="START_ROW" default="1">
<cfargument name="MAX_ROW" default="20">---->
<cf_ajax_list>
    <thead>
        <tr>
            <th class="drag-enable">DATE<span class="table-handle"><i class="fa fa-sort"></i></span></th>
            <th class="drag-enable">CUST. REF<span class="table-handle"><i class="fa fa-sort"></i></span></th>
            <th class="drag-enable">CUSTOMER INFO<span class="table-handle"><i class="fa fa-sort"></i></span></th>
            <th class="drag-enable">DELIVERY ADDRESS<span class="table-handle"><i class="fa fa-sort"></i></span></th>
            <th class="drag-enable">TRANSPORTATION<span class="table-handle"><i class="fa fa-sort"></i></span></th>
            <th class="drag-enable">STAFF<span class="table-handle"><i class="fa fa-sort"></i></span></th>
            <th width="120"></th>
        </tr>
    </thead>
    <tbody id="OfferList">
        <cfoutput>
        <cfloop array="#OfferList#" item="it">
           <tr>
            <td>
                #it.OFFER_DATE#
            </td>
            <td>
                <a href="/index.cfm?fuseaction=sale.emptypopup_hrz_pbs_sayfa3&offer_id=#it.OFFER_ID#"><code style="color:red">#it.OFFER_NUMBER#</code>
                <br>#it.REF_NO#
            </a>
            </td>
            <td>
                #it.NICKNAME#
            </td>
            <td>
                #it.DELIVERY_ADDRESS# &gt;
                #it.DELIVERY_PLACE# 
            </td>
            
            <td>#it.SHIP_METHOD#</td>
            <td>#it.EMPLOYEE_NAME# #it.EMPLOYEE_SURNAME#</td>
        </tr>
        </cfloop>
    </cfoutput>
       
    </tbody>
</cf_ajax_list>
<div class="ui-pagination">
    <div class="pagi-left">
        <ul>
            <li><a href="javascript://" onclick="Sayfala(-1)"><i class="fa fa-angle-left"></i></a></li>            
            <li><a href="javascript://" onclick="Sayfala(1)"><i class="fa fa-angle-right"></i></a></li>            
        </ul>
    </div>
</div>
