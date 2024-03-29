<!--- Yönlendirme Başlangıç --->
<section class="page-bar">
    <ul class="page-breadcrumb">
        <li><a href="javascript://">YAF DIESEL</a></li>
        <li><i class="fa fa-fast-forward"></i><a href="">PURCHASE ITEMS</a></li>
        <li><i class="fa fa-circle"></i><a href="">INQUORY RECORDS</a></li>
        <li><i class="fa fa-circle"></i><a href="" class="bold">CUSTOMER INQUIRY</a></li>
    </ul>
</section>

<!--- Yönlendirme Bitiş --->

<!--- Üst Panel Başlangıç --->
<cf_box title="INQUIRY RECORDS (CUSTOMER INQUIRY)">
    <div class="page-header ">
        <div class=" headerMenu pull-right">
            <a onclick="openBoxDraggable('index.cfm?fuseaction=sale.emptypopup_hrz_pbs_sayfa2')" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left"><i class="fa fa-plus"></i>ADD NEW RECORD</a>
        </div>
    </div>

</cf_box>

<!--- Üst Panel Bitiş --->

<!--- Butonlar Başlangıç --->
<cf_box>
    <cf_box_elements >
        <div class="col col-12">
            <div class="col col-6 d-flex">
                <a href="javascript://" class="ui-btn ui-btn-update border border-warning text-dark ui-btn-block" style="height:100%;">
                    <div class="pull-left font-lg padding-5">
                        CUSTOMER INQUIRY
                    </div>
                    
                    <div class="pull-right padding-5" >
                        <div class="color-IN  padding-left-10 bold padding-right-10" style="border-radius:5px;">
                            <span class="margin-right-5">4300</span>Records
                        </div>
                       
                    </div>
                    
                </a>
            </div>
            <div class="col col-6 d-flex">
                <a href="javascript://" class="ui-btn ui-btn-update border border-warning text-dark ui-btn-block" style="height:100%;">
                    <div class="pull-left font-lg padding-5">
                        INQUIRY FOR YAF STOCK
                    </div>
                    
                    <div class="pull-right padding-5" >
                        <div class="color-IN padding-left-10 bold padding-right-10" style="border-radius:5px;">
                            <span class="margin-right-5">57</span>Records
                        </div>
                       
                    </div>
                    
                </a>
            </div>

            
            <div class="col col-12 margin-top-5">
                <div class="col col-2 d-flex">
                    <a href="javascript://" class="ui-btn ui-btn-success border border-warning text-dark ui-btn-block" style="height:100%;">
                        <div class="pull-left font-md padding-5">
                            CUSTOMER
                        </div>
                        
                        <div class="pull-right padding-4" >
                            <div class="color-H  padding-left-5 bold padding-right-5" style="border-radius:5px;">
                                <span class="margin-right-5 font-xs">4300</span>Records
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col col-2 d-flex">
                    <a href="javascript://" class="ui-btn ui-btn-success border border-warning text-dark ui-btn-block" style="height:100%;">
                        <div class="pull-left font-md padding-5">
                            CONFIRMED
                        </div>
                        
                        <div class="pull-right padding-3" >
                            <div class="color-H  padding-left-5 bold padding-right-5" style="border-radius:5px;">
                                <span class="margin-right-5 font-xs">4300</span>Records
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col col-2 d-flex">
                    <a href="javascript://" class="ui-btn ui-btn-success border border-warning text-dark ui-btn-block" style="height:100%;">
                        <div class="pull-left font-md padding-">
                            SUPPLIER
                        </div>
                        
                        <div class="pull-right padding-4" >
                            <div class="color-H  padding-left-5 bold padding-right-5" style="border-radius:5px;">
                                <span class="margin-right-5 font-xs">4300</span>Records
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col col-2 d-flex">
                    <a href="javascript://" class="ui-btn ui-btn-success border border-warning text-dark ui-btn-block" style="height:100%;">
                        <div class="pull-left font-md padding-5">
                            C. OFFER
                        </div>
                        
                        <div class="pull-right padding-4" >
                            <div class="color-H  padding-left-5 bold padding-right-5" style="border-radius:5px;">
                                <span class="margin-right-5 font-xs">4300</span>Records
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col col-2 d-flex">
                    <a href="javascript://" class="ui-btn ui-btn-success border border-warning text-dark ui-btn-block" style="height:100%;">
                        <div class="pull-left font-md padding-5">
                            CUSTOMER
                        </div>
                        
                        <div class="pull-right padding-4" >
                            <div class="color-H  padding-left-5 bold padding-right-5" style="border-radius:5px;">
                                <span class="margin-right-5">4300</span>Records
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col col-2 d-flex">
                    <a href="javascript://" class="ui-btn ui-btn-success border border-warning text-dark ui-btn-block" style="height:100%;">
                        <div class="pull-left font-md padding-5">
                            SUPPLIER
                        </div>
                        
                        <div class="pull-right padding-4" >
                            <div class="color-H  padding-left-5 bold padding-right-5" style="border-radius:5px;">
                                <span class="margin-right-5">4300</span>Records
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
    <cf_box_elements vertical="1">
        <form name="order_Search_form">
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
            <div class="input-group">
                <input type="text">
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div>
        </div>

        <div class="form-group col col-1 col-md-1 col-sm-1 col-xs-12">
            <label class="bold">DATE (FINISH)</label>
            <div class="input-group">
                <input type="text">
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div>
        </div>
