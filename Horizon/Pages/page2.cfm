
            <cf_box title="NEW INQUIRY RECORD" scroll="1" collapsable="1" resize="1" popup_box="1">
                <div class="ui-form-list">
<form name="order_form">
                    <!--- 1.GRID --->
                    <div class="margintop-5 col col-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">INQUIRY REASON</label>
                                <select  id="OFFER_CURRENCY" name="OFFER_CURRENCY">
                                    
                                </select>
                            </div>
                        </div>
    
                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">CUSTOMER NAME</label>
                                <div class="input-group">
                                    <input type="hidden" name="Addconsumer_id" id="Addconsumer_id">
                                    <input type="hidden" name="Addcompany_id" id="Addcompany_id">
                                    <input type="text" name="Addcompany" id="Addcompany" onfocus="AutoComplete_Create('Addcompany','MEMBER_NAME,MEMBER_PARTNER_NAME','MEMBER_NAME,MEMBER_PARTNER_NAME','get_member_autocomplete','\'1,2\',0,0','COMPANY_ID,CONSUMER_ID','Addcompany_id,Addconsumer_id','','3','200');" autocomplete="off"><div id="company_div_2" name="company_div_2" class="completeListbox" autocomplete="on" style="width: 441px; max-height: 150px; overflow: auto; position: absolute; left: 20px; top: 209px; z-index: 159; display: none;"></div>
                                    <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('index.cfm?fuseaction=objects.popup_list_pars&field_name=order_form.Addcompany&field_comp_id=order_form.Addcompany_id&field_consumer=order_form.Addconsumer_id&select_list=7,8&keyword='+encodeURIComponent(document.order_form.company.value));"></span>
                                </div>
                            </div>
                        </div>
    
                        <div class="form-group col col-2 col-md-2 col-sm-2 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">VESSEL NAME</label>
                                <div class="input-group">
                                    <input type="text" name="ship_name" id="ship_name">
                                    <input type="hidden" name="ship_id" id="ship_id">
                                    <span onclick="openShipList()" class="input-group-addon icon-ellipsis color-CR"></span>
                                </div>
                            </div>
                        </div>
    
                        <div class="form-group col col-2 col-md-2 col-sm-2 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">TRANSIT WAREHOUESE (EXW)</label>
                                <input type="text">
                            </div>
                        </div>
    
                        <div class="form-group col col-2 col-md-2 col-sm-2 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">CUSTOMER REF</label>
                                <input type="text">
                            </div>
                        </div>
                    </div>

                    <!--- 2.GRID --->
                    <div class="margin-top-10 col col-12 col-md-12 col-sm-12 col-xs-12" >
                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">DATE</label>
                                <div class="input-group">
                                    <input type="text">
                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                </div>
                            </div>
                        </div>
    
                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">TRANSPORTATION</label>
                                <select>
                                    <option>Option 1</option>
                                    <option>Option 2</option>
                                    <option>Option 3</option>
                                </select>
                            </div>
                        </div>
    
                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">INQUIRY STATUS</label>
                                <select>
                                    <option>Option 1</option>
                                    <option>Option 2</option>
                                    <option>Option 3</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">VALIDATY</label>
                                <div class="input-group">
                                    <input type="text">
                                    <span class="input-group-addon">DAYS</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--- 3.GRID --->  
                    <div class="margin-top-10 col col-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">DELIVERY PLACE</label>
                                <input type="text">
                            </div>
                        </div>

                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">DELIVERY ADDRESS</label>
                                <input type="text">
                            </div>
                        </div>
                    </div>

                    <!--- 4.GRID --->  
                    <div class="margin-top-10 col col-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">DELIVERY DATE</label>
                                <div class="input-group">
                                    <input type="text">
                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                </div>
                            </div>
                        </div>

                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">DELIVERY TIME</label>
                                <div class="input-group">
                                    <input type="text">
                                    <span class="input-group-addon">W/DAYS</span>
                                </div>
                            </div>
                        </div> 

                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">CURRENCY</label>
                                <select>
                                    <option selected>EU</option>
                                    <option>Option 2</option>
                                    <option>Option 3</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">CONDITION</label>
                                <select>
                                    <option selected>OEM</option>
                                    <option>Option 2</option>
                                    <option>Option 3</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!--- 5.GRID --->  
                    <div class="margin-top-10 col col-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">INQUIRY NOTE</label>
                                <input type="text">
                            </div>
                        </div>
                    </div>

                    <!--- 6.GRID --->  
                    <div class="margin-top-10 col col-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="form-group col col-6 col-md-6 col-sm-6 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">INQUIRY INFORMATION - 1</label>
                                <input type="text">
                            </div>
                        </div>

                        <div class="form-group col col-6 col-md-6 col-sm-6 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">INQUIRY INFORMATION - 2</label>
                                <input type="text">
                            </div>
                        </div>
                    </div>

                    <!--- 7.GRID --->  
                    <div class="margin-top-10 margin-bottom-10 col col-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="form-group col col-6 col-md-6 col-sm-6 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">INQUIRY INFORMATION - 3</label>
                                <input type="text">
                            </div>
                        </div>

                        <div class="form-group col col-6 col-md-6 col-sm-6 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">INQUIRY INFORMATION - 4</label>
                                <input type="text">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="ui-form-list-btn">
                    <a href="index.cfm?fuseaction=test_projects.equipment_new" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left"><i class="fa fa-check-square"></i>SAVE</a>
                    <a href="javascript:show_hide('popup_box_Add_New_Record');" class="ui-wrk-btn ui-wrk-btn-red ui-wrk-btn-addon-left"><i class="fa fa-close"></i>CLOSE</a>
                </div>
            </form>
            </cf_box>
        
        </div>
        
        <script src="/AddOns/YafSatis/Horizon/js/page2.js"></script>