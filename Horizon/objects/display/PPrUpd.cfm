<div style="padding:10px">
<cf_box>
    <cfset Data=deserializeJSON(attributes.FormData)>
    <cf_grid_list>
        <tr>
            <th>
                Fiyat
            </th>
            <td>
                <cfoutput><input type="text" readonly value="#Data.f1#"> <span class="input-group-addon">#data.m_1#</span></cfoutput>
            </td>

        </tr>
        <tr>
            <th>
                Fiyat <cfoutput>#data.m_2#</cfoutput>
            </th>
            <td>
                <div class="form-group">
                    <div class="input-group">
                        <cfoutput><input type="text" value="#Data.f2#"> <span class="input-group-addon">#data.m_2#</span></cfoutput>
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
                        <cfoutput><input type="text" value="#Data.fm#"> <span class="input-group-addon">%</span></cfoutput>
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
                        <cfoutput><input type="text" value="#Data.f3#"><span class="input-group-addon">#data.m_2#</span></cfoutput>
                    </div>
                </div>
            </td>
            
        </tr>
    </cf_grid_list>
    <hr>
    <button onclick="closeBoxDraggable('<cfoutput>#attributes.modal_id#</cfoutput>')">Kapat</button>
</cf_box>
<cfdump var="#attributes#">


</div>