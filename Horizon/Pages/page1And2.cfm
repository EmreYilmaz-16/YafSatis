<style>
    .ui-btn-outline-update {
    padding: 0 15px !important;
    background-color: none !important;
    color: #ffb822 !important;
    border-radius: 3px;
}
.ui-btn-outline-update:hover, .ui-btn-outline-update:active {
    background-color: #e4a114;
    color: #fff !important;
}
.ui-btn-outline-success {
    padding: 0 15px !important;
    background-color: none;
    color: #44b6ae !important;
    border-radius: 3px;
}
.ui-btn-outline-success:hover, .ui-btn-outline-success:active {
    background-color: #44b6ae;
    color: #fff !important;
}
.form-group input[type=text], .form-group input[type=tel],.form-group input[type=date], .form-group input[type=search], input[type=search], .form-group input[type=number], .form-group input[type=password], .form-group input[type=file], .form-group select {
    width: 100% !important;
    min-height: 23px;
    font-family: 'Roboto';
    padding: 1px 25px 1px 5px;
    font-size: 12px;
    outline: none;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    -webkit-box-shadow: 0;
    box-shadow: 0;
    border-radius: 0;
    border: 1px solid #ccc;
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
}
</style>
<cfquery name="getMoney" datasource="#dsn#">
    SELECT (
            SELECT RATE1
            FROM #DSN#.MONEY_HISTORY
            WHERE MONEY_HISTORY_ID = (
                    SELECT MAX(MONEY_HISTORY_ID)
                    FROM #DSN#.MONEY_HISTORY
                    WHERE MONEY = SM.MONEY
                    )
            ) AS RATE1
        ,(
            SELECT RATE2
            FROM #DSN#.MONEY_HISTORY
            WHERE MONEY_HISTORY_ID = (
                    SELECT MAX(MONEY_HISTORY_ID)
                    FROM #DSN#.MONEY_HISTORY
                    WHERE MONEY = SM.MONEY
                    )
            ) AS RATE2
        ,SM.MONEY
    FROM #DSN#.SETUP_MONEY AS SM
    WHERE SM.PERIOD_ID = #session.ep.period_id#
</cfquery>
<script>
    var DataSources={
        DSN:"<cfoutput>#dsn#</cfoutput>",
        DSN1:"<cfoutput>#dsn1#</cfoutput>",
        DSN2:"<cfoutput>#dsn2#</cfoutput>",
        DSN3:"<cfoutput>#dsn3#</cfoutput>",
    }
    var ACTIVE_COMPANY="<CFOUTPUT>#session.ep.company_id#</CFOUTPUT>";
    var MONEY_ARR=[
        <cfoutput query="getMoney">
            {
                RATE1:#RATE1#,
                RATE2:#RATE2#,
                MONEY:'#MONEY#',
                SELECTED:0
            },
        </cfoutput>
    ]
    var Filters={
        ForCustomer:1,
        Stage:0,
        CompanyId:"",
        StartDate:"",
        FinishDate:"",
        SalesPartnerId:"",
        PaperNo:"",
        RefNo:""
    };
</script>

<!--- Yönlendirme Başlangıç --->
<section class="page-bar">
    <ul class="page-breadcrumb">
        <li><a href="/index.cfm?fuseaction=myhome.welcome">YAF DIESEL</a></li>
        <li><i class="fa fa-fast-forward"></i><a href="/index.cfm?fuseaction=sale.emptypopup_hrz_pbs_sayfa1">INQUIRY WELCOME</a></li>        
        <li><i class="fa fa-circle"></i><a href="" class="bold">INQUORY RECORDS</a></li>
    </ul>
</section>

<!--- Yönlendirme Bitiş --->

<!--- Üst Panel Başlangıç --->
<cf_box title="INQUIRY RECORDS (CUSTOMER INQUIRY)">
    <div class="page-header " >
        <div class=" headerMenu pull-right" style="margin-bottom:10px">
            <a onclick="openBoxDraggable('index.cfm?fuseaction=sale.emptypopup_hrz_pbs_sayfa2')" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left"><i class="fa fa-plus"></i>ADD NEW RECORD</a>
        </div>
    </div>
