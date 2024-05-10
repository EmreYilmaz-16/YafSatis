
<cfset ShipService=createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>
<cfset _MachineArr=ShipService.listMachines(attributes.WESSEL_ID)>
<cfset MachineArr=deserializeJSON(_MachineArr)>
<cfset _Ship=ShipService.GetShips(ShipId=attributes.WESSEL_ID)>
<cfset Ship=deserializeJSON(_Ship)>

<cf_box title="#Ship[1].SHIP_NAME# - Makina Ekle" scroll="1" collapsable="1" resize="1" popup_box="1">
    
    <cfloop array="#MachineArr#" item="it" index="x">
        <cf_seperator title="#it2.PRODUCT_CAT#" id="item_#x#">
            <div class="ui-info-text" id="item_<cfoutput>#x#</cfoutput>"  style="display:none;">
                <cf_grid_list>
                    <thead>
                        <tr>
                            <th>
                                Machine Name
                            </th>
                            <th>
                                Serial No
                            </th>
                            <th>
                                Description
                            </th>
                        </tr>
                    </thead>
                    <cfoutput>
                        
                <cfloop array="#it2.MACHINEARR#">
                    <tr>
                        <td>
                            #MACHINE_NAME#     
                        </td>
                        <td>
                            #SERIAL_NO#
                        </td>
                        <td>
                            #DESCRIPTION#
                        </td>
                    </tr>
                </cfloop>
            </cfoutput>
            </cf_grid_list>
            </div>
    </cfloop>


</cf_box>