<cf_box title="Vessel Detail" scroll="1" collapsable="1" resize="1" popup_box="1">
<cfset ShipService = createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>
<cfset ShipTypes_=ShipService.getShipTypes()>
<cfset ShipList_=ShipService.GetShips(ShipId:attributes.ShipId)>
<cfset ShipTypes=deserializeJSON(ShipTypes_)>
<cfset ShipList=deserializeJSON(ShipList_)>
<cfset GEMI=ShipList[1]>

<cfoutput>


   <div style="text-align:center;color:green;font-weight:bold;font-size:14pt;padding: 10px;border: solid 1px green;margin-bottom: 5px;">
            #GEMI.SHIP_NAME#
    </div>
        
    <cf_big_list style="width:100%">
    <tr>
        <td style="font-weight:bold">Build Year</td>
        <td>:#GEMI.BUILD_YEAR#</td>
        <td style="font-weight:bold">Ship Type</td>
        <td>:#GEMI.SHIP_TYPE#</td>
        <td style="font-weight:bold">Class</td>
        <td>:#GEMI.CLASS#</td>
    </tr>
</cf_big_list>
    <cf_big_list>
    <thead>
    <tr>
        <th>Gross Tonnage</th>
        <th>Dead Weight Tonnage</th>
        <th>Width</th>
        <th>LENGTH</th>
    </tr>
</thead>

    <tr>
        <td style="font-size:12pt !important;text-align:center">#tlformat(GEMI.GROSS_TONNAGE)#</td>
        <td style="font-size:12pt !important;text-align:center">#tlformat(GEMI.DEAD_WEIGHT_TONNAGE)#</td>
        <td style="font-size:12pt !important;text-align:center">#tlformat(GEMI.WIDTH)#</td>
        <td style="font-size:12pt !important;text-align:center">#tlformat(GEMI.LENGTH)#</td>
    </tr>
</cf_big_list>
<cf_big_list>
    <thead>
    <tr>
        <th >
            Customer
        </th>
        <th >
            Care Of
        </th>
    </tr>
</thead>
    <tr>
        <td style="width:50%">
            <cf_big_list>
                <tr>                    
                    <td colspan="3">
                        #GEMI.CUSTOMER_FULLNAME#
                    </td>
                    
                </tr>
                <tr style="text-align:center">
                    <td>
                        <b style="width:100%;display:block">Contact Person</b>
                        #GEMI.CUSTOMER_NAME# #GEMI.CUSTOMER_SURNAME#
                    </td>
                    <td>
                        <b style="width:100%;display:block">Ship Phone</b>
                        #GEMI.CUSTOMER_TELCODE# #GEMI.CUSTOMER_TEL#
                    </td>
                    <td>
                        <b style="width:100%;display:block">Ship Mail</b>
                        #GEMI.CUSTOMER_MAIL# 
                    </td>
                    
                </tr>
                <tr style="height: 60px;">
                    <td colspan="3" >
                        <b style="width:100%;display:block">Address</b>
                        #GEMI.CUSTOMER_ADRESS#
                    </td>
                </tr>
            </cf_big_list>
        </td>
        <td style="width:50%">
            <cf_big_list>
                <tr>                    
                    <td colspan="3">
                        #GEMI.CARE_OF_FULLNAME#
                    </td>
                    
                </tr>
                <tr style="text-align:center">
                    <td>
                        <b style="width:100%;display:block">Contact Person</b>
                        #GEMI.CARE_OF_NAME# #GEMI.CARE_OF_SURNAME#
                    </td>
                    <td>
                        <b style="width:100%;display:block">Ship Phone</b>
                        #GEMI.CARE_OF_TELCODE# #GEMI.CARE_OF_TEL#
                    </td>
                    <td>
                        <b style="width:100%;display:block">Ship Mail</b>
                        #GEMI.CARE_OF_MAIL# 
                    </td>
                </tr>
                <tr style="height: 60px;">
                    <td colspan="3" >
                        <b style="width:100%;display:block">Address</b>
                        #GEMI.CARE_OF_ADRESS#
                    </td>
                </tr>
            </cf_big_list>
        </td>
    </tr>
