
<cfset ShipService = createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>

<cfset _ShipTypes=ShipService.getShipTypes()>
<cfset ShipTypes=deserializeJSON(_ShipTypes)>

<cf_box title="Gemiler" scroll="1" collapsable="1" resize="1" popup_box="1">
<div>
  <form name="ship_Search_form">
<table style="width:100%">
  <tr>
    <td>
      <div class="form-group">
        <label class="bold"><strong>KEYWORD</strong></label> 
        <input type="text" name="ShipKV" id="ShipKv">
      </div>
    </td>
    <td>
      <div class="form-group">
        <label class="bold"><strong>CUSTOMER NAME</strong></label> 
        <div class="input-group">
            <input type="hidden" name="consumer_id" id="consumer_id" value="">
            <input type="hidden" name="company_id" id="company_id" value="">
            <input type="hidden" name="member_type" id="member_type" value="">
            <input name="member_name" type="text" id="member_name" placeholder="Current Account" onfocus="AutoComplete_Create('member_name','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','get_member_autocomplete','\'1,2\'','CONSUMER_ID,COMPANY_ID,MEMBER_TYPE','consumer_id,company_id,member_type','','3','250');" value="" autocomplete="off"><div id="member_name_div_2" name="member_name_div_2" class="completeListbox" autocomplete="on" style="width: 441px; max-height: 150px; overflow: auto; position: absolute; left: 20px; top: 209px; z-index: 159; display: none;"></div>                
            <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('index.cfm?fuseaction=objects.popup_list_all_pars&field_consumer=ship_Search_form.consumer_id&field_comp_id=ship_Search_form.company_id&field_member_name=ship_Search_form.member_name&field_type=ship_Search_form.member_type&select_list=7,8&keyword='+encodeURIComponent(document.ship_Search_form.member_name.value));"></span>
            
            

        </div>
        
    </div>
    </td>
    <td>
      <div class="form-group">
        <label class="bold"><strong>CARE OF CUSTOMER NAME</strong></label> 
        <div class="input-group">
            <input type="hidden" name="consumer_id_2" id="consumer_id_2" value="">
            <input type="hidden" name="company_id_2" id="company_id_2" value="">
            <input type="hidden" name="member_type_2" id="member_type_2" value="">
            <input name="member_name_2" type="text" id="member_name_2" placeholder="Current Account" onfocus="AutoComplete_Create('member_name_2','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','get_member_autocomplete','\'1,2\'','CONSUMER_ID,COMPANY_ID,MEMBER_TYPE','consumer_id_2,company_id_2,member_type_2','','3','250');" value="" autocomplete="off"><div id="member_name_div_2" name="member_name_div_2" class="completeListbox" autocomplete="on" style="width: 441px; max-height: 150px; overflow: auto; position: absolute; left: 20px; top: 209px; z-index: 159; display: none;"></div>                
            <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('index.cfm?fuseaction=objects.popup_list_all_pars&field_consumer=ship_Search_form.consumer_id_2&field_comp_id=ship_Search_form.company_id_2&field_member_name=ship_Search_form.member_name_2&field_type=ship_Search_form.member_type_2&select_list=7,8&keyword='+encodeURIComponent(document.ship_Search_form.member_name_2.value));"></span>
            
            

        </div>
        
    </div>
    </td>
    <td>
      <div class="form-group">
        <label class="bold"><strong>SHIP TYPE</strong></label> 
        <select name="ShipShipType" id="ShipShipType">
          <option value="">Seç</option>
          <cfoutput>
            <cfloop array="#ShipTypes#" item="it">
              <option value="#it.SHIP_TYPE_ID#">#it.SHIP_TYPE#</option>
            </cfloop>
          </cfoutput>
        </select>
      </div>
    </td>
    <td>
      <div class="form-group">
        <label>&nbsp;</label>
        <button type="button" onclick="getlist()">Liste Getir</button>
      </div>
    </td>
  </tr>
</table>
</form>
</div>

<div id="ListeAlani">

</div>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
    function getlist(params) {
   
      var KEYWORD=document.getElementById("ShipKv").value
      var SHIP_TYPE=document.getElementById("ShipShipType").value
      var consumer_id=document.getElementById("consumer_id").value
      var company_id=document.getElementById("company_id").value
      var member_type=document.getElementById("member_type").value
      var member_name=document.getElementById("member_name").value
      var CUSTOMER={
        consumer_id:consumer_id,
        company_id:company_id,
        member_type:member_type,
        member_name:member_name
      }
      var consumer_id=document.getElementById("consumer_id_2").value
      var company_id=document.getElementById("company_id_2").value
      var member_type=document.getElementById("member_type_2").value
      var member_name=document.getElementById("member_name_2").value
      var CARE_OF={
        consumer_id:consumer_id,
        company_id:company_id,
        member_type:member_type,
        member_name:member_name
      }
      
      var FormStr={
        KEYWORD:KEYWORD,
        SHIP_TYPE:SHIP_TYPE,
        CUSTOMER:CUSTOMER,
        CARE_OF:CARE_OF
      };
      var FormStr_=JSON.stringify(FormStr)
        AjaxPageLoad(
    "index.cfm?fuseaction=sales.emptypopup_list_vessels&FormData=" +
    FormStr_,
    "ListeAlani",
    1,
    "Yükleniyor"
  );

    }
</script>
</cf_box>