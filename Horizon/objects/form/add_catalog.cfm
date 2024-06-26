<cfparam name="attributes.SHIP_ID" default="">


<CFSET SHIP_NAME="">
<CFSET MACHINE_ARR=arrayNew(1)>

<cfif len(attributes.SHIP_ID)>
    <cfquery name="getShip" datasource="#dsn3#">
        select * from CatalystQA.PBS_SHIPS WHERE SHIP_ID =#attributes.SHIP_ID#
    </cfquery>
    <cfquery name="getMachineList" datasource="#dsn#">
        
        select * from CatalystQA.PBS_SHIP_MACHINES where WESSEL_ID=#attributes.SHIP_ID#
    </cfquery>
    <cfloop query="getMachineList">
        <CFSET MACHINE=STRUCTNEW()>
        <CFSET MACHINE.MACHINE_NAME=MACHINE_NAME>
        <CFSET MACHINE.SM_ID=SM_ID>
    <cfscript>
        arrayAppend(MACHINE_ARR,MACHINE);
    </cfscript>
    </cfloop>
    <CFSET SHIP_NAME=getShip.SHIP_NAME>
    
</cfif>

<cf_box title="Katalog Ekle" scroll="1" collapsable="1" resize="1" popup_box="1">
    <div class="form-group">
        <input type="text" name="CATALOG_NAME" id="CATALOG_NAME">
    </div>
    <div class="form-group">
        
            <label class="margin-bottom-5 bold font-sm">VESSEL NAME</label>
            <div class="input-group">
                <input type="text" name="ship_name" id="ship_name" value="<cfoutput>#SHIP_NAME#</cfoutput>">
                <input type="hidden" name="ship_id" id="ship_id" value="<cfoutput>#attributes.SHIP_ID#</cfoutput>">
                <span onclick="openShipList()" class="input-group-addon icon-ellipsis color-CR"></span>
            </div>
        
    </div>

    <div class="form-group">
        <label>
            Makinalar
        </label>
        <select name="Machines" id="Machines">
            <option value="">Seç</option>
            <cfloop array="#MACHINE_ARR#" item="MACHINE">
                <option value="<cfoutput>#MACHINE.SM_ID#</cfoutput>"><cfoutput>#MACHINE.MACHINE_NAME#</cfoutput></option>
            </cfloop>
        </select>
    </div>

    <a href="javascript://" onclick="KatalogKaydet()" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left"><i class="fa fa-repeat"></i>CHANGE STATUS</a>

</cf_box>




<script>
var ServiceUri="/AddOns/YafSatis/Partner/cfc"
    function openShipList() {
  
  
    openBoxDraggable(
      "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=getWessels&ReturnMethod=getMachineList"
        
    );
  
}
function KatalogKaydet() {
    var CatalogName=document.getElementById("CATALOG_NAME").value;
    var ShipId=document.getElementById("ship_id").value;
    var Machine=document.getElementById("Machines").value;

    var O={
        CatalogName:CatalogName,
        ShipId:ShipId,
        Machine:Machine,
    };
    var Fd=JSON.stringify(O);
   $.post("/index.cfm?fuseaction=objects.emptypopup_save_catalog_pbs&ajax=1&ajax_box_page=1&isAjax=1&Data="+Fd).done(function (ReturnData) {
    var Ibb=JSON.parse(ReturnData);
    console.log(Ibb);
    alert(Ibb.MESSAGE)
    if(Ibb.STATUS==1){
        openBoxDraggable("index.cfm?fuseaction=objects.emptypopup_add_product_to_catalog&CatalogId="+Ibb.GENERATEDKEY);
    }
   }) 
}

function getMachineList() {
    var WESSEL_ID=document.getElementById("ship_id").value;
    $("#Machines").html("");
    var opt=document.createElement("option");
                    opt.value=""
                    opt.innerText="Seç"
                    document.getElementById("Machines").appendChild(opt);
    $.ajax({
            url:ServiceUri+"/ShipService.cfc?method=listMachines&WESSEL_ID="+WESSEL_ID,
            success:function (returnData) {
                var Makinalar=JSON.parse(returnData);
                for (let index = 0; index < Makinalar.length; index++) {
                    const element = Makinalar[index];
                   var optgroup=document.createElement("optgroup");
                   optgroup.setAttribute("label",element.PRODUCT_CAT)
                   for (let j = 0; j < element.MACHINEARR.length; j++) {
                    const element2 = element.MACHINEARR[j];
                      
                    var opt=document.createElement("option");
                    opt.value=element2.SM_ID
                    opt.innerText=element2.MACHINE_NAME
                    optgroup.appendChild(opt)
                    
                   }
                   document.getElementById("Machines").appendChild(optgroup);
                    /*
                    var opt=document.createElement("option");
                    opt.value=element.SM_ID
                    opt.innerText=element.MACHINE_NAME
                    document.getElementById("Machines").appendChild(opt);
                    */
                }
            }
        })



}

</script>
