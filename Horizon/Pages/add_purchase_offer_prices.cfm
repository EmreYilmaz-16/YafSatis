﻿<cfset attributes.offer_id=32>
<CFSET OfferService=createObject("component","AddOns.YafSatis.Partner.cfc.OfferService")>

<cfset _OfferData=OfferService.getPurchaseOffer(attributes.offer_id)>
<cfset OfferData=deserializeJSON(_OfferData)>
<cfset MoneyArr=deserializeJSON(OfferService.getOfferMoney())>


<cf_box title="DEAR #OfferData.NICKNAME# , YOU CAN CREATE AND SEND YOUR OFFER TO US"></cf_box>
       
    

<div style="display:flex">
    <div class="form-group">
        <label>DELIVER FEE</label>
        <select name="DELIVER_FEE">
            <option value="">Seç</option>
            <option value="1">Need Charge</option>
        </select>
    </div>
    <div class="form-group">
        <label>Tax Status</label>
        <select name="TAX_STATUS">
            <option value="">Seç</option>
            <option value="1">With Tax</option>
            <option value="1">Without Tax</option>
        </select>
    </div>
    <div class="form-group">
        <label>General Discount %</label>
        <input type="text" name="GENERAL_DISCOUNT">
    </div>    
    <div class="form-group">
        <label>Currency</label>
        <select name="MONEY">
            <option value="">Seç</option>
            <cfoutput>
                <cfloop from="1" to="#arrayLen(MoneyArr)#" index="ix">
                
                    <cfset item=MoneyArr[ix]>
                <option value="#item.MONEY#">#item.MONEY#</option>
                </cfloop>
            </cfoutput>
             </select>
    </div>
    <div class="form-group">
        <label>Delivery Times</label>
        <input type="text" name="DELIVERY_TIMES">
    </div> 
</div>
</cf_box>

<!---------->