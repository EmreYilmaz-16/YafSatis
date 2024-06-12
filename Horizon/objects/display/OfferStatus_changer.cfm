<style>
    .OsButton{
        width: 100%;
    height: 25px;    
    font-weight: bold;
    font-size: 10pt !important;
    border: none;        
    margin: 5px;
}
 .OsButton-orange{
    background: #ffbe0b;
    color:black;
 }
 .OsButton-orange:hover{
    background: #d6a00a;
    color:black;
 }
 .OsButton-blue{
    background: #3a86ff;
    color:black;
 }
 .OsButton-blue:hover{
    background: #3373da;
    color:black;
 }
 .OsButton-lblue{
    background: #00b4d8;
    color:black;
 }
 .OsButton-lblue:hover{
    background: #039ebd;
    color:black;
 }

 .OsButton-green{
    background: #6a994e;
    color:black;
 }
 .OsButton-green:hover{
    background: #4d7039;
    color:black;
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
    color:black;
 }
 .OsButton-red:hover{
    background: #bd1b2e;
    color:black;
 }
 
</style>

<cfoutput>
   <cfparam name="attributes.OFFER_CURRENCY_ID" default="1">
   <cfquery name="getStages" datasource="#dsn#">
      
      SELECT * FROM (
SELECT DISTINCT PTR.PROCESS_ROW_ID
	,PTR.STAGE_CODE
	,CatalystQA.CatalystQA.Get_Dynamic_Language(PTR.PROCESS_ROW_ID, 'tr', 'PROCESS_TYPE_ROWS', 'STAGE', NULL, NULL, STAGE) AS STAGE
	,PTR.LINE_NUMBER LINE_NUMBER
	,PTR.IS_DISPLAY
	,PTR.DISPLAY_FILE_NAME
    ,PTR.DETAIL
    ,CASE WHEN PTR.DETAIL ='1' THEN 'FOR CUTOMER' ELSE 'FOR YAF STOCK' END AS 'INQUIRY REASON' 
FROM CatalystQA. PROCESS_TYPE_ROWS PTR
	,CatalystQA.PROCESS_TYPE_ROWS_POSID PTRP
WHERE PTR.PROCESS_ROW_ID = PTRP.PROCESS_ROW_ID AND PTR.PROCESS_ID IN (193) AND PTRP.PRO_POSITION_ID IN (
		SELECT POSITION_ID
		FROM CatalystQA.EMPLOYEE_POSITIONS EP
		WHERE (EP.POSITION_CODE = #session.ep.POSITION_CODE#)
		) AND PTR.IS_EMPLOYEE = 0

UNION

SELECT DISTINCT PTR.PROCESS_ROW_ID
	,PTR.STAGE_CODE
	,CatalystQA.CatalystQA.Get_Dynamic_Language(PTR.PROCESS_ROW_ID, 'tr', 'PROCESS_TYPE_ROWS', 'STAGE', NULL, NULL, STAGE) AS STAGE
	,PTR.LINE_NUMBER LINE_NUMBER
	,PTR.IS_DISPLAY
	,PTR.DISPLAY_FILE_NAME
    ,PTR.DETAIL
    ,CASE WHEN PTR.DETAIL ='1' THEN 'FOR CUTOMER' ELSE 'FOR YAF STOCK' END AS 'INQUIRY REASON' 
FROM CatalystQA.PROCESS_TYPE_ROWS PTR
WHERE PTR.PROCESS_ID IN (193) AND PTR.IS_EMPLOYEE = 1

UNION

SELECT DISTINCT PTR.PROCESS_ROW_ID
	,PTR.STAGE_CODE
	,CatalystQA.CatalystQA.Get_Dynamic_Language(PTR.PROCESS_ROW_ID, 'tr', 'PROCESS_TYPE_ROWS', 'STAGE', NULL, NULL, STAGE) AS STAGE
	,PTR.LINE_NUMBER LINE_NUMBER
	,PTR.IS_DISPLAY
	,PTR.DISPLAY_FILE_NAME
    ,PTR.DETAIL
    ,CASE WHEN PTR.DETAIL ='1' THEN 'FOR CUTOMER' ELSE 'FOR YAF STOCK' END AS 'INQUIRY REASON' 
FROM CatalystQA.PROCESS_TYPE_ROWS PTR
	,CatalystQA.PROCESS_TYPE_ROWS_POSID PTRP
	,CatalystQA.PROCESS_TYPE_ROWS_WORKGRUOP PTRW
WHERE PTR.PROCESS_ID IN (193) AND PTRW.PROCESS_ROW_ID = PTR.PROCESS_ROW_ID AND PTRW.MAINWORKGROUP_ID IS NOT NULL AND PTRW.MAINWORKGROUP_ID = PTRP.WORKGROUP_ID AND PTRP.PRO_POSITION_ID IN (
		SELECT POSITION_ID
		FROM CatalystQA.EMPLOYEE_POSITIONS EP
		WHERE (EP.POSITION_CODE = #session.ep.POSITION_CODE#)
		)
) AS TF
WHERE 1=1  AND DETAIL NOT IN ('0','3') AND DETAIL='#attributes.OFFER_CURRENCY_ID#'
ORDER BY LINE_NUMBER
   </cfquery>
<input type="hidden" name="OFFER_ID_00" id="OFFER_ID_00" value="#attributes.OFFER_ID#">
<input type="hidden" name="OLD_PROCESS_CAT_00" id="OLD_PROCESS_CAT_00" value="#attributes.OLD_PROCESS_CAT#">
<input type="hidden" name="OFFER_CURRENCY_ID_00" id="OFFER_CURRENCY_ID_00" value="#attributes.OFFER_CURRENCY_ID#">
</cfoutput>
<span style="border-radius: 10px;background-color:white;padding: 5px 10px 15px 10px;max-width:33%" id="scrollList">
   
<div style="display:flex;flex-wrap: wrap;">
    
      <cfoutput query="getStages" >
         <button class="OsButton OsButton-orange" onclick="SetSurec(#PROCESS_ROW_ID#,#attributes.OFFER_ID#,'#attributes.modal_id#')"  style="width:100%;position: relative;">
            #STAGE#
            <cfif attributes.OLD_PROCESS_CAT eq PROCESS_ROW_ID>
            <span  class="fa fa-check-square" style="position: absolute;left: 10px;font-size:30pt"></span>
         </cfif>
         </button>

      </cfoutput>
      
    
       
   
    
    <button class="OsButton OsButton-dark" onclick="windowopen('/index.cfm?fuseaction=sales.list_order&event=add&PBS_OFFER_ID=<cfoutput>#attributes.OFFER_ID#</cfoutput>','wide')"  style="width:100%">
        ORDER PROCESS
    </button>
    <button class="OsButton OsButton-red" style="width:100%">
        CANCEL WITHOUT ORDER
    </button>
    <button class="OsButton OsButton-light" onclick="closeBoxDraggable('<cfoutput>#attributes.modal_id#</cfoutput>')" style="width:100%">
        CANCEL WITHOUT CHANGE
    </button>
</div>
</span>

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

