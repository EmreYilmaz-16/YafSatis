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

<cfif session ep.user_id eq 9>
<style>
    /* Google Fonts Import Link */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
*{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}
.sidebar{
  position: fixed;
  top: 0;
  left: 0;
  height: 100%;
  width: 260px;
  background: #11101d;
  z-index: 100;
  transition: all 0.5s ease;
}
.sidebar.close{
  width: 78px;
}
.sidebar .logo-details{
  height: 60px;
  width: 100%;
  display: flex;
  align-items: center;
}
.sidebar .logo-details i{
  font-size: 30px;
  color: #fff;
  height: 50px;
  min-width: 78px;
  text-align: center;
  line-height: 50px;
}
.sidebar .logo-details .logo_name{
  font-size: 22px;
  color: #fff;
  font-weight: 600;
  transition: 0.3s ease;
  transition-delay: 0.1s;
}
.sidebar.close .logo-details .logo_name{
  transition-delay: 0s;
  opacity: 0;
  pointer-events: none;
}
.sidebar .nav-links{
  height: 100%;
  padding: 30px 0 150px 0;
  overflow: auto;
}
.sidebar.close .nav-links{
  overflow: visible;
}
.sidebar .nav-links::-webkit-scrollbar{
  display: none;
}
.sidebar .nav-links li{
  position: relative;
  list-style: none;
  transition: all 0.4s ease;
}
.sidebar .nav-links li:hover{
  background: #1d1b31;
}
.sidebar .nav-links li .iocn-link{
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.sidebar.close .nav-links li .iocn-link{
  display: block
}
.sidebar .nav-links li i{
  height: 50px;
  min-width: 78px;
  text-align: center;
  line-height: 50px;
  color: #fff;
  font-size: 20px;
  cursor: pointer;
  transition: all 0.3s ease;
}
.sidebar .nav-links li.showMenu i.arrow{
  transform: rotate(-180deg);
}
.sidebar.close .nav-links i.arrow{
  display: none;
}
.sidebar .nav-links li a{
  display: flex;
  align-items: center;
  text-decoration: none;
}
.sidebar .nav-links li a .link_name{
  font-size: 18px;
  font-weight: 400;
  color: #fff;
  transition: all 0.4s ease;
}
.sidebar.close .nav-links li a .link_name{
  opacity: 0;
  pointer-events: none;
}
.sidebar .nav-links li .sub-menu{
  padding: 6px 6px 14px 80px;
  margin-top: -10px;
  background: #1d1b31;
  display: none;
}
.sidebar .nav-links li.showMenu .sub-menu{
  display: block;
}
.sidebar .nav-links li .sub-menu a{
  color: #fff;
  font-size: 15px;
  padding: 5px 0;
  white-space: nowrap;
  opacity: 0.6;
  transition: all 0.3s ease;
}
.sidebar .nav-links li .sub-menu a:hover{
  opacity: 1;
}
.sidebar.close .nav-links li .sub-menu{
  position: absolute;
  left: 100%;
  top: -10px;
  margin-top: 0;
  padding: 10px 20px;
  border-radius: 0 6px 6px 0;
  opacity: 0;
  display: block;
  pointer-events: none;
  transition: 0s;
}
.sidebar.close .nav-links li:hover .sub-menu{
  top: 0;
  opacity: 1;
  pointer-events: auto;
  transition: all 0.4s ease;
}
.sidebar .nav-links li .sub-menu .link_name{
  display: none;
}
.sidebar.close .nav-links li .sub-menu .link_name{
  font-size: 18px;
  opacity: 1;
  display: block;
}
.sidebar .nav-links li .sub-menu.blank{
  opacity: 1;
  pointer-events: auto;
  padding: 3px 20px 6px 16px;
  opacity: 0;
  pointer-events: none;
}
.sidebar .nav-links li:hover .sub-menu.blank{
  top: 50%;
  transform: translateY(-50%);
}

.one {
  width: 80%;
  margin-left: 10%;
  background-color: black;
  height: 400px;
}

.sidebar .profile-details{
  position: fixed;
  bottom: 0;
  width: 260px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: #1d1b31;
  padding: 12px 0;
  transition: all 0.5s ease;
}
.sidebar.close .profile-details{
  background: none;
}
.sidebar.close .profile-details{
  width: 78px;
}
.sidebar .profile-details .profile-content{
  display: flex;
  align-items: center;
}
.sidebar .profile-details img{
  height: 52px;
  width: 52px;
  object-fit: cover;
  border-radius: 16px;
  margin: 0 14px 0 12px;
  background: #1d1b31;
  transition: all 0.5s ease;
}
.sidebar.close .profile-details img{
  padding: 10px;
}
.sidebar .profile-details .profile_name,
.sidebar .profile-details .job{
  color: #fff;
  font-size: 18px;
  font-weight: 500;
  white-space: nowrap;
}
.sidebar.close .profile-details i,
.sidebar.close .profile-details .profile_name,
.sidebar.close .profile-details .job{
  display: none;
}
.sidebar .profile-details .job{
  font-size: 12px;
}
.home-section{
  position: relative;
  background: #E4E9F7;
  height: 100vh;
  left: 260px;
  width: calc(100% - 260px);
  transition: all 0.5s ease;
}
.sidebar.close ~ .home-section{
  left: 78px;
  width: calc(100% - 78px);
}
.home-section .home-content{
  height: 60px;
  display: flex;
  align-items: center;
}
.home-section .home-content .bx-menu,
.home-section .home-content .text{
  color: #11101d;
  font-size: 35px;
}
.home-section .home-content .bx-menu{
  margin: 0 15px;
  cursor: pointer;
}
.home-section .home-content .text{
  font-size: 26px;
  font-weight: 600;
}
@media (max-width: 420px) {
  .sidebar.close .nav-links li .sub-menu{
    display: none;
  }
}
<cfabort>
</style>
  <div class="sidebar close">
    <div class="logo-details">
      <i class='bx bxl-c-plus-plus'></i>
      <span class="logo_name">CodingLab</span>
    </div>
    <ul class="nav-links">
      <li>
        <a href="#">
          <i class='bx bx-grid-alt' ></i>
          <span class="link_name">Dashboard</span>
        </a>
        <ul class="sub-menu blank">
          <li><a class="link_name" href="#">Category</a></li>
        </ul>
      </li>
      <li>
        <div class="iocn-link">
          <a href="#">
            <i class='bx bx-collection' ></i>
            <span class="link_name">Category</span>
          </a>
          <i class='bx bxs-chevron-down arrow' ></i>
        </div>
        <ul class="sub-menu">
          <li><a class="link_name" href="#">Category</a></li>
          <li><a href="#">HTML & CSS</a></li>
          <li><a href="#">JavaScript</a></li>
          <li><a href="#">PHP & MySQL</a></li>
        </ul>
      </li>
      <li>
        <div class="iocn-link">
          <a href="#">
            <i class='bx bx-book-alt' ></i>
            <span class="link_name">Posts</span>
          </a>
          <i class='bx bxs-chevron-down arrow' ></i>
        </div>
        <ul class="sub-menu">
          <li><a class="link_name" href="#">Posts</a></li>
          <li><a href="#">Web Design</a></li>
          <li><a href="#">Login Form</a></li>
          <li><a href="#">Card Design</a></li>
        </ul>
      </li>
      <li>
        <a href="#">
          <i class='bx bx-pie-chart-alt-2' ></i>
          <span class="link_name">Analytics</span>
        </a>
        <ul class="sub-menu blank">
          <li><a class="link_name" href="#">Analytics</a></li>
        </ul>
      </li>
      <li>
        <a href="#">
          <i class='bx bx-line-chart' ></i>
          <span class="link_name">Chart</span>
        </a>
        <ul class="sub-menu blank">
          <li><a class="link_name" href="#">Chart</a></li>
        </ul>
      </li>
      <li>
        <div class="iocn-link">
          <a href="#">
            <i class='bx bx-plug' ></i>
            <span class="link_name">Plugins</span>
          </a>
          <i class='bx bxs-chevron-down arrow' ></i>
        </div>
        <ul class="sub-menu">
          <li><a class="link_name" href="#">Plugins</a></li>
          <li><a href="#">UI Face</a></li>
          <li><a href="#">Pigments</a></li>
          <li><a href="#">Box Icons</a></li>
        </ul>
      </li>
      <li>
        <a href="#">
          <i class='bx bx-compass' ></i>
          <span class="link_name">Explore</span>
        </a>
        <ul class="sub-menu blank">
          <li><a class="link_name" href="#">Explore</a></li>
        </ul>
      </li>
      <li>
        <a href="#">
          <i class='bx bx-history'></i>
          <span class="link_name">History</span>
        </a>
        <ul class="sub-menu blank">
          <li><a class="link_name" href="#">History</a></li>
        </ul>
      </li>
      <li>
        <a href="#">
          <i class='bx bx-cog' ></i>
          <span class="link_name">Setting</span>
        </a>
        <ul class="sub-menu blank">
          <li><a class="link_name" href="#">Setting</a></li>
        </ul>
      </li>
      <li>
    <div class="profile-details">
      <div class="profile-content">
        <!--<img src="image/profile.jpg" alt="profileImg">-->
      </div>
      <div class="name-job">
        <div class="profile_name">Prem Shahi</div>
        <div class="job">Web Desginer</div>
      </div>
      <i class='bx bx-log-out' ></i>
    </div>
  </li>
</ul>
  </div>
  <section class="home-section">
    <div class="home-content">
      <i class='bx bx-menu' ></i>
      <span class="text">Drop Down Sidebar</span>
    </div>
  </section>
  
  <div class="one"></div>
  <script>
  let arrow = document.querySelectorAll(".arrow");
  for (var i = 0; i < arrow.length; i++) {
    arrow[i].addEventListener("click", (e)=>{
   let arrowParent = e.target.parentElement.parentElement;//selecting main parent of arrow
   arrowParent.classList.toggle("showMenu");
    });
  }
  let sidebar = document.querySelector(".sidebar");
  let sidebarBtn = document.querySelector(".bx-menu");
  console.log(sidebarBtn);
  sidebarBtn.addEventListener("click", ()=>{
    sidebar.classList.toggle("close");
  });
  </script>


</cfif>

<div class="row">         
   
    <div class="col col-2">
<cf_box>
        <div style="display:flex;flex-direction: column;height:100vh">
            <button onclick="window.open('/index.cfm?fuseaction=myhome.welcome','_blank')" style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #305505;border-radius: 10px;background: #3f6a0e52;font-weight: bold;color: white;margin: 5px;">W3 Ana Sayfa</button>
            <hr>
            <button onclick="window.open('/index.cfm?fuseaction=sale.hrz_pbs_sayfa1','_blank')" style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #096cc5;border-radius: 10px;background: #82c4ffa1;font-weight: bold;color: white;margin: 5px;">List Inquiry</button>
            <button onclick='openBoxDraggable("index.cfm?fuseaction=sale.emptypopup_hrz_pbs_sayfa2")' style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #cbbf22;border-radius: 10px;background: #fff02aa8;font-weight: bold;color: white;margin: 5px;">Add Inquiry </button>
            <button onclick='openBoxDraggable("index.cfm?fuseaction=sales.emptypopup_list_virtual_products")' style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #11511f;border-radius: 10px;background: #21b141a8;font-weight: bold;color: white;margin: 5px;">List Waiting Virtual Products </button>
            <hr>
            <button onclick="window.open('/index.cfm?fuseaction=sale.list_vessels','_blank')" style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #ffa500;border-radius: 10px;background: #ffa5005c;color: white;font-weight: bold;margin: 5px;">List Vessels</button>            
            <button onclick='openBoxDraggable("index.cfm?fuseaction=objects.emptypopup_add_vessel")' style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #874444;border-radius: 10px;background: #ff828294;font-weight: bold;color: white;margin: 5px;">Add Vessel</button>
               <!---  <button onclick='openBoxDraggable("index.cfm?fuseaction=objects.emptypopup_add_catalog_pbs")' style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #ff8300;border-radius: 10px;background: #ff830075;font-weight: bold;color: white;margin: 5px;">Add Catalog</button>
       --->
           <hr>
           <button onclick="window.open('/index.cfm?fuseaction=purchase.emptypopup_list_offer_pbs','_blank')" style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #ab00ff;border-radius: 10px;background: #ab00ff5c;color: white;font-weight: bold;margin: 5px;">List Purchase Offer</button>            
           <hr>
           <button onclick='window.open("index.cfm?fuseaction=report.detail_product_report_PBS","_blank")' style="font-size: 14pt;padding: 20px;width: 100%;border: solid 1px #ff8300;border-radius: 10px;background: #ff830075;font-weight: bold;color: white;margin: 5px;">Detaylı Ürün Raporu</button>
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