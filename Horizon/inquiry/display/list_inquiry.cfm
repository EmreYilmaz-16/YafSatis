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

<div class="row">         

    <div class="col col-2">
<cf_box>
        <div style="display:flex;flex-direction: column;height:100vh">
            <button onclick="window.location.href='/index.cfm?fuseaction=myhome.welcome'" style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #305505;border-radius: 10px;background: #3f6a0e52;font-weight: bold;color: white;margin: 5px;">W3 Ana Sayfa</button>
            <hr>
            <button onclick="window.location.href='/index.cfm?fuseaction=sale.hrz_pbs_sayfa1'" style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #096cc5;border-radius: 10px;background: #82c4ffa1;font-weight: bold;color: white;margin: 5px;">List Inquiry</button>
            <button onclick='openBoxDraggable("index.cfm?fuseaction=sale.emptypopup_hrz_pbs_sayfa2")' style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #cbbf22;border-radius: 10px;background: #fff02aa8;font-weight: bold;color: white;margin: 5px;">Add Inquiry </button>
            <button onclick='openBoxDraggable("index.cfm?fuseaction=sales.emptypopup_list_virtual_products")' style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #11511f;border-radius: 10px;background: #21b141a8;font-weight: bold;color: white;margin: 5px;">List Waiting Virtual Products </button>
            <hr>
            <button onclick="window.location.href='/index.cfm?fuseaction=sale.list_vessels'" style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #ffa500;border-radius: 10px;background: #ffa5005c;color: white;font-weight: bold;margin: 5px;">List Vessels</button>            
            <button onclick='openBoxDraggable("index.cfm?fuseaction=objects.emptypopup_add_vessel")' style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #874444;border-radius: 10px;background: #ff828294;font-weight: bold;color: white;margin: 5px;">Add Vessel</button>
            <button onclick='openBoxDraggable("index.cfm?fuseaction=objects.emptypopup_add_catalog_pbs")' style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #ff8300;border-radius: 10px;background: #ff830075;font-weight: bold;color: white;margin: 5px;">Add Catalog</button>
           <!--- --->
           <hr>
           <button onclick="window.location.href='/index.cfm?fuseaction=purchase.emptypopup_list_offer_pbs'" style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #ab00ff;border-radius: 10px;background: #ab00ff5c;color: white;font-weight: bold;margin: 5px;">List Purchase Offer</button>            
        </div>
    </cf_box>
    </div>
    <div class="col col-10">      
    <cf_box>
        <div style="display:flex;height:100vh">
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