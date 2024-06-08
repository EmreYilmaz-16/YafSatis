
<cfset ShipService = createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>
<cfset ShipTypes_=ShipService.getShipTypes()>
<cfset ShipList_=ShipService.GetShips(ShipId:attributes.ShipId)>
<cfset ShipTypes=deserializeJSON(ShipTypes_)>
<cfset ShipList=deserializeJSON(ShipList_)>
<cfset GEMI=ShipList[1]>
<cf_box title="Vessel" scroll="1" collapsable="1" resize="1" popup_box="1" id="SV00001">
   <form name="ShipForm">
 <input type="hidden" name="SHIP_ID" id="SHIP_ID" value="<cfoutput>#attributes.ShipId#</cfoutput>">
    <div class="row">
        <div class="col col-9">
            <div class="form-group">
                <label>
                    Vessel Name
                </label>
                <input type="text" name="SHIP_NAME" id="SHIP_NAME" value="<cfoutput>#GEMI.SHIP_NAME#</cfoutput>">
            </div>            
            <div class="form-group">
                <label>
                    Ship Type
                </label>
                <select name="SHIP_TYPE" id="SHIP_TYPE">
                    <cfoutput>
                    <cfloop array="#ShipTypes#" item="it">
                        <option <CFIF GEMI.SHIP_TYPE_ID EQ it.SHIP_TYPE_ID>selected</CFIF> value="#it.SHIP_TYPE_ID#">#it.SHIP_TYPE#</option>
                    </cfloop>
                </cfoutput>
                </select>
            </div>
            <div class="form-group">
                <label>
                    Build Year
                </label>
                   
                <select name="BUILD_YEAR" id="BUILD_YEAR">
                    <option value="">Seç</option>
                    <cfoutput>
                    <cfloop from="1980" to="#year(now())#" index="i">
                        <option <cfif GEMI.BUILD_YEAR EQ i>selected</cfif> value="#i#">#i#</option>
                    </cfloop>
                </cfoutput>
                </select>
            </div> 
            <div class="form-group">
                <label>
                    IMO Number
                </label>
                <input type="text" name="IMO_NUMBER" id="IMO_NUMBER" value="<cfoutput>#GEMI.IMO_NUMBER#</cfoutput>">
            </div> 
            <div class="form-group">
                <label>
                    Hull Number
                </label>
                <input type="text" name="HULL_NUMBER" id="HULL_NUMBER" value="<cfoutput>#GEMI.HULL_NUMBER#</cfoutput>">
            </div>
            <div class="form-group">
                <label>
                    Ship Yard
                </label>
                <input type="text" name="SHIP_YARD" id="SHIP_YARD" value="<cfoutput>#GEMI.SHIP_YARD#</cfoutput>">
            </div>
            <div class="row">
                <div class="col col-3">
                    <div class="form-group">
                        <label>
                            Dead Weight Tonnage
                        </label>
                        <input type="text" name="DEAD_WEIGHT_TONNAGE" id="DEAD_WEIGHT_TONNAGE" value="<cfoutput>#GEMI.DEAD_WEIGHT_TONNAGE#</cfoutput>">
                    </div>
                </div>
                <div class="col col-3">
                    <div class="form-group">
                        <label>
                            Gross Tonnage
                        </label>
                        <input type="text" name="GROSS_TONNAGE" id="GROSS_TONNAGE" value="<cfoutput>#GEMI.GROSS_TONNAGE#</cfoutput>">
                    </div>
                </div>
                <div class="col col-3">
                    <div class="form-group">
                        <label>
                           Width
                        </label>
                        <input type="text" name="WIDTH" id="WIDTH" value="<cfoutput>#GEMI.WIDTH#</cfoutput>">
                    </div>
                </div>
                <div class="col col-3">
                    <div class="form-group">
                        <label>
                           Length
                        </label>
                        <input type="text" name="LENGTH" id="LENGTH" value="<cfoutput>#GEMI.LENGTH#</cfoutput>">
                    </div>
                </div>
                
            </div>
            <div class="row">
                <div class="col col-6">
                    <div class="form-group">
                        <label>
                           Flag
                        </label>
                        <input type="text" name="FLAG" id="FLAG" value="<cfoutput>#GEMI.FLAG#</cfoutput>">
                    </div>
                </div>
                <div class="col col-6">
                    <div class="form-group">
                        <label>
                           Class
                        </label>
                        <input type="text" name="CLASSF" id="CLASSF" value="<cfoutput>#GEMI.CLASS#</cfoutput>">
                    </div>
                </div>
            </div>                                   
        </div>
        
        <div class="col col-3">
            <cf_box title="Customer Invoice Info" id="SV00002" scroll="0" collapsable="0" resize="0" popup_box="0"> 
                <div class="form-group" id="item-company_name">
                    <label>COMPANY</label>        
                        <div class="input-group">
                            <input type="hidden" name="company_id" id="company_id"  readonly value="<cfoutput>#GEMI.CUSTOMER_COMPANY_ID#</cfoutput>">	
                            <input name="company_name" type="text" id="company_name" readonly value="<cfoutput>#GEMI.CUSTOMER_FULLNAME#</cfoutput>" onfocus="AutoComplete_Create('company_name','MEMBER_NAME,MEMBER_PARTNER_NAME','MEMBER_NAME,MEMBER_PARTNER_NAME','get_member_autocomplete','\'1\'','COMPANY_ID,PARTNER_CODE,MEMBER_TYPE,MEMBER_PARTNER_NAME,WORK_ADDRESS_DETAIL,COM_CITY','company_id,member_id,member_type,member_name,company_address,service_city_id,county_id','','3','150',true,'fill_saleszone()');" autocomplete="off">                
                            <input type="hidden" name="member_id" id="member_id" readonly value="<cfoutput>#GEMI.CUSTOMER_PARTNER_ID#</cfoutput>">
                            <input type="hidden" name="member_type" id="member_type" readonly value="1">
                            <input type="text" name="member_name" id="member_name" readonly value="<cfoutput>#GEMI.CUSTOMER_NAME# #GEMI.CUSTOMER_SURNAME#</cfoutput>">
                            <!----<span class="input-group-addon icon-ellipsis btnPointer" onclick="windowopen('index.cfm?fuseaction=objects.popup_list_all_pars&is_period_kontrol=0&field_partner=ShipForm.member_id&field_consumer=ShipForm.member_id&field_name=ShipForm.member_name&field_comp_id=ShipForm.company_id&field_comp_name=ShipForm.company_name&field_type=ShipForm.member_type&field_city=ShipForm.service_city_id&field_address=ShipForm.company_address&select_list=8,7&call_function=fill_saleszone()','list','popup_list_all_pars');" title="Başvuru Yapan Seç "></span>---->
                        </div>        
                </div>
                <div class="form-group" id="item-company_address">
                    <label>Adres </label>
                    
                        <textarea rows="5" name="company_address" readonly id="company_address" message="#message#" maxlength="200" onkeyup="return ismaxlength(this);" onblur="return ismaxlength(this);"><cfoutput>#GEMI.CUSTOMER_ADRESS#</cfoutput></textarea>
                                 
            </div>
            </cf_box>
            <cf_box title="Care Of Invoice Info" id="SV00003" scroll="0" collapsable="0" resize="0" popup_box="0">
                <div class="form-group" id="item-company_name">
                    <label>COMPANY</label>        
                        <div class="input-group">
                            <input type="hidden" name="company_id_1" id="company_id_1" value="<cfoutput>#GEMI.CARE_OF_COMPANY_ID#</cfoutput>">	
                            <input name="company_name_1" type="text" id="company_name_1" value="<cfoutput>#GEMI.CARE_OF_FULLNAME#</cfoutput>" onfocus="AutoComplete_Create('company_name_1','MEMBER_NAME,MEMBER_PARTNER_NAME','MEMBER_NAME,MEMBER_PARTNER_NAME','get_member_autocomplete','\'1\'','COMPANY_ID,PARTNER_CODE,MEMBER_TYPE,MEMBER_PARTNER_NAME,WORK_ADDRESS_DETAIL,COM_CITY','company_id_1,member_id_1,member_type_1,member_name_1,company_address_1,service_city_id_1,county_id_1','','3','150',true,'fill_saleszone()');" autocomplete="off">                
                            <input type="hidden" name="member_id_1" id="member_id_1" readonly value="<cfoutput>#GEMI.CARE_OF_PARTNER_ID#</cfoutput>">
                            <input type="hidden" name="member_type_1" id="member_type_1" readonly value="1">
                            <input type="text" name="member_name_1" id="member_name_1" readonly value="<cfoutput>#GEMI.CARE_OF_NAME# #GEMI.CARE_OF_SURNAME#</cfoutput>">
                            <span class="input-group-addon icon-ellipsis btnPointer" onclick="windowopen('index.cfm?fuseaction=objects.popup_list_all_pars&is_period_kontrol=0&field_partner=ShipForm.member_id_1&field_consumer=ShipForm.member_id_1&field_name=ShipForm.member_name_1&field_comp_id=ShipForm.company_id_1&field_comp_name=ShipForm.company_name_1&field_type=ShipForm.member_type_1&field_city=ShipForm.service_city_id_1&field_address=ShipForm.company_address_1&select_list=8,7&call_function=fill_saleszone()','list','popup_list_all_pars');" title="Başvuru Yapan Seç "></span>
                        </div>        
                </div>
                <div class="form-group" id="item-company_address">
                    <label >Adres </label>
                    
                        
                        <textarea rows="5" name="company_address_1" id="company_address_1" readonly message="#message#" maxlength="200" onkeyup="return ismaxlength(this);" onblur="return ismaxlength(this);"><cfoutput>#GEMI.CARE_OF_ADRESS#</cfoutput></textarea>
                                  
            </div>
            </cf_box>
        </div>
    </div>
    <hr>
    <button type="button" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left" onclick="AddShip(<cfoutput>#session.ep.userid#,'#attributes.modal_id#'</cfoutput>)" >Güncelle</button>
 
    

</form>
</cf_box>
<!---
    item=structNew();
                item.SHIP_ID=SHIP_ID;
                item.SHIP_NAME=SHIP_NAME;
                item.BUILD_YEAR=BUILD_YEAR;
                item.GROSS_TONNAGE=GROSS_TONNAGE;
                item.DEAD_WEIGHT_TONNAGE=DEAD_WEIGHT_TONNAGE;
                item.LENGTH=LENGTH;
                item.WIDTH=WIDTH;
                item.ACTION_TYPE=ACTION_TYPE;
                item.SHIP_TYPE=SHIP_TYPE;
                item.CUSTOMER_NICKNAME=CUSTOMER_NICKNAME;
                item.CUSTOMER_FULLNAME=CUSTOMER_FULLNAME;
                item.CUSTOMER_NAME=CUSTOMER_NAME;
                item.CUSTOMER_SURNAME=CUSTOMER_SURNAME;
                item.CUSTOMER_MAIL=CUSTOMER_MAIL;
                item.CUSTOMER_TELCODE=CUSTOMER_TELCODE;
                item.CUSTOMER_TEL=CUSTOMER_TEL;
                item.CARE_OF_NICKNAME=CARE_OF_NICKNAME;
                item.CARE_OF_FULLNAME=CARE_OF_FULLNAME;
                item.CARE_OF_NAME=CARE_OF_NAME;
                item.CARE_OF_SURNAME=CARE_OF_SURNAME;
                item.CARE_OF_MAIL=CARE_OF_MAIL;
                item.CARE_OF_TELCODE=CARE_OF_TELCODE;
                item.CARE_OF_TEL=CARE_OF_TEL;
                item.IMO_NUMBER=IMO_NUMBER;
                item.HULL_NUMBER=HULL_NUMBER;
                item.SHIP_YARD=SHIP_YARD;
                item.FLAG=FLAG;
                item.CLASS=CLASS;
    
    ----->
<script>
    function getFormData() {
        var SHIP_ID=document.getElementById("SHIP_ID").value;
        var SHIP_NAME=document.getElementById("SHIP_NAME").value;
        var BUILD_YEAR=document.getElementById("BUILD_YEAR").value;
        var GROSS_TONNAGE=document.getElementById("GROSS_TONNAGE").value;
        var DEAD_WEIGHT_TONNAGE=document.getElementById("DEAD_WEIGHT_TONNAGE").value;
        var LENGTH=document.getElementById("LENGTH").value;
        var WIDTH=document.getElementById("WIDTH").value;
        var SHIP_TYPE=document.getElementById("SHIP_TYPE").value;
        var CUSTOMER_NICKNAME=document.getElementById("company_name").value;
        var CUSTOMER_ID=document.getElementById("company_id").value;
        var CUSTOMER_NAME=document.getElementById("member_name").value;
        var CUSTOMER_EMP_ID=document.getElementById("member_id").value;
        var CAREOF_NICKNAME=document.getElementById("company_name_1").value;
        var CAREOF_ID=document.getElementById("company_id_1").value;
        var CAREOF_NAME=document.getElementById("member_name_1").value;
        var CAREOF_EMP_ID=document.getElementById("member_id_1").value;
        var IMO_NUMBER=document.getElementById("IMO_NUMBER").value;
        var HULL_NUMBER=document.getElementById("HULL_NUMBER").value;
        var SHIP_YARD=document.getElementById("SHIP_YARD").value;
        var FLAG=document.getElementById("FLAG").value;
        var CLASS=document.getElementById("CLASSF").value;
        var HataArr=[];
        if(CUSTOMER_ID.length==0){
            HataArr.push("member_name")
        }
        if(SHIP_NAME.length==0){
            HataArr.push("SHIP_NAME")
        }
        var FormData={
            SHIP_ID:SHIP_ID,
            SHIP_NAME:SHIP_NAME,
            BUILD_YEAR:BUILD_YEAR,
            GROSS_TONNAGE:GROSS_TONNAGE,
            DEAD_WEIGHT_TONNAGE:DEAD_WEIGHT_TONNAGE,
            LENGTH:LENGTH,
            WIDTH:WIDTH,
            SHIP_TYPE_ID:SHIP_TYPE,
            CUSTOMER_NICKNAME:CUSTOMER_NICKNAME,
            CUSTOMER_ID:CUSTOMER_ID,
            CUSTOMER_NAME:CUSTOMER_NAME,
            CUSTOMER_EMP_ID:CUSTOMER_EMP_ID,
            CAREOF_NICKNAME:CAREOF_NICKNAME,
            CAREOF_ID:CAREOF_ID,
            CAREOF_NAME:CAREOF_NAME,
            CAREOF_EMP_ID:CAREOF_EMP_ID,
            IMO_NUMBER:IMO_NUMBER,
            HULL_NUMBER:HULL_NUMBER,
            SHIP_YARD:SHIP_YARD,
            FLAG:FLAG,
            CLASS:CLASS,

        }
        if(HataArr.length==0){
            return FormData;
        }else{
            return false;
        }
        
    }
    function AddShip(EmpId,modal){
        console.log("addship")
        var FormData=getFormData() 
        FormData.UPDATE_EMP=EmpId;
        if(FormData != false){
        $.ajax({
            url:"/AddOns/YafSatis/Partner/cfc/ShipService.cfc?method=UpdateShip",
            data:{
                FData:JSON.stringify(FormData)
            },success:function(){
                closeBoxDraggable(modal)
            }
        })}
    }
</script>
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