<div style="clear:both"></div>
    <cf_box_elements >
        <div class="col col-12">
            <div class="col col-6 d-flex">
                <a href="javascript://" onclick="LoadOffers('Cust',1);" id="Cust1" class="ui-btn ui-btn-outline-update border border-warning text-dark ui-btn-block" style="height:100%;">
                    <div class="pull-left font-lg padding-5">
                        CUSTOMER INQUIRY
                    </div>
                    
                    <div class="pull-right padding-5" >
                        <div class="color-IN  padding-left-10 bold padding-right-10" style="border-radius:5px;">
                            <span class="margin-right-5" id="OC_1">4300</span>Records
                        </div>
                       
                    </div>
                    
                </a>
            </div>
            <div class="col col-6 d-flex">
                <a href="javascript://" onclick="LoadOffers('Cust',2);" id="Cust2" class="ui-btn ui-btn-outline-update border border-warning text-dark ui-btn-block" style="height:100%;">
                    <div class="pull-left font-lg padding-5">
                        INQUIRY FOR YAF STOCK
                    </div>
                    
                    <div class="pull-right padding-5" >
                        <div class="color-IN padding-left-10 bold padding-right-10" style="border-radius:5px;">
                            <span class="margin-right-5" id="OC_2">57</span>Records
                        </div>
                       
                    </div>
                    
                </a>
            </div>

        
            <div class="col col-12 margin-top-5">
                <div class="col col-2 d-flex">
                    <a href="javascript://" data-stage="261" id="SOC_1_261" onclick="LoadOffers('STG',261,1);"  class="ui-btn ui-btn-outline-success border border-warning text-dark ui-btn-block filterb" style="height:100%;">
                        <div class="pull-left font-md padding-5">
                            CUSTOMER
                        </div>
                        
                        <div class="pull-right padding-4" >
                            <div class="color-H  padding-left-5 bold padding-right-5" style="border-radius:5px;">
                                <span class="margin-right-5 font-xs" id="OC_1_261" >4300</span>Records
                            </div>
                        </div>
                    </a>
                </div>
             
                <div class="col col-2 d-flex">
                    <a href="javascript://" data-stage="263"  id="SOC_1_263" onclick="LoadOffers('STG',263,1);"   class="ui-btn ui-btn-outline-success border border-warning text-dark ui-btn-block filterb" style="height:100%;">
                        <div class="pull-left font-md padding-5">
                            CONFIRMED
                        </div>
                        
                        <div class="pull-right padding-3" >
                            <div class="color-H  padding-left-5 bold padding-right-5" style="border-radius:5px;">
                                <span class="margin-right-5 font-xs" id="OC_1_263">4300</span>Records
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col col-2 d-flex">
                    <a href="javascript://" data-stage="262"  id="SOC_1_262" onclick="LoadOffers('STG',262,1);"  class="ui-btn ui-btn-outline-success border border-warning text-dark ui-btn-block filterb" style="height:100%;">
                        <div class="pull-left font-md padding-">
                            SUPPLIER
                        </div>
                        
                        <div class="pull-right padding-4" >
                            <div class="color-H  padding-left-5 bold padding-right-5" style="border-radius:5px;">
                                <span class="margin-right-5 font-xs" id="OC_1_262">4300</span>Records
                            </div>
                        </div>
                    </a>
                </div>
    
                <div class="col col-2 d-flex">
                    <a href="javascript://" data-stage="264"  id="SOC_2_264" onclick="LoadOffers('STG',264,2);"  class="ui-btn ui-btn-outline-success border border-warning text-dark ui-btn-block filterb" style="height:100%;">
                        <div class="pull-left font-md padding-5">
                            C. OFFER
                        </div>
                        
                        <div class="pull-right padding-4" >
                            <div class="color-H  padding-left-5 bold padding-right-5" style="border-radius:5px;">
                                <span class="margin-right-5 font-xs" id="OC_2_264">4300</span>Records
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col col-2 d-flex">
                    <a href="javascript://" data-stage="266"  id="SOC_2_266" onclick="LoadOffers('STG',266,2);"   class="ui-btn ui-btn-outline-success border border-warning text-dark ui-btn-block filterb" style="height:100%;">
                        <div class="pull-left font-md padding-5">
                            CUSTOMER
                        </div>
                        
                        <div class="pull-right padding-4" >
                            <div class="color-H  padding-left-5 bold padding-right-5" style="border-radius:5px;">
                                <span class="margin-right-5" id="OC_2_266">4300</span>Records
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col col-2 d-flex">
                    <a href="javascript://" data-stage="267"  id="SOC_2_267" onclick="LoadOffers('STG',267,2);"  class="ui-btn ui-btn-outline-success border border-warning text-dark ui-btn-block filterb" style="height:100%;">
                        <div class="pull-left font-md padding-5">
                            SUPPLIER
                        </div>
                        
                        <div class="pull-right padding-4" >
                            <div class="color-H  padding-left-5 bold padding-right-5" style="border-radius:5px;">
                                <span class="margin-right-5" id="OC_2_267">4300</span>Records
                            </div>
                        </div>
                    </a>
                </div>
            </div>
                
            
        </div>
    </cf_box_elements>
</cf_box>
<!--- Üst Panel Bitiş --->

