<cfoutput>
<input type="hidden" name="OFFER_ID_00" id="OFFER_ID_00" value="#attributes.OFFER_ID#">
<input type="hidden" name="OLD_PROCESS_CAT_00" id="OLD_PROCESS_CAT_00" value="#attributes.OLD_PROCESS_CAT#">

</cfoutput>
<cf_box>
<div style="display:flex">
    <div style="width:50%">
        <button style="width:100%">
            CUSTOMER INQUIRY
        </button>
        <button style="width:100%">
            SUPPLIER INQUIRY
        </button>
       
    </div>
    <div style="width:50%">
        <button style="width:100%">
          CONFIRMED CUSTOMER INQUIRY
        </button>
        <button style="width:100%">
            CUSTOMER OFFER
        </button>
    </div>
    <button style="width:100%">
        ORDER PROCESS
    </button>
    <button style="width:100%">
        CANCEL WITHOUT ORDER
    </button>
    <button style="width:100%">
        CANCEL WITHOUT CHANGE
    </button>
</div>
</cf_box>