

<cf_box title="Vessel" scroll="1" collapsable="1" resize="1" popup_box="1">
   <form name="ShipForm">
    <div class="form-group">
        <label>
            Vessel Name
        </label>
        <input type="text" name="VESSEL_NAME" id="VESSEL_NAME">
    </div>
    <div style="display:flex">
        <div style="width:50%">
            <cf_box title="Customer Invoice Info">
                <div class="form-group" id="item-company_name">
                    <label>CUSTOMER INVOICE INFO  *</label>        
                        <div class="input-group">
                            <input type="hidden" name="company_id" id="company_id" value="">	
                            <input name="company_name" type="text" id="company_name" value="" onfocus="AutoComplete_Create('company_name','MEMBER_NAME,MEMBER_PARTNER_NAME','MEMBER_NAME,MEMBER_PARTNER_NAME','get_member_autocomplete','\'1\'','COMPANY_ID,PARTNER_CODE,MEMBER_TYPE,MEMBER_PARTNER_NAME,WORK_ADDRESS_DETAIL,COM_CITY','company_id,member_id,member_type,member_name,company_address,service_city_id,county_id','','3','150',true,'fill_saleszone()');" autocomplete="off">                
                            <input type="hidden" name="member_id" id="member_id" value="">
                            <input type="hidden" name="member_type" id="member_type" value="">
                            <input type="text" name="member_name" id="member_name" value="">
                            <span class="input-group-addon icon-ellipsis btnPointer" onclick="windowopen('index.cfm?fuseaction=objects.popup_list_all_pars&is_period_kontrol=0&field_partner=ShipForm.member_id&field_consumer=ShipForm.member_id&field_name=ShipForm.member_name&field_comp_id=ShipForm.company_id&field_comp_name=ShipForm.company_name&field_type=ShipForm.member_type&field_city=ShipForm.service_city_id&field_address=ShipForm.company_address&select_list=8,7&call_function=fill_saleszone()','list','popup_list_all_pars');" title="Başvuru Yapan Seç "></span>
                        </div>        
                </div>
            </cf_box>
        </div>
        <div style="width:50%">
            <cf_box title="Care Of Invoice Info"></cf_box>
        </div>
    </div>
    
    
 
    

</form>
</cf_box>
<cfabort>
<cf_box title="EDIT VESSEL" scroll="1" collapsable="1" resize="1" popup_box="1">
    <div class="ui-form-list padding-5">

        <div class="form-group col col-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 small border-bottom border-grey padding-bottom-15">
            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                <label class="margin-bottom-5 bold font-sm">VESSEL NAME</label>
                <input type="text">
            </div>
        </div>

        <div class="form-group col col-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 large margin-top-15">
            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                <label class="margin-bottom-5 bold font-sm">CUSTOMER INVOICE INFO</label>
                <input type="text">
            </div>
        </div>

        <div class="form-group col col-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 large margin-top-10">
            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                <label class="margin-bottom-5 bold font-sm">INVOICE ADDRESS</label>
                <textarea rows="4">

                </textarea>
            </div>
        </div>
        

        <div class="col col-12 col-md-12 col-sm-12 col-xs-12 border-bottom border-grey padding-bottom-15 margin-top-10">
            <div class="form-group col col-6 col-md-6 col-sm-6 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">TAX DEPARTMENT</label>
                    <input type="text">
                </div>
            </div>
            <div class="form-group col col-6 col-md-6 col-sm-6 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">TAX NO</label>
                    <input type="text">
                </div>
            </div>
        </div>

        <div class="form-group col col-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 small margin-top-15">
            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                <label class="margin-bottom-5 bold font-sm">CARE OF INVOICE INFORMATION</label>
                <input type="text">
            </div>
        </div>

        <div class="form-group col col-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 large margin-top-10">
            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                <label class="margin-bottom-5 bold font-sm">CARE OF INVOICE ADDRESS</label>
                <textarea rows="5">

                </textarea>
            </div>
        </div>

        <div class="col col-12 col-md-12 col-sm-12 col-xs-12 border-bottom border-grey padding-bottom-15 margin-top-10">
            <div class="form-group col col-6 col-md-6 col-sm-6 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">CARE OF TAX DEPARTMENT</label>
                    <input type="text">
                </div>
            </div>
            <div class="form-group col col-6 col-md-6 col-sm-6 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">CARE OF TAX NO</label>
                    <input type="text">
                </div>
            </div>
        </div>

        <div class="col col-12 col-md-12 col-sm-12 col-xs-12 margin-top-10">
            <div class="form-group col col-4 col-md-4 col-sm-4 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">CONTACT PERSON</label>
                    <input type="text">
                </div>
            </div>
            <div class="form-group col col-4 col-md-4 col-sm-4 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">SHIP PHONE</label>
                    <input type="text">
                </div>
            </div>

            <div class="form-group col col-4 col-md-4 col-sm-4 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">SHIP MAIL</label>
                    <input type="text">
                </div>
            </div>
        </div>

        <div class="col col-12 col-md-12 col-sm-12 col-xs-12 margin-top-10">
            <div class="form-group col col-4 col-md-4 col-sm-4 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">SHIP TYPE</label>
                    <select>
                        <option>TANKER</option>
                    </select>
                </div>
            </div>
            <div class="form-group col col-4 col-md-4 col-sm-4 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">SHIP NO</label>
                    <input type="text">
                </div>
            </div>

            <div class="form-group col col-4 col-md-4 col-sm-4 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">BUILD DATE</label>
                    <input type="text">
                </div>
            </div>
        </div>

        <div class="col col-12 col-md-12 col-sm-12 col-xs-12 margin-top-10">
            <div class="form-group col col-4 col-md-4 col-sm-4 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">IMO NUMBER</label>
                    <input type="text">
                </div>
            </div>
            <div class="form-group col col-4 col-md-4 col-sm-4 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">HULL NUMBER</label>
                    <input type="text">
                </div>
            </div>

            <div class="form-group col col-4 col-md-4 col-sm-4 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">SHIP YARD</label>
                    <input type="text">
                </div>
            </div>
        </div>

        <div class="col col-12 col-md-12 col-sm-12 col-xs-12 margin-top-10">
            <div class="form-group col col-4 col-md-4 col-sm-4 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">DWT</label>
                    <input type="text">
                </div>
            </div>
            <div class="form-group col col-4 col-md-4 col-sm-4 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">FLAG</label>
                    <input type="text">
                </div>
            </div>

            <div class="form-group col col-4 col-md-4 col-sm-4 col-xs-12">
                <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                    <label class="margin-bottom-5 bold font-sm">CLASS</label>
                    <input type="text">
                </div>
            </div>
        </div>

        <div class="form-group col col-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 large margin-top-10">
            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                <label class="margin-bottom-5 bold font-sm">REMARK</label>
                <textarea rows="5">

                </textarea>
            </div>
        </div>
        
    </div>
    <div class="ui-form-list-btn">
        
        
        <a href="index.cfm?fuseaction=test_projects.equipment_new" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left">SAVE</a>
        <a href="javascript:show_hide('popup_box_email');" class="ui-wrk-btn ui-wrk-btn-red ui-wrk-btn-addon-left">CLOSE</a>
    </div>
</cf_box>
