<style>
    .OsButton{
        width: 100%;
    height: 70px;    
    font-weight: bold;
    font-size: 16pt !important;
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
   <cfparam name="attributes.OFFER_CURRENCY_ID" default="1">
   <cfquery name="getStages" datasource="#dsn#">
      select PROCESS_ROW_ID,STAGE,DETAIL,CASE WHEN DETAIL ='1' THEN 'FOR CUTOMER' ELSE 'FOR YAF STOCK' END AS 'INQUIRY REASON' 
      from CatalystQA.PROCESS_TYPE_ROWS where PROCESS_ID=193 AND DETAIL NOT IN ('0','3') AND DETAIL='#attributes.OFFER_CURRENCY_ID#'
   </cfquery>
<input type="hidden" name="OFFER_ID_00" id="OFFER_ID_00" value="#attributes.OFFER_ID#">
<input type="hidden" name="OLD_PROCESS_CAT_00" id="OLD_PROCESS_CAT_00" value="#attributes.OLD_PROCESS_CAT#">
<input type="hidden" name="OFFER_CURRENCY_ID_00" id="OFFER_CURRENCY_ID_00" value="#attributes.OFFER_CURRENCY_ID#">
</cfoutput>
<cf_box>
<div style="display:flex;flex-wrap: wrap;">
    
      <cfoutput query="getStages" >
         <button class="OsButton OsButton-orange" onclick="SetSurec(#PROCESS_ROW_ID#,#attributes.OFFER_ID#,'#attributes.modal_id#')"  style="width:100%;position: relative;">
            #STAGE#
            <cfif attributes.OLD_PROCESS_CAT eq PROCESS_ROW_ID>
            <span class="fa fa-check-square" style="position: absolute;left: 10px;top: 45%;"></span>
         </cfif>
         </button>

      </cfoutput>
      
    
       
   
    
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
    function SetSurec(STAGE,OFFER_ID,MODAL_ID) {
        $.ajax({
         url:"/AddOns/YafSatis/Partner/cfc/OfferService.cfc?method=SetOfferStage&Stage="+STAGE+"&OfferId="+OFFER_ID,
         success:function (params) {
            closeBoxDraggable(MODAL_ID)
         }
        })
    }
</script>

