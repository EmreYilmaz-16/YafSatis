
<cf_box title="Gemi Tipleri" scroll="1" collapsable="1" resize="1" popup_box="1">
<div style="display:flex">
    <div style="width:33%">   
        <ul class="ui-list">
            <li>
                <a href="javascript:void(0)"  onclick=' AjaxPageLoad("index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=addupdshiptype&SHIP_TYPE_ID=","divshtyu",1,"Yükleniyor");'>
                    <div class="ui-list-left">
                        <span class="ui-list-icon ctl-salvation"></span>
                        Yeni Gemi Tipi Ekle
                    </div>
                    <div class="ui-list-right">
                        
                        <i class="fa fa-plus" ></i>
                    </div>
                </a>
            </li>
        </ul> 
       <div id="ShipTypeList" style="overflow-y: scroll;max-height: 30vh;"></div>
       
    </div>
    <div style="width:1%"></div>
    <div style="width:66%">
        <div id="divshtyu">

        </div>
    </div>
</div>
</cf_box>

<script>
    $(document).ready(function (params) {
        LoadList();
        AjaxPageLoad("index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=addupdshiptype&SHIP_TYPE_ID=","divshtyu",1,"Yükleniyor");
    })
    function LoadList() {
        AjaxPageLoad("index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=list_ship_types","ShipTypeList",1,"Yükleniyor");
    }
    function SaveShipType(params) {
        var ServiceUri = "/AddOns/YafSatis/Partner/cfc";
        var SHIP_TYPE_ID=document.getElementById("SHIP_TYPE_ID").value
       var SHIP_TYPE=document.getElementById("SHIP_TYPE").value
       $.ajax({
    url: ServiceUri + "/ShipService.cfc?method=SaveShipType&SHIP_TYPE="+SHIP_TYPE+"&SHIP_TYPE_ID="+SHIP_TYPE_ID,
    success: function (returnData) {
      
     console.log(returnData);
     LoadList();
     AjaxPageLoad("index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=addupdshiptype&SHIP_TYPE_ID=","divshtyu",1,"Yükleniyor");
    },
  });
    }
    function RemoveShipType(params) {
        var ServiceUri = "/AddOns/YafSatis/Partner/cfc";
        var SHIP_TYPE_ID=document.getElementById("SHIP_TYPE_ID").value
       var SHIP_TYPE=document.getElementById("SHIP_TYPE").value
       var ef=confirm("Silmek İstediğinize Eminmisiniz ?")
       if(!ef){
        return false;
       }
       $.ajax({
    url: ServiceUri + "/ShipService.cfc?method=RemoveShipType&SHIP_TYPE="+SHIP_TYPE+"&SHIP_TYPE_ID="+SHIP_TYPE_ID,
    success: function (returnData) {
      
     console.log(returnData);
     LoadList();
     AjaxPageLoad("index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=addupdshiptype&SHIP_TYPE_ID=","divshtyu",1,"Yükleniyor");
    },
  });
    }
    
</script>