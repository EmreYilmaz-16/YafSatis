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
    background: #ffbe0b;
    color: white;
 }
 .OsButton-blue{
    background: #3a86ff;
    color: white;
 }
 .OsButton-lblue{
    background: #00b4d8;
    color: white;
 }
 .OsButton-lblue{
    background: #00b4d8;
    color: white;
 }
 .OsButton-green{
    background: #6a994e;
    color: white;
 }
 .OsButton-dark{
    background: #000814;
    color: #ffbe0b;
 }
 .OsButton-light{
    background: #e9ecef;
    color: #000814;
 }
 .OsButton-red{
    background: #ef233c;
    color: white;
 }
 
 
</style>
<cfoutput>
<input type="hidden" name="OFFER_ID_00" id="OFFER_ID_00" value="#attributes.OFFER_ID#">
<input type="hidden" name="OLD_PROCESS_CAT_00" id="OLD_PROCESS_CAT_00" value="#attributes.OLD_PROCESS_CAT#">

</cfoutput>
<cf_box>
<div style="display:flex;flex-wrap: wrap;">
    <div style="width:50%;padding:5px">
        <button class="OsButton OsButton-orange"  style="width:100%">
            CUSTOMER INQUIRY
        </button>
        <button class="OsButton OsButton-green"  style="width:100%">
            SUPPLIER INQUIRY
        </button>
       
    </div>
    <div style="width:50%;padding:5px">
        <button  class="OsButton OsButton-lblue" style="width:100%">
          CONFIRMED CUSTOMER INQUIRY
        </button>
        <button class="OsButton OsButton-blue" style="width:100%">
            CUSTOMER OFFER
        </button>
    </div>
    <button class="OsButton OsButton-dark"  style="width:100%">
        ORDER PROCESS
    </button>
    <button class="OsButton OsButton-red" style="width:100%">
        CANCEL WITHOUT ORDER
    </button>
    <button class="OsButton OsButton-light" style="width:100%">
        CANCEL WITHOUT CHANGE
    </button>
</div>
</cf_box>