<!--- From Kısmı Başlangıç --->
<cf_box>
    
        <form name="order_Search_form">
    <div class="row">
            <div class="form-group col col-3 col-md-3 col-sm-3 col-xs-12">
            <label class="bold"><strong>CUSTOMER NAME</strong></label> <!---- //BILGI Veri Kayıt Edebilmek İçin Id Değeri de gereklidir Her bir alan için Gözüken Alan ve Id değeri Olmalıdır ---->
            <div class="input-group">
                <input type="hidden" name="consumer_id" id="consumer_id" value="">
                <input type="hidden" name="company_id" id="company_id" value="">
                <input type="hidden" name="member_type" id="member_type" value="">
                <input name="member_name" type="text" id="member_name" placeholder="Current Account" onfocus="AutoComplete_Create('member_name','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','get_member_autocomplete','\'1,2\'','CONSUMER_ID,COMPANY_ID,MEMBER_TYPE','consumer_id,company_id,member_type','','3','250');" value="" autocomplete="off"><div id="member_name_div_2" name="member_name_div_2" class="completeListbox" autocomplete="on" style="width: 441px; max-height: 150px; overflow: auto; position: absolute; left: 20px; top: 209px; z-index: 159; display: none;"></div>                
                <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('index.cfm?fuseaction=objects.popup_list_all_pars&field_consumer=order_Search_form.consumer_id&field_comp_id=order_Search_form.company_id&field_member_name=order_Search_form.member_name&field_type=order_Search_form.member_type&select_list=7,8&keyword='+encodeURIComponent(document.order_Search_form.member_name.value));"></span>
                <!----//BILGI span taginin onclick methodunda görebileceğin gibi field_consumer diye başlayan bir yer var bu alanda gönderilen order_form.consumer_id değerinde noktadan önceki kısım form tagininin name attribute'ü noktadan sonraki kısımda formdaki alanın adı bu veriye göre diğer sayfadan veri atıyor----->
                <!----//SOR Span taginin Düzenlenmeden Önceki Halini Buraya Ekliyorum düzenlenmiş halini yukarıda görebilirsin 
                    //SOR <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('index.cfm?fuseaction=objects.popup_list_all_pars&field_consumer=order_form.consumer_id&field_comp_id=order_form.company_id&field_member_name=order_form.member_name&field_type=order_form.member_type&select_list=7,8&keyword='+encodeURIComponent(document.order_form.member_name.value));"></span>
                    ---->

            </div>
            <!---//BILGI Burada Workcube'ün Standart Müşteri Seçim Ekranını Kullanabiliriz Örn : Üstteki Alanlar Burada Bizi Zorunlu tuttuğu yer bir Form İçerisinde Olması---->
        </div>

        <div class="form-group col col-1 col-md-1 col-sm-1 col-xs-12">
            <label class="bold">DATE (START)</label>
            
                <input type="date" name="StartDate" id="StartDate">
            
        </div>

        <div class="form-group col col-1 col-md-1 col-sm-1 col-xs-12">
            <label class="bold">DATE (FINISH)</label>
            
                <input type="date" name="FinishDate" id="FinishDate">
                
            
        </div>
<!---//DIKKAT HTML inputları Kullanırken İd ve name attributeleri genelde yok bunlarıda isimlendirirken aslında kullanacağın servisteki değişkenler ile uyumlu olarak yazarsan javascript tarafında form.serialize yapıp kolaylıkla servise gönderebilirsin ----->
        <div class="form-group col col-2 col-md-2 col-sm-2 col-xs-12">
            <label class="bold">PURCHASE STAFF</label>
            <div class="input-group">
										
                <input type="hidden" name="deliver_get_id" id="deliver_get_id" value="">
                <input type="text" name="deliver_get" id="deliver_get" value="" onfocus="AutoComplete_Create(" deliver_get','member_name','member_name','get_member_autocomplete','3','employee_id','deliver_get_id','','3','150');'="" autocomplete="off">
            
            <span class="input-group-addon btnPointer icon-ellipsis" title="Seçiniz " onclick="windowopen('index.cfm?fuseaction=objects.popup_list_positions&select_list=1&field_name=order_Search_form.deliver_get&field_emp_id2=order_Search_form.deliver_get_id','list');"></span>
        </div>
        </div>

        <div class="form-group col col-1 col-md-1 col-sm-1 col-xs-12">
            <label class="bold"><strong>YOUR REF</strong></label>
            <input type="text" name="customer_ref_no" id="customer_ref_no">
        </div>

        <div class="form-group col col-1 col-md-1 col-sm-1 col-xs-12">
            <label class="bold"><strong>OUR REF</strong></label>
            <input type="text" name="PaperNo" id="PaperNo">
        </div>
            
        <div class="form-group col col-2 col-lg-2 col-md-2 col-sm-2 col-xs-12 margin-top-20">
            <a href="javascript://" onclick="TeklifGetir()"  is_upd="1" class="ui-wrk-btn ui-wrk-btn-success ui-wrk-btn-addon-left" style="width:85%;"><i class="fa fa-repeat"></i><span class="font-sm">FILTER LIST</span></a>
        </div>
    </div>
    </form>
    
</cf_box>
<!--- From Kısmı Başlangıç Bitiş --->

<!--- Grid Başlangıç --->
<cf_box>
    <div id="OfferListArea">

    </div>
   

</cf_box>
<!--- Grid Bitiş --->



<script src="/AddOns/YafSatis/Horizon/js/page1.js"></script>