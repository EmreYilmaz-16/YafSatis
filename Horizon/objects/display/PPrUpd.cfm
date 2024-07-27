<cf_box>
    <cfset Data=deserializeJSON(attributes.FormData)>
    <cf_grid_list>
        <tr>
            <th>
                Fiyat
            </th>
            <td>
                <cfoutput>#Data.f1# #data.m_1#</cfoutput>
            </td>

        </tr>
        <tr>
            <th>
                Fiyat <cfoutput>#data.m_2#</cfoutput>
            </th>
            <td>
                <cfoutput><input type="text" value="#Data.f2#"> #data.m_2#</cfoutput>
            </td>
            
        </tr>
        <tr>
            <th>
                Marj
            </th>
            <td>
                <cfoutput><input type="text" value="#Data.fm#"> </cfoutput>
            </td>
            
        </tr>
        <tr>
            <th>
                Toplam <cfoutput>#data.m_2#</cfoutput>
            </th>
            <td>
                <cfoutput><input type="text" value="#Data.f3#"> #data.m_2#</cfoutput>
            </td>
            
        </tr>
    </cf_grid_list>
</cf_box>
<cfdump var="#attributes#">

