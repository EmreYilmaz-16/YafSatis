var ServiceUri = "/AddOns/YafSatis/Partner/cfc";
$(document).ready(function () {
  var e = document.getElementById("PRODUCT_CAT");
  // var e1 = document.getElementById("MONEY");
  // var e2 = document.getElementById("PRIORITY");
  getCats(e);
});
function getCats(el) {
  $.ajax({
    url: ServiceUri + "/ProductService.cfc?method=getCats",
    success: function (returnData) {
      var Obje = JSON.parse(returnData);
      console.log(Obje);
      $(el).html("");
      for (let i = 0; i < Obje.length; i++) {
        var option = document.createElement("option");
        option.value = Obje[i].PRODUCT_CATID;
        option.innerText = Obje[i].PRODUCT_CAT;
        el.appendChild(option);
      }
    },
  });
}
function getCatProperties(cat_id) {
  /* $.ajax({
        url: ServiceUri + "/ProductService.cfc?method=getCatProperties&PRODUCT_CATID="+cat_id,
        success: function (returnData) {
          var Obje = JSON.parse(returnData);
          console.log(Obje);
          $(el).html("");
          for (let i = 0; i < Obje.length; i++) {
            var option = document.createElement("option");
            option.value = Obje[i].PRODUCT_CATID;
            option.innerText = Obje[i].PRODUCT_CAT;
            el.appendChild(option);
          }
        },
      });*/

  AjaxPageLoad(
    "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=catProps&PRODUCT_CATID=" +
      cat_id,
    "PROP_AREA",
    1,
    "Yükleniyor"
  );
}

function AddEquipment() {
  var elem = document.getElementById("PRODUCT_CAT");
  var ix = elem.options.selectedIndex;
  var PRODUCT_CAT = elem.options[ix].innerText;
  var PRODUCT_CAT_ID = elem.options[ix].value;

  var ReturnObject = { PRODUCT_CAT: PRODUCT_CAT, PRODUCT_CAT_ID: PRODUCT_CAT_ID };
  console.table(ReturnObject);
  var SelectedValues = [];
  
  var Properties = document.getElementsByClassName("propss");
  var PropList="";
  //console.log(Properties)
  for (let i = 0; i < Properties.length; i++) {
    var Pelem = Properties[i];
    var Pdata = $(Pelem).select2("data")[0];
    console.log($(Pelem).select2("data")[0]);
    var PRODUCT_CAT = Pdata.text;
    var PRODUCT_CAT_ID = Pdata.id;
    var PNAME=Pdata.title
    if (Pdata.id.length > 0) {
      var O = { PRODUCT_CAT: PRODUCT_CAT, PRODUCT_CAT_ID: PRODUCT_CAT_ID,PNAME:PNAME };
      console.table(O);
      SelectedValues.push(O);
      PropList+=","+PRODUCT_CAT_ID;
    }
  }
  ReturnObject.Filters=SelectedValues;
  ReturnObject.PropList=PropList;
  var jsn = JSON.stringify(ReturnObject);
  addEqRow(ReturnObject,jsn);
}
var EqArr=[];

function addEqRow(Obj,jsn){
  var div=document.createElement("div");
  div.setAttribute("class","alert alert-success eq_header")
  div.setAttribute("data-PropList",Obj.PropList);
  var table=document.createElement("table");
  table.setAttribute("class","EqTableMain")
  var tr=document.createElement("tr");
  var td=document.createElement("td");
  var b1=document.createElement("button")
  b1.innerText="A"
  var b2=document.createElement("button")
  b2.innerText="A"
  var b3=document.createElement("button")
  b3.innerText="A"
  var b4=document.createElement("button")
  b4.innerText="A"
  var b5=document.createElement("button")
  b5.innerText="A"
  var diva= document.createElement("div")
  diva.setAttribute("style","display:flex");
  diva.appendChild(b1)
  diva.appendChild(b2)
  diva.appendChild(b3)
  diva.appendChild(b4)
  diva.appendChild(b5);
  td.appendChild(diva);
  tr.appendChild(td);
  for (let index = 0; index < Obj.Filters.length; index++) {
    const element = Obj.Filters[index];
    var td=document.createElement("td");
    td.setAttribute("style","border-right:solid 1px")
    var spnT="<span style='font-weight:bold'>"+element.PNAME+"</span></br><span>"+element.PRODUCT_CAT+"</span>"
    td.innerHTML=spnT;
    tr.appendChild(td);
  }
  table.appendChild(tr);
  div.appendChild(table);
  document.getElementById("BasketArea").appendChild(div);
}

/*
 <div class="alert alert-success eq_header">
    <table style="
    text-align: center;
    width: 100%;
">
        <tbody><tr>
<td style="
    text-align: left;
">
    <button class="btn btn-danger">A</button>
<button class="btn btn-danger">B</button>
<button class="btn btn-danger">C</button>
<button class="btn btn-danger">D</button>
<button class="btn btn-danger">D</button></td>
            
        <td style="
    border-right: solid 1px;
    width: 8%;
">
    <span style="font-weight:bold">Equipment</span>
<br>    
        <span>Main Engine</span>
    
            
        </td><td style="
    border-right: solid 1px;
    width: 8%;
">
    <span style="font-weight:bold">Brand</span>
<br>    
        <span>Wartsilla</span>
    
            
        </td><td style="
    border-right: solid 1px;
    width: 8%;
">
    <span style="font-weight:bold">Type</span>
<br>    
        <span>M32</span>
    
            
        </td><td style="
    border-right: solid 1px;
    width: 8%;
">
    <span style="font-weight:bold">Cylinder</span>
<br>    
        <span>8</span>
    
            
        </td>
<td style="
    width: 60%;
"></td></tr>
    
    </tbody></table>
<table class="table">
</table>
</div>

*/