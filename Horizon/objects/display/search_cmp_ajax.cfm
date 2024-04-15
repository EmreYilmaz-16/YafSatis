<cfquery name="getcmp" datasource="#dsn#">
    SELECT TOP 20 * FROM COMPANY  WHERE 1=1 
    <CFIF isDefined("ATTRIBUTES.KEYWORD") and len(attributes.KEYWORD) gte 3>
        AND (
            NICKNAME LIKE '%#attributes.KEYWORD#%' OR
            FULLNAME  LIKE '%#attributes.KEYWORD#%' OR
            MEMBER_CODE  LIKE '%#attributes.KEYWORD#%'
        )
    </CFIF>
</cfquery>

<cf_grid_list>
    <thead>
        <tr>
            <th></th>
            <th>Member Code</th>
            <th>Consumer</th>
        </tr>
    </thead>
    <tbody>
        <cfoutput query="getcmp">
        <tr>
            <td>
                <input type="checkbox" name="comp_sel_cb" id="comp_sel_cb" value="#COMPANY_ID#">
            </td>
            <TD>
                #MEMBER_CODE#
            </TD>
            <td>
                #NICKNAME#
            </td>
        </tr>
    </cfoutput>
    </tbody>
</cf_grid_list>