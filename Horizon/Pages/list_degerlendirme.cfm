
<CFSET OfferService=createObject("component","AddOns.YafSatis.Partner.cfc.OfferService")>

<cfset _OfferData=OfferService.listPurchaseOffers()>
<cfset OfferData=deserializeJSON(_OfferData)>
<cf_grid_list>
    <cfoutput>
<cfloop array="#OfferData#"  item="it">
<tr>
    <td>
        #it.OFFER_NUMBER#
    </td>
    <td>
        #it.COMPANY_FULLNAME#
    </td>
    <td>
        #it.OFFER_DATE#
    </td>
    <td>
        #it.DELIVER_DATE#
    </td>
</tr>
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
</cfloop>

</cfoutput>
</cf_grid_list>
