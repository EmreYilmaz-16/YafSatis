<div style="padding:10px">
<cf_box>
    <cfset Data=deserializeJSON(attributes.FormData)>
    <cf_grid_list>
        <tr>
            <th>
                Fiyat
            </th>
            <td>
                <div class="form-group">
                    <div class="input-group">
                        <cfoutput><input type="text" readonly value="#Data.f1#"> <span class="input-group-addon">#data.m_1#</span></cfoutput>
                    </div>
                </div>
            </td>

        </tr>
        <tr>
            <th>
                Fiyat <cfoutput>#data.m_2#</cfoutput>
            </th>
            <td>
                <div class="form-group">
                    <div class="input-group">
                        <cfoutput><input readonly id="ff1" type="text" value="#Data.f2#"> <span class="input-group-addon">#data.m_2#</span></cfoutput>
                    </div>
                </div>
            </td>
            
        </tr>
        <tr>
            <th>
                Marj
            </th>
            <td>
                <div class="form-group">
                    <div class="input-group">
                        <cfoutput><input type="text" id="fmm1" onchange="InnerMarjHesapla()" value="#Data.fm#"> <span class="input-group-addon">%</span></cfoutput>
                    </div>
                </div>
            </td>
            
        </tr>
        <tr>
            <th>
                Toplam <cfoutput>#data.m_2#</cfoutput>
            </th>
            <td>
                <div class="form-group">
                    <div class="input-group">
                        <cfoutput><input id="ff3" readonly type="text" value="#Data.f3#"><span class="input-group-addon">#data.m_2#</span></cfoutput>
                    </div>
                </div>
            </td>
            
        </tr>
    </cf_grid_list>
    <hr>
    <button onclick="closeBoxDraggable('<cfoutput>#attributes.modal_id#</cfoutput>')">Kapat</button>
    <button onclick="savethsss(<cfoutput>#data.offer_id#,'#data.wrkrowid#','#attributes.modal_id#'</cfoutput>)">Kaydet</button>
</cf_box>
<script>
$(document).ready(function(){
    var e=$("#fmm1")[0]
    InnerMarjHesapla(e)
})
    function InnerMarjHesapla(el) {
        var mrj=el.value;
        var pr_=$("#ff1").val();
        var pr=filterNum(pr_);
        pr=parseFloat(pr);
        mrj=parseFloat(mrj);
        var tfe=pr+((pr*mrj)/100)
        $("#ff3").val(commaSplit(tfe))

    }
    function savethsss(oid,wrkrw,mdl) {
        
        var mr=$("#fmm1").val();
        var wrkrw="PBS120240703073756232Z";
    var ef=document.getElementByOfferId(oid)
for(let i=0;i<ef.length;i++){
    var e=ef[i];
    var wrk=e.getAttribute("data-wrk");
    if(wrkrw==wrk){
    console.log(e.getAttribute("data-wrk"))
    //$(e).find("span[name='F3']").text(commaSplit(FiyN, 2));
    $(e).find("span[name='FM']").text(commaSplit(mr, 2));
    } 
}
closeBoxDraggable(mdl)    
    }
</script>


</div>