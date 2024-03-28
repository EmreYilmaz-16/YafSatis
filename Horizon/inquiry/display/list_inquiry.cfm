<div class="row">         
    <div class="col col-2">
        <div style="display:flex;flex-direction: column;">
            <button style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #ffa500;border-radius: 10px;background: #ffa5005c;color: white;font-weight: bold;margin: 5px;">List Vessels</button>
            <button style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #096cc5;border-radius: 10px;background: #82c4ffa1;font-weight: bold;color: white;margin: 5px;">List Inquiry</button>
        </div>
    </div>
    <div class="col col-10">                    
        <div style="width:33%">
            <canvas id="myChart"></canvas>
        </div>
        <div style="width:33%">
            <canvas id="myChart2"></canvas>
        </div>
        <div style="width:33%">
            <canvas id="myChart3"></canvas>
        </div>
    </div>                        
 </div>

 <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

 <script> 
 $(document).ready(function(){
    MainT();
    TT1();
    TT2();
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
}

new Chart(ctx, config);
 }
 </script>