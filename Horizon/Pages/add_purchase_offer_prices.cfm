<cfset attributes.offer_id=32>
<CFSET OfferService=createObject("component","AddOns.YafSatis.Partner.cfc.OfferService")>

<cfset _OfferData=OfferService.getPurchaseOffer(attributes.offer_id)>
<!-----
<cfset OfferData=deserializeJSON(_OfferData)>
<cfdump var="#OfferData#">
<cfset MoneyArr=deserializeJSON(OfferService.getOfferMoney())>
<div>
    <div class="alert alert-warning">
        <cfoutput>#OfferData.NICKNAME#</cfoutput>
    </div>
</div>
<div class="display:flex">
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
                <cfloop array="#MoneyArr#" item="#it#">
                    <option value="#it.MONEY#">#it.MONEY#</option>
                </cfloop>
            </cfoutput>
        </select>
    </div>
    <div class="form-group">
        <label>Delivery Times</label>
        <input type="text" name="DELIVERY_TIMES">
    </div> 
</div>


----->