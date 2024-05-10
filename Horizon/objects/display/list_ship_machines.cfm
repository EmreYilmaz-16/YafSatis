
<cfparam name="attributes.cat_id" default="">
<cfset ShipService=createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>
<cfset _MachineArr=ShipService.listMachines(attributes.WESSEL_ID,attributes.cat_id)>
<cfset MachineArr=deserializeJSON(_MachineArr)>
<cfset _Ship=ShipService.GetShips(ShipId=attributes.WESSEL_ID)>
<cfset Ship=deserializeJSON(_Ship)>

<cf_box title="#Ship[1].SHIP_NAME# - Makina Listesi" scroll="1" collapsable="1" resize="1" popup_box="1">
    
    <cfloop array="#MachineArr#" item="it2" index="x">
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
                           <cfif not len(attributes.cat_id)> <th>
                                <a onclick="openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_add_ship_machine&WESSEL_ID=<cfoutput>#attributes.WESSEL_ID#</cfoutput>')" href="javascript://"><span class="icn-md fa fa-plus"></span></a>
                            </th>
                        </cfif>
                        </tr>
                    </thead>
                    <cfoutput>
                        
                <cfloop array="#it2.MACHINEARR#" item="it" index="y">
                    <tr>
                        <td>
                            <cfif not len(attributes.cat_id)>
                            #it.MACHINE_NAME#     
                            <cfelse>
                                <a href="javascript://" onclick="AddEQRZ(#it.SM_ID#,'#attributes.modal_id#')">#it.MACHINE_NAME#</a>
                            </cfif>
                        </td>
                        <td>
                            #it.SERIAL_NO#
                        </td>
                        <td>
                            #it.DESCRIPTION#
                        </td>
                        <cfif not len(attributes.cat_id)>
                        <td>
                            <a href="javascript://"><span class="icn-md fa fa-edit"></span></a>
                            <a  href="javascript://"><span class="icn-md fa fa-list-alt"></span></a>
                            <a onclick="openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_add_machine_props&WESSEL_ID=<cfoutput>#attributes.WESSEL_ID#</cfoutput>&SM_ID=<cfoutput>#it.SM_ID#</cfoutput>')"  href="javascript://"><span class="icn-md fa fa-plus"></span></a>
                        </td>
                    </cfif>
                    </tr>
                </cfloop>
            </cfoutput>
            </cf_grid_list>
            </div>
    </cfloop>


</cf_box>

<script>
    function AddEQRZ(SM_ID,modal_id) {
        var rs = $.post(
      ServiceUri +
        "/OfferService.cfc?method=getShipFilters&SHIP_ID=" +
        WESSEL_ID +
        "&PRODUCT_CATID=" +
        cat_id+
        "&SM_ID="+SM_ID
    ).done(function (ReturnData) {
      var TV = JSON.parse(ReturnData);
      addEqRow(TV.JSON_STRINGIM, JSON.stringify(TV.JSON_STRINGIM));
      closeBoxDraggable(modal_id);
    }
)
    }
</script>  