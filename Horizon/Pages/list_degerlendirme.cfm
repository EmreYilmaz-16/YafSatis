
<CFSET OfferService=createObject("component","AddOns.YafSatis.Partner.cfc.OfferService")>

<cfset _OfferData=OfferService.listPurchaseOffers()>
<cfset OfferData=deserializeJSON(_OfferData)>
<cf_box>
    <cfoutput>
<cfloop array="#OfferData#"  item="it">
    <cf_grid_list>
        <thead>
            <tr>
                <th>
                    Teklif No
                </th>
                <th>
                    Müşteri
                </th>
                <th>
                    Teklif Tarihi
                </th>
                <th>
                    Teslim Tarihi
                </th>
                
            </tr>
<tr>
    <th style="color:red;font-weight:bold">
        <a href="##" onclick="windowopen('index.cfm?fuseaction=purchase.list_offer&event=spc&offer_id=#it.OFFER_ID#','wide')">#it.OFFER_NUMBER#</a>
    </th>
    <th style="color:red;font-weight:bold">
        #it.COMPANY_FULLNAME#
    </th>
    <th style="color:red;font-weight:bold">
        #it.OFFER_DATE#
    </th>
    <th style="color:red;font-weight:bold"> 
        #it.DELIVER_DATE#
    </th>
</tr>
</thead>
<tr>
    <td colspan="4">
        <cf_grid_list>
            <cfloop array="#it.REL_OFFERS#" item="it2">
                <tr>
                    <td>
                        #it2.OFFER_NUMBER#
                    </td>
                    <td>
                        #it2.COMPANY_FULLNAME#
                    </td>
                    <td>
                        #it2.OFFER_DATE#
                    </td>
                    <td>
                        #it2.DELIVER_DATE#
                    </td>
                    <td>
                        <div>
                        <a onclick="window.location.href='index.cfm?fuseaction=purchase.emptypopup_add_offer_price_pbs&offer_id=#it2.OFFER_ID#'"><span class="fa fa-plus"></span></a>
                        <a <!--------onclick="window.location.href='index.cfm?fuseaction=purchase.emptypopup_add_offer_price_pbs&offer_id=#it2.OFFER_ID#'"--------> onclick="openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_mailler_pbs&OFFER_ID=<cfoutput>#it2.OFFER_ID#</cfoutput>&is_sale=1')" ><i class="fa fa-envelope"></i></a>
                    </div></td>
                </tr>
            </cfloop>
        </cf_grid_list>
    </td>
</tr>
</cf_grid_list>
</cfloop>

</cfoutput>


</cf_box>