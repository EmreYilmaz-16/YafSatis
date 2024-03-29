<cf_box title="Vessel Detail" scroll="1" collapsable="1" resize="1" popup_box="1">
    <cfset ShipService = createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>
    <cfset ShipTypes_=ShipService.getShipTypes()>
    <cfset ShipList_=ShipService.GetShips(ShipId:attributes.ShipId)>
    <cfset ShipTypes=deserializeJSON(ShipTypes_)>
    <cfset ShipList=deserializeJSON(ShipList_)>
    <cfset GEMI=ShipList[1]>
    
    <cfoutput>
        <div>
            <cf_big_list>
                <tr>                    
                    <td colspan="3">
                        #GEMI.CUSTOMER_FULLNAME#
                    </td>
                    
                </tr>
                <tr style="text-align:center">
                    <td>
                        <b style="width:100%;display:block">Contact Person</b>
                        #GEMI.CUSTOMER_NAME# #GEMI.CUSTOMER_SURNAME#
                    </td>
                    <td>
                        <b style="width:100%;display:block">Ship Phone</b>
                        #GEMI.CUSTOMER_TELCODE# #GEMI.CUSTOMER_TEL#
                    </td>
                    <td>
                        <b style="width:100%;display:block">Ship Mail</b>
                        #GEMI.CUSTOMER_MAIL# 
                    </td>
                    
                </tr>
                <tr style="height: 60px;">
                    <td colspan="3" >
                        <b style="width:100%;display:block">Address</b>
                        #GEMI.CUSTOMER_ADRESS#
                    </td>
                </tr>
            </cf_big_list>
        </div>
        <div>
            <cfform name="ShipForm">
            <div class="form-group" id="item-company_name">
                <label>COMPANY</label>        
                    <div class="input-group">
                        <input type="hidden" name="company_id" id="company_id" value="">	
                        <input name="company_name" type="text" id="company_name" value="" onfocus="AutoComplete_Create('company_name','MEMBER_NAME,MEMBER_PARTNER_NAME','MEMBER_NAME,MEMBER_PARTNER_NAME','get_member_autocomplete','\'1\'','COMPANY_ID,PARTNER_CODE,MEMBER_TYPE,MEMBER_PARTNER_NAME,WORK_ADDRESS_DETAIL,COM_CITY','company_id,member_id,member_type,member_name,company_address,service_city_id,county_id','','3','150',true,'fill_saleszone()');" autocomplete="off">                
                        <input type="hidden" name="member_id" id="member_id" value="">
                        <input type="hidden" name="member_type" id="member_type" value="">
                        <input type="text" name="member_name" id="member_name" value="">
                        <span class="input-group-addon icon-ellipsis btnPointer" onclick="windowopen('index.cfm?fuseaction=objects.popup_list_all_pars&is_period_kontrol=0&field_partner=ShipForm.member_id&field_consumer=ShipForm.member_id&field_name=ShipForm.member_name&field_comp_id=ShipForm.company_id&field_comp_name=ShipForm.company_name&field_type=ShipForm.member_type&field_city=ShipForm.service_city_id&field_address=ShipForm.company_address&select_list=8,7&call_function=fill_saleszone()','list','popup_list_all_pars');" title="Başvuru Yapan Seç "></span>
                    </div>        
            </div>
            <div class="form-group" id="item-company_address">
                <label class="col col-4 col-sm-12">Adres </label>
                <div class="col col-8 col-sm-12">
                    
                    <textarea name="company_address" id="company_address" message="#message#" maxlength="200" onkeyup="return ismaxlength(this);" onblur="return ismaxlength(this);"></textarea>
                </div>                
        </div>
    </cfform>
        </div>
    
</cfoutput>