<!---//DIKKAT HTML inputları Kullanırken İd ve name attributeleri genelde yok bunlarıda isimlendirirken aslında kullanacağın servisteki değişkenler ile uyumlu olarak yazarsan javascript tarafında form.serialize yapıp kolaylıkla servise gönderebilirsin ----->
        <div class="form-group col col-2 col-md-2 col-sm-2 col-xs-12">
            <label class="bold">PURCHASE STAFF</label>
            <div class="input-group">
                <input type="hidden" name="sales_member_id" id="sales_member_id" value="">
                <input type="hidden" name="sales_member_type" id="sales_member_type" value="">
                <input name="sales_member_name" type="text" id="sales_member_name" placeholder="Sales Partner " onfocus="AutoComplete_Create('sales_member_name','MEMBER_NAME,MEMBER_PARTNER_NAME','MEMBER_PARTNER_NAME2,MEMBER_NAME2','get_member_autocomplete','\'1,2\',0,0,0','PARTNER_ID2,MEMBER_TYPE','sales_member_id,sales_member_type','','3','250');" value="" autocomplete="off"><div id="sales_member_name_div_2" name="sales_member_name_div_2" class="completeListbox" autocomplete="on" style="width: 441px; max-height: 150px; overflow: auto; position: absolute; left: 942px; top: 209px; z-index: 159; display: none;"></div>
                <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('index.cfm?fuseaction=objects.popup_list_pars&field_id=order_Search_form.sales_member_id&field_name=order_Search_form.sales_member_name&field_type=order_Search_form.sales_member_type&select_list=2,3');"></span>
            </div>
        </div>

        <div class="form-group col col-2 col-md-2 col-sm-2 col-xs-12">
            <label class="bold"><strong>YOUR REF</strong></label>
            <input type="text" name="customer_ref_no" id="customer_ref_no">
        </div>

        <div class="form-group col col-2 col-md-2 col-sm-2 col-xs-12">
            <label class="bold"><strong>OUR REF</strong></label>
            <input type="text" name="ref_no" value="ref_no">
        </div>
            
        <div class="form-group col col-2 col-lg-2 col-md-2 col-sm-2 col-xs-12 margin-top-20">
            <a href="javascript://"  is_upd="1" class="ui-wrk-btn ui-wrk-btn-success ui-wrk-btn-addon-left" style="width:85%;"><i class="fa fa-repeat"></i><span class="font-sm">FILTER LIST</span></a>
        </div>
    </form>
    </cf_box_elements>
</cf_box>
<!--- From Kısmı Başlangıç Bitiş --->

<!--- Grid Başlangıç --->
<cf_box>
    <cf_ajax_list>
        <thead>
            <tr>
                <th class="drag-enable">DATE<span class="table-handle"><i class="fa fa-sort"></i></span></th>
                <th class="drag-enable">CUST. REF<span class="table-handle"><i class="fa fa-sort"></i></span></th>
                <th class="drag-enable">CUSTOMER INFO<span class="table-handle"><i class="fa fa-sort"></i></span></th>
                <th class="drag-enable">DELIVERY ADDRESS<span class="table-handle"><i class="fa fa-sort"></i></span></th>
                <th class="drag-enable">TRANSPORTATION<span class="table-handle"><i class="fa fa-sort"></i></span></th>
                <th width="120"></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>123</td>
                <td>2020</td>
                <td>2020</td>
                <td>2020</td>
                <td>
                    <div class="form-group color-In" style="border-radius:3px; color:#fff">
                        <select class="bold" style="color:#fff">
                            <option class="text-light" style="color:#000" selected>TRANSACTIONS</option>
                        </select>
                    </div>
                </td>
            </tr>
           
        </tbody>
    </cf_ajax_list>
    <div class="ui-pagination">
        <div class="pagi-left">
            <ul>
                <li><a href="javascript://"><i class="fa fa-angle-left"></i></a></li>
                <li><a href="javascript://"><i class="fa fa-angle-left"></i></a></li>
                <li><a href="javascript://"><i class="fa fa-angle-right"></i></a></li>
                <li><a href="javascript://"><i class="fa fa-angle-double-right"></i></a></li>
                <!--<li><input type="text" value="1"><span>/ 1024</span></li>
                <li><a href="javascript://"><i class="fa fa-angle-right"></i></a></li>-->
                
                <li><a onclick="font_inc("unique_id", +1)" href="javascript://">A+</a></li>
                <!-- <li><a onclick="font_inc("unique_id", 0)" href="javascript://"><i class="fa fa-refresh"></i></a></li> -->
                <li><a onclick="font_inc("unique_id", -1)" href="javascript://">A-</a></li>
            </ul>
        </div>
    </div>

</cf_box>
<!--- Grid Bitiş --->



<script src="/AddOns/YafSatis/Horizon/js/page1.js"></script>