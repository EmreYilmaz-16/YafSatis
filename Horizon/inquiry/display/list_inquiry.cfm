<style>
        .OsButton{
        width: 100%;
    height: 50px;    
    font-weight: bold;
    font-size: 10pt !important;
    border: none;        
    margin: 5px;
}
 .OsButton-orange{
    background: #ffbe0b;
    color:black;
 }
 .OsButton-orange:hover{
    background: #d6a00a;
    color:black;
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

<cfif 1 eq 0>
    Merhaba;
    <cfinclude template="menu2.cfm">
    <cfabort>
</cfif>

<div class="row">         
    
    <div class="col col-3 col-md-4 col-sm-5 col-xs-12">
        <cf_box>
        <div style="display:flex;flex-direction: column;">
            <button onclick="window.open('/index.cfm?fuseaction=myhome.welcome','_blank')" class="OsButton OsButton-orange" >W3 Ana Sayfa</button>
            <hr>
            <button onclick="window.open('/index.cfm?fuseaction=sale.hrz_pbs_sayfa1','_blank')" class="OsButton OsButton-orange">List Inquiry</button>
            <button onclick='openBoxDraggable("index.cfm?fuseaction=sale.emptypopup_hrz_pbs_sayfa2")' class="OsButton OsButton-orange">Add Inquiry </button>
            <button onclick='openBoxDraggable("index.cfm?fuseaction=sales.emptypopup_list_virtual_products")' class="OsButton OsButton-orange">List Waiting Virtual Products </button>
            <hr>
            <button onclick="openBoxDraggable('index.cfm?fuseaction=sale.list_vessels','_blank')" class="OsButton OsButton-orange" >List Vessels</button>            
            <button onclick='openBoxDraggable("index.cfm?fuseaction=objects.emptypopup_add_vessel")' class="OsButton OsButton-orange">Add Vessel</button>
            <button onclick='openBoxDraggable("index.cfm?fuseaction=objects.emptypopup_list_ship_types_pbs")' class="OsButton OsButton-orange" >Ship Types</button>
               <!---  <button onclick='openBoxDraggable("index.cfm?fuseaction=objects.emptypopup_add_catalog_pbs")' style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #ff8300;border-radius: 10px;background: #ff830075;font-weight: bold;color: white;margin: 5px;">Add Catalog</button>
       --->
           <hr>
           <button onclick="window.open('/index.cfm?fuseaction=purchase.emptypopup_list_offer_pbs','_blank')" class="OsButton OsButton-orange">List Purchase Offer</button>            
           <hr>
           <button onclick='window.open("index.cfm?fuseaction=report.detail_product_report_PBS","_blank")' class="OsButton OsButton-orange">Detaylı Ürün Raporu</button>
        </div>
    </cf_box>
    </div>
    <div class="col col-9 col-md-8 col-sm-7 col-xs-12">      
    <cf_box>
        <div style="display:flex;">
        <div style="width:30%">
            <canvas id="myChart"></canvas>
        </div>
        <div style="width:30%">
            <canvas id="myChart2"></canvas>
        </div>
        <div style="width:30%">
            <canvas id="myChart3"></canvas>
        </div>
    </div>              
</cf_box>
    </div>                        
 </div>

 <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

 <script> 
 $(document).ready(function(){
    MainT();
    TT1();
    TT2();
    document.body.setAttribute("style","overflow: hidden;")
 })  


 function MainT(){
    const ctx = document.getElementById('myChart');
    var SF=wrk_safe_query("getOCS_1","dsn")
    const data = {
  labels: SF.OCS,
  datasets: [{
    label: 'Inquiries %',
    data: SF.TF,
    backgroundColor: [
      'rgb(255, 99, 132)',
      'rgb(54, 162, 235)'
      
    ],
    hoverOffset: 4
  }]
  
};

const config = {
  type: 'doughnut',
  data: data,
  options: {
        plugins: {
            subtitle: {
                display: true,
                text: 'Inquries'
            }
        }
    }
}

new Chart(ctx, config);
 }
 function TT1(){
    const ctx = document.getElementById('myChart2');
    var SF=wrk_safe_query("getOCS_2","dsn")
    const data = {
  labels: SF.OCS,
  datasets: [{
    label: 'Inquiries',
    data: SF.TF,
    
    hoverOffset: 4
  }]
};

const config = {
  type: 'doughnut',
  data: data,
  options: {
        plugins: {
            subtitle: {
                display: true,
                text: 'For Customer'
            }
        }
    }
}

new Chart(ctx, config);
 }
 function TT2(){
    const ctx = document.getElementById('myChart3');
    var SF=wrk_safe_query("getOCS_3","dsn")
    const data = {
  labels: SF.OCS,
  datasets: [{
    label: 'Inquiries',
    data: SF.TF,
    
    hoverOffset: 4
  }]
};

const config = {
  type: 'doughnut',
  data: data,
  options: {
        plugins: {
            subtitle: {
                display: true,
                text: 'For Yaf Stock'
            }
        }
    }
}

new Chart(ctx, config);
 }
 </script>


<script src="/AddOns/YafSatis/Horizon/js/page_wl.js"></script>