

            <cf_box title="NEW INQUIRY RECORD" scroll="1" collapsable="1" resize="1" popup_box="1">
                <div class="ui-form-list">
<form name="order_form">
    <input type="hidden" name="ACTIVECOMPANY" id="ACTIVECOMPANY" value="<cfoutput>#session.ep.company_id#</cfoutput>">
    <input type="hidden" name="SALES_EMP_ID" id="SALES_EMP_ID" value="<cfoutput>#session.ep.userid#</cfoutput>">
    <input type="hidden" name="SALES_EMP" id="SALES_EMP" value="<cfoutput>#session.ep.NAME# #session.ep.SURNAME#</cfoutput>">
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
                              <!----  <div class="input-group">
                                    <input type="hidden" name="Addconsumer_id" id="Addconsumer_id">
                                    <input type="hidden" name="Addcompany_id" id="Addcompany_id">
                                    <input type="text" name="Addcompany" id="Addcompany" onfocus="AutoComplete_Create('Addcompany','MEMBER_NAME,MEMBER_PARTNER_NAME','MEMBER_NAME,MEMBER_PARTNER_NAME','get_member_autocomplete','\'1,2\',0,0','COMPANY_ID,CONSUMER_ID','Addcompany_id,Addconsumer_id','','3','200');" autocomplete="off"><div id="company_div_2" name="company_div_2" class="completeListbox" autocomplete="on" style="width: 441px; max-height: 150px; overflow: auto; position: absolute; left: 20px; top: 209px; z-index: 159; display: none;"></div>
                                    <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('index.cfm?fuseaction=objects.popup_list_pars&field_name=order_form.Addcompany&field_comp_id=order_form.Addcompany_id&field_consumer=order_form.Addconsumer_id&select_list=7,8&keyword='+encodeURIComponent(document.order_form.Addcompany.value));"></span>
                                </div>----->
                                <div class="input-group">
									<input type="hidden" name="Addconsumer_id" id="Addconsumer_id" value="">
									<input type="hidden" name="Addcompany_id" id="Addcompany_id" value="1">
									<input type="hidden" name="Addmember_type" id="Addmember_type" value="partner">
									<input name="Addcompany" type="text" id="Addcompany" placeholder="Cari Hesap" onfocus="AutoComplete_Create('Addcompany','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','get_member_autocomplete','\'1,2\'','CONSUMER_ID,COMPANY_ID,MEMBER_TYPE','Addconsumer_id,Addcompany_id,Addmember_type','','3','250');" value="" autocomplete="off" style=""><div id="member_name_div_2" name="member_name_div_2" class="completeListbox" autocomplete="on" style="width: 399px; max-height: 150px; overflow: auto; position: absolute; left: 20px; top: 209px; z-index: 159; display: none;"></div>
									
									<span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('index.cfm?fuseaction=objects.popup_list_all_pars&field_consumer=order_form.Addconsumer_id&field_comp_id=order_form.Addcompany_id&field_member_name=order_form.Addcompany&field_type=order_form.Addmember_type&select_list=7,8&function_name=sayHi&keyword='+encodeURIComponent(document.order_form.Addcompany.value));"></span>
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
                                <input type="text" name="TW" id="TW">
                                
                            </div>
                        </div>
    
                        <div class="form-group col col-2 col-md-2 col-sm-2 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">CUSTOMER REF</label>
                                <input type="text" name="AddRefNo" id="AddRefNo">
                            </div>
                        </div>
                    </div>

                    <!--- 2.GRID --->
                    <div class="margin-top-10 col col-12 col-md-12 col-sm-12 col-xs-12" >
                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">DATE</label>
                                <div class="input-group">
                                    
                                        
                                        <input type="text" name="start_date"  value="<cfoutput>#dateFormat(now(),'dd/mm/yyyy')#</cfoutput>">
                                        <span class="input-group-addon"><cf_wrk_date_image date_field="start_date"></span>
                                    
                                </div>
                            </div>
                        </div>
    
                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">TRANSPORTATION</label>
                                <select name="SHIP_METHOD_ID" id="SHIP_METHOD_ID">
                                   
                                </select>
                            </div>
                        </div>
    
                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">INQUIRY STATUS</label>
                                <select name="PRIORITY" id="PRIORITY">
                                    
                                </select>
                            </div>
                        </div>

                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">VALIDITY</label>
                                <div class="input-group">
                                    <input type="text" name="validDay" id="validDay" onchange="setValidyDate(this.value)">                                    
                                    <span class="input-group-addon">DAYS</span>
                                    <input type="hidden" name="validtyDate" id="validtyDate">
                                </div>
                                <code id="vdV"></code>
                                <script>
                                    function setValidyDate(dv){
                                        var OfferDate=document.getElementById("start_date")
                                        var Gun=list_getat(OfferDate.value,1,"/")
                                        var Ay=list_getat(OfferDate.value,2,"/")
                                        var Yil=list_getat(OfferDate.value,3,"/")
                                        $.get("/AddOns/YafSatis/Partner/cfc/OfferService.cfc?method=TarihIslem&yil="+Yil+"&ay="+Ay+"&gun="+Gun+"&islem=1&DatePart=d&dValue="+dv).done(function(str){
                                            $("#validtyDate").val(str);
                                            $("#vdV").text(str);
                                        })                                       
                                    }
                                </script>
                            </div>
                        </div>
                    </div>

                    <!--- 3.GRID --->  
                    <div class="margin-top-10 col col-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">DELIVERY PLACE</label>
                                <select name="DELIVERY_PLACE" id="DELIVERY_PLACE" onchange="if(this.value =='2' || this.value=='3') $('#dpAddress').show();else $('#dpAddress').hide();">

                                </select>
                            </div>
                        </div>

                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12" id="dpAddress" style="display:none">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">DELIVERY ADDRESS</label>
                                <input type="text" name="DELIVERY_ADDRESS" id="DELIVERY_ADDRESS">
                            </div>
                        </div>
                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12" id="dpAddress" >
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">PAY METHOD</label>
                                <div class="input-group">
									
									<input type="hidden" name="card_paymethod_id" id="card_paymethod_id" value="">
									<input type="hidden" name="paymethod_id" id="paymethod_id" value="">
									<input type="text" name="paymethod" placeholder="Ödeme Yöntemi " id="paymethod" value="">
									<span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('index.cfm?fuseaction=objects.popup_paymethods&field_id=order_form.paymethod_id&field_name=order_form.paymethod&field_card_payment_id=order_form.card_paymethod_id&field_card_payment_name=order_form.paymethod');"></span>
									
								</div>
                            </div>
                        </div>
                    </div>
                    

                    <!--- 4.GRID --->  
                    <div class="margin-top-10 col col-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">DELIVERY DATE</label>
                                <div class="input-group">
                                    
                                        <cfsavecontent variable="message"><cf_get_lang dictionary_id='57477.hatalı veri'>:<cf_get_lang dictionary_id='57742.Tarih'>!</cfsavecontent>
                                        <input type="text" name="delivery_date"  id="delivery_date">
                                        <span class="input-group-addon"><cf_wrk_date_image date_field="delivery_date"></span>
                                    
                                </div>
                            </div>
                        </div>

                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">DELIVERY TIME</label>
                                <div class="input-group">
                                    <input type="text" name="DVTime" id="DVTime">
                                    <span class="input-group-addon">W/DAYS</span>
                                </div>
                            </div>
                        </div> 

                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">CURRENCY</label>
                                <select name="MONEY" id="MONEY" onchange="setMoney(this)">
                                    <option value="">Seçiniz</option>
                                </select>
                                <input type="hidden" name="rate1" id="rate1">
                                <input type="hidden" name="rate2" id="rate2">
                                <input type="hidden" name="selected_money" id="selected_money">
                            </div>
                        </div>

                        <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">CONDITION</label>
                                <select name="OFFER_CONDITION" id="OFFER_CONDITION">
                                    
                                </select>
                            </div>
                        </div>
                    </div>

                    <!--- 5.GRID --->  
                    <div class="margin-top-10 col col-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="form-group col col-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">INQUIRY NOTE</label>
                                <input type="text" name="OfferDetail" id="OfferDetail">
                            </div>
                        </div>
                    </div>

                    <!--- 6.GRID --->  
                    <div class="margin-top-10 col col-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="form-group col col-6 col-md-6 col-sm-6 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">INQUIRY INFORMATION - 1</label>
                                <input type="text" name="PROPERTY1" id="PROPERTY1">
                            </div>
                        </div>

                        <div class="form-group col col-6 col-md-6 col-sm-6 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">INQUIRY INFORMATION - 2</label>
                                <input type="text" name="PROPERTY2" id="PROPERTY2">
                            </div>
                        </div>
                    </div>

                    <!--- 7.GRID --->  
                    <div class="margin-top-10 margin-bottom-10 col col-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="form-group col col-6 col-md-6 col-sm-6 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">INQUIRY INFORMATION - 3</label>
                                <input type="text" name="PROPERTY3" id="PROPERTY3">
                            </div>
                        </div>

                        <div class="form-group col col-6 col-md-6 col-sm-6 col-xs-12">
                            <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
                                <label class="margin-bottom-5 bold font-sm">INQUIRY INFORMATION - 4</label>
                                <input type="text" name="PROPERTY4" id="PROPERTY4">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="ui-form-list-btn">
                    <a onclick="SaveOfferHeader()" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left"><i class="fa fa-check-square"></i>SAVE</a>
                    <a href="javascript:show_hide('popup_box_Add_New_Record');" class="ui-wrk-btn ui-wrk-btn-red ui-wrk-btn-addon-left"><i class="fa fa-close"></i>CLOSE</a>
                </div>
            </form>
            </cf_box>
        
        </div>
        
        <script src="/AddOns/YafSatis/Horizon/js/page2.js"></script>