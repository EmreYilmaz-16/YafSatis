<cf_box title="Gemiler" scroll="1" collapsable="1" resize="1" popup_box="1">
<div>
<table>
  <tr>
    <td>
      <div class="form-group">
        <label class="bold"><strong>CUSTOMER NAME</strong></label> 
        <div class="input-group">
            <input type="hidden" name="consumer_id" id="consumer_id" value="">
            <input type="hidden" name="company_id" id="company_id" value="">
            <input type="hidden" name="member_type" id="member_type" value="">
            <input name="member_name" type="text" id="member_name" placeholder="Current Account" onfocus="AutoComplete_Create('member_name','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','get_member_autocomplete','\'1,2\'','CONSUMER_ID,COMPANY_ID,MEMBER_TYPE','consumer_id,company_id,member_type','','3','250');" value="" autocomplete="off"><div id="member_name_div_2" name="member_name_div_2" class="completeListbox" autocomplete="on" style="width: 441px; max-height: 150px; overflow: auto; position: absolute; left: 20px; top: 209px; z-index: 159; display: none;"></div>                
            <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('index.cfm?fuseaction=objects.popup_list_all_pars&field_consumer=order_Search_form.consumer_id&field_comp_id=order_Search_form.company_id&field_member_name=order_Search_form.member_name&field_type=order_Search_form.member_type&select_list=7,8&keyword='+encodeURIComponent(document.order_Search_form.member_name.value));"></span>
            
            

        </div>
        
    </div>
    </td>
    <td>
      <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
        <label class="bold"><strong>CARE OF CUSTOMER NAME</strong></label> 
        <div class="input-group">
            <input type="hidden" name="consumer_id_2" id="consumer_id_2" value="">
            <input type="hidden" name="company_id_2" id="company_id_2" value="">
            <input type="hidden" name="member_type_2" id="member_type_2" value="">
            <input name="member_name_2" type="text" id="member_name_2" placeholder="Current Account" onfocus="AutoComplete_Create('member_name_2','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','get_member_autocomplete','\'1,2\'','CONSUMER_ID,COMPANY_ID,MEMBER_TYPE','consumer_id_2,company_id_2,member_type_2','','3','250');" value="" autocomplete="off"><div id="member_name_div_2" name="member_name_div_2" class="completeListbox" autocomplete="on" style="width: 441px; max-height: 150px; overflow: auto; position: absolute; left: 20px; top: 209px; z-index: 159; display: none;"></div>                
            <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('index.cfm?fuseaction=objects.popup_list_all_pars&field_consumer=order_Search_form.consumer_id_2&field_comp_id=order_Search_form.company_id_2&field_member_name=order_Search_form.member_name_2&field_type=order_Search_form.member_type_2&select_list=7,8&keyword='+encodeURIComponent(document.order_Search_form.member_name_2.value));"></span>
            
            

        </div>
        
    </div>
    </td>
  </tr>
</table>
    <button onclick="getlist()">Liste Getir</button>
</div>

<div id="ListeAlani">

</div>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
    function getlist(params) {
      var FormStr="";
        AjaxPageLoad(
    "index.cfm?fuseaction=sales.emptypopup_list_vessels&FormData=" +
      FormStr,
    "ListeAlani",
    1,
    "Yükleniyor"
  );
    }
</script>
</cf_box>