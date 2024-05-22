
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
        var ServiceUri = "/AddOns/YafSatis/Partner/cfc";
        var SHIP_TYPE_ID=document.getElementById("SHIP_TYPE_ID").value
       var SHIP_TYPE=document.getElementById("SHIP_TYPE").value
       $.ajax({
    url: ServiceUri + "/ShipService.cfc?method=SaveShipType&SHIP_TYPE="+SHIP_TYPE+"&SHIP_TYPE_ID="+SHIP_TYPE_ID,
    success: function (returnData) {
      
     console.log(returnData);
     LoadList();
    },
  });
    }
    function RemoveShipType(params) {
        
    }
    
</script>