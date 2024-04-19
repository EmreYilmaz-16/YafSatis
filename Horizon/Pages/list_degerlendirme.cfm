
<CFSET OfferService=createObject("component","AddOns.YafSatis.Partner.cfc.OfferService")>

<cfset _OfferData=OfferService.listPurchaseOffers()>
<cfset OfferData=deserializeJSON(_OfferData)>
<cf_box>
    <cfoutput>
<cfloop array="#OfferData#"  item="it">
    <cf_grid_list>
        <thead>
<tr>
    <td style="color:red;font-weight:bold">
        #it.OFFER_NUMBER#
    </td>
    <td style="color:red;font-weight:bold">
        #it.COMPANY_FULLNAME#
    </td>
    <td style="color:red;font-weight:bold">
        #it.OFFER_DATE#
    </td>
    <td style="color:red;font-weight:bold"> 
        #it.DELIVER_DATE#
    </td>
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
                </tr>
            </cfloop>
        </cf_grid_list>
    </td>
</tr>
</cf_grid_list>
</cfloop>

</cfoutput>


</cf_box>