</cf_big_list>
<cf_big_list>
    <thead>
        <tr>
            <th>
                IMO Number
            </th>
            <th>
                Hull Number
            </th>
            <th>
                Ship Yard
            </th>
            <th>
                Flag
            </th>
        </tr>
        
    </thead>
    <tr>
        <td>#GEMI.IMO_NUMBER#</td>
        <td>#GEMI.HULL_NUMBER#</td>
        <td>#GEMI.SHIP_YARD#</td>
        <td>#GEMI.FLAG#</td>
    </tr>
</cf_big_list>

</cfoutput>

<a onclick="openBoxDraggable('index.cfm?fuseaction=sale.emptypopup_change_vessel_customer&ShipId=<cfoutput>#attributes.ShipId#</cfoutput>')" class="ui-wrk-btn ui-wrk-btn-warning ui-wrk-btn-addon-left"><span class="icn-md icon-exchange"></span>Transfer Ship</a>
<a onclick="openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_add_ship_machine&WESSEL_ID=<cfoutput>#attributes.ShipId#</cfoutput>')" class="ui-wrk-btn ui-wrk-btn-warning ui-wrk-btn-addon-left"><span class="icn-md icon-settings"></span>Add Machine</a>
<a onclick="openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_list_ship_machine&WESSEL_ID=<cfoutput>#attributes.ShipId#</cfoutput>')" class="ui-wrk-btn ui-wrk-btn-warning ui-wrk-btn-addon-left"><span class="icn-md fa fa-database"></span>List Machines</a>
<!----<a onclick="openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_list_ship_catalogs&WESSEL_ID=<cfoutput>#attributes.ShipId#</cfoutput>')" class="ui-wrk-btn ui-wrk-btn-warning ui-wrk-btn-addon-left"><span class="icn-md fa fa-database"></span>List Catalogs</a>---->
</cf_box>
<!----
      item.SHIP_ID=SHIP_ID;
                item.SHIP_NAME=SHIP_NAME; 0
                item.BUILD_YEAR=BUILD_YEAR; 0
                item.GROSS_TONNAGE=GROSS_TONNAGE; 0
                item.DEAD_WEIGHT_TONNAGE=DEAD_WEIGHT_TONNAGE; 0
                item.LENGTH=LENGTH; 0
                item.WIDTH=WIDTH; 0
                item.ACTION_TYPE=ACTION_TYPE;
                item.SHIP_TYPE=SHIP_TYPE;
                item.CUSTOMER_NICKNAME=CUSTOMER_NICKNAME;
                item.CUSTOMER_FULLNAME=CUSTOMER_FULLNAME;
                item.CUSTOMER_NAME=CUSTOMER_NAME;
                item.CUSTOMER_SURNAME=CUSTOMER_SURNAME;
                item.CUSTOMER_MAIL=CUSTOMER_MAIL;
                item.CUSTOMER_TELCODE=CUSTOMER_TELCODE;
                item.CUSTOMER_TEL=CUSTOMER_TEL;
                item.CARE_OF_NICKNAME=CARE_OF_NICKNAME;
                item.CARE_OF_FULLNAME=CARE_OF_FULLNAME;
                item.CARE_OF_NAME=CARE_OF_NAME;
                item.CARE_OF_SURNAME=CARE_OF_SURNAME;
                item.CARE_OF_MAIL=CARE_OF_MAIL;
                item.CARE_OF_TELCODE=CARE_OF_TELCODE;
                item.CARE_OF_TEL=CARE_OF_TEL;
                item.IMO_NUMBER=IMO_NUMBER;
                item.HULL_NUMBER=HULL_NUMBER;
                item.SHIP_YARD=SHIP_YARD;
                item.FLAG=FLAG;
                item.CLASS=CLASS;
----->
