
<cfset OfferService = createObject("component","AddOns.YafSatis.Partner.cfc.OfferService")>
<cfset Fdata=deserializeJSON(attributes.FormData)>
<cfset OfferList=OfferService.getOfferList(SALES_EMP_ID=Fdata.SalesPartnerId,
OFFER_CURRENCY=Fdata.ForCustomer,
OFFER_STAGE.Fdata.Stage,
OFFER_NUMBER=Fdata.PaperNo,
REF_NO=Fdata.RefNo,
START_DATE=Fdata.StartDate,
FINISH_DATE=Fdata.FinishDate,
START_ROW=1,MAX_ROW=20)>
<cfset OfferList=deserializeJSON(OfferList)>
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
            <th width="120"></th>
        </tr>
    </thead>
    <tbody id="OfferList">
        <cfoutput>
        <cfloop array="#OfferList#" item="it">
            <td>
                #it.OFFER_DATE#
            </td>
            <td>
                #it.REF_NO#
            </td>
            <td>
                #it.NICKNAME#
            </td>
            <td>
                #it.DELIVERY_ADDRESS# =>
                #it.DELIVERY_PLACE# 
            </td>
            <td>#it.SHIP_METHOD#</td>
        </cfloop>
    </cfoutput>
       
    </tbody>
</cf_ajax_list>
<div class="ui-pagination">
    <div class="pagi-left">
        <ul>
            <li><a href="javascript://"><i class="fa fa-angle-left"></i></a></li>
            <li><a href="javascript://"><i class="fa fa-angle-left"></i></a></li>
            <li><a href="javascript://"><i class="fa fa-angle-right"></i></a></li>
            <li><a href="javascript://"><i class="fa fa-angle-double-right"></i></a></li>
            <!--<li><input type="text" value="1"><span>/ 1024</span></li>
            <li><a href="javascript://"><i class="fa fa-angle-right"></i></a></li>-->
            
            <li><a onclick="font_inc("unique_id", +1)" href="javascript://">A+</a></li>
            <!-- <li><a onclick="font_inc("unique_id", 0)" href="javascript://"><i class="fa fa-refresh"></i></a></li> -->
            <li><a onclick="font_inc("unique_id", -1)" href="javascript://">A-</a></li>
        </ul>
    </div>
</div>


