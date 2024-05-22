
<cf_box title="Gemi Tipleri">
<div style="display:flex">
    <div style="width:33%">    
       <div id="ShipTypeList"></div>
       
    </div>
    <div style="width:66%">
        <div id="divshtyu">

        </div>
    </div>
</div>
</cf_box>

<script>
    $(document).ready(function (params) {
        LoadList();
    })
    function LoadList() {
        AjaxPageLoad("index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=list_ship_types","ShipTypeList",1,"Yükleniyor");
    }
    function SaveShipType(params) {
        
    }
    function RemoveShipType(params) {
        
    }
    
</script>