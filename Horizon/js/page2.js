function openShipList(){
    var CustomerId=document.getElementById("company_id").value;
    openBoxDraggable("index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=getWessels&CustomerId="+CustomerId)
}