function openShipList(){
    var CustomerId=document.getElementById("company_id").value;
    if(CustomerId.length>0){
    openBoxDraggable("index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=getWessels&CustomerId="+CustomerId)}else{
        alert("Müşteri Seçmediniz");
    }
}