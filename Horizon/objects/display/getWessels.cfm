
<input type="text" onkeyup="GetShips()">

<cf_ajax_list>
    <thead>
        <tr>
            <th>
                Gemi 
            </th>
            <th>
                Modeli
            </th>           
        </tr>
    </thead>
    <tbody id="ShipList">
        
    </tbody>
</cf_ajax_list>

<script>
var ServiceUri="/AddOns/YafSatis/Partner/cfc"
var CustomerId="<cfoutput>#attributes.CustomerId#</cfoutput>"
    $(document).ready(function () {
        $.ajax({
            url:ServiceUri+"/ShipService.cfc?method=GetShips&CustomerId="+CustomerId+"&ShipStatus=1",
            success:function (returnData) {
                var Gemiler=JSON.parse(returnData);
                for (let i = 0; i < Gemiler.length; i++) {
                    const Gemi = Gemiler[i];

                    var tr=document.createElement("tr");
                    var td=document.createElement("td");
                    var a=document.createElement("a");
                    a.innerText=Gemi.SHIP_NAME;
                    a.setAttribute("onclick","setShip("+Gemi.SHIP_ID+",'"+Gemi.SHIP_NAME+"')")
                    a.href="#"
                    td.appendChild(a);
                    tr.appendChild(td);
                    var td=document.createElement("td");
                    td.innerText=Gemi.BUILD_YEAR
                    tr.appendChild(td);
                    document.getElementById("ShipList").appendChild(tr);
                }
            }
        })
    })
    function GetShips(el) {
        var kv=el.value;
        var liste=document.getElementById("ShipList")
        $(liste).html("");
        if(kv.length>3){
            $.ajax({
            url:ServiceUri+"/ShipService.cfc?method=GetShips&CustomerId="+CustomerId+"&ShipStatus=1&Keyword="+kv,
            success:function (returnData) {
                var Gemiler=JSON.parse(returnData);
                for (let i = 0; i < Gemiler.length; i++) {
                    const Gemi = Gemiler[i];

                    var tr=document.createElement("tr");
                    var td=document.createElement("td");
                    var a=document.createElement("a");
                    a.innerText=Gemi.SHIP_NAME;
                    a.setAttribute("onclick","setShip("+Gemi.SHIP_ID+",'"+Gemi.SHIP_NAME+"')")
                    a.href="#"
                    td.appendChild(a);
                    tr.appendChild(td);
                    var td=document.createElement("td");
                    td.innerText=Gemi.BUILD_YEAR
                    tr.appendChild(td);
                    liste.appendChild(tr);
                }
            }
        })
        }
    }
    function setShip(id,name) {
        $("#ship_name").val(name);
        $("#ship_id").val(id);
        closeBoxDraggable("<cfoutput>#attributes.modal_id#</cfoutput>")
    }
</script>



