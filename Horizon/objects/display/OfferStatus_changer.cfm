<style>
    .OsButton{
        width: 100%;
    height: 100px;    
    font-weight: bold;
    font-size: 20pt !important;
    border: none;        
    margin: 5px;
}
 .OsButton-orange{
    background: #ffbe0b;
    color: white;
 }
 .OsButton-orange:hover{
    background: #d6a00a;
    color: white;
 }
 .OsButton-blue{
    background: #3a86ff;
    color: white;
 }
 .OsButton-blue:hover{
    background: #3373da;
    color: white;
 }
 .OsButton-lblue{
    background: #00b4d8;
    color: white;
 }
 .OsButton-lblue:hover{
    background: #039ebd;
    color: white;
 }

 .OsButton-green{
    background: #6a994e;
    color: white;
 }
 .OsButton-green:hover{
    background: #4d7039;
    color: white;
 }
 .OsButton-dark{
    background: #063173;
    color: #ffbe0b;
 }
 .OsButton-dark:hover{
    background: #042350;
    color: #ffbe0b;
 }
 .OsButton-light{
    background: #e9ecef;
    color: #000814;
 }
 .OsButton-light:hover{
    background: #b9bcbe;
    color: #000814;
 }
 .OsButton-red{
    background: #ef233c;
    color: white;
 }
 .OsButton-red:hover{
    background: #bd1b2e;
    color: white;
 }
 
</style>

<cfoutput>
   <cfparam name="OFFER_CURRENCY_ID_00" default="1">
<input type="hidden" name="OFFER_ID_00" id="OFFER_ID_00" value="#attributes.OFFER_ID#">
<input type="hidden" name="OLD_PROCESS_CAT_00" id="OLD_PROCESS_CAT_00" value="#attributes.OLD_PROCESS_CAT#">
<input type="hidden" name="OFFER_CURRENCY_ID_00" id="OFFER_CURRENCY_ID_00" value="#attributes.OFFER_CURRENCY_ID#">
</cfoutput>
<cf_box>
<div style="display:flex;flex-wrap: wrap;">
    <div style="width:50%;padding:5px">
        <button class="OsButton OsButton-orange" onchange="SetSurec(<cfif attributes.OFFER_CURRENCY_ID eq 1>261<cfelse>266</cfif>)"  style="width:100%">
            CUSTOMER INQUIRY
        </button>
        <button class="OsButton OsButton-green" onchange="SetSurec(<cfif attributes.OFFER_CURRENCY_ID eq 1>262<cfelse>267</cfif>)"  style="width:100%">
            SUPPLIER INQUIRY
        </button>
       
    </div>
    <div style="width:50%;padding:5px">
        <button  class="OsButton OsButton-lblue" onchange="SetSurec(<cfif attributes.OFFER_CURRENCY_ID eq 1>263<cfelse>266</cfif>)" style="width:100%">
          CONFIRMED CUSTOMER INQUIRY
        </button>
        <button class="OsButton OsButton-blue" onchange="SetSurec(<cfif attributes.OFFER_CURRENCY_ID eq 1>261<cfelse>264</cfif>)" style="width:100%">
            CUSTOMER OFFER
        </button>
    </div>
    <button class="OsButton OsButton-dark"  style="width:100%">
        ORDER PROCESS
    </button>
    <button class="OsButton OsButton-red" style="width:100%">
        CANCEL WITHOUT ORDER
    </button>
    <button class="OsButton OsButton-light" onclick="closeBoxDraggable('<cfoutput>#attributes.modal_id#</cfoutput>')" style="width:100%">
        CANCEL WITHOUT CHANGE
    </button>
</div>
</cf_box>

<script>
    function SetSurec(STAGE) {
        
    }
</script>

