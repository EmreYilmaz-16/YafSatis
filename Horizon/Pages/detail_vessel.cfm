<cf_box title="Gemi">
<cfset ShipService = createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>
<cfset ShipTypes_=ShipService.getShipTypes()>
<cfset ShipList_=ShipService.GetShips(ShipId:attributes.ShipId)>
<cfset ShipTypes=deserializeJSON(ShipTypes_)>
<cfset ShipList=deserializeJSON(ShipList_)>


<cfoutput>
<cfset GEMI=ShipList[1]>

   <div style="text-align:center;color:green;font-weight:bold;font-size:14pt">
            #GEMI.SHIP_NAME#
    </div>
        
    <table>
    <tr>
        <td>Build Year</td>
        <td>:#GEMI.BUILD_YEAR#</td>
        <td>Ship Type</td>
        <td>:#GEMI.SHIP_TYPE#</td>
    </tr>
</table>
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
        <td>#GEMI.GROSS_TONNAGE#</td>
        <td>#GEMI.DEAD_WEIGHT_TONNAGE#</td>
        <td>#GEMI.WIDTH#</td>
        <td>#GEMI.LENGTH#</td>
    </tr>
    <tr>
        <td colspan="2">
            Customer
        </td>
        
    </tr>
    <tr>
        <td>
            <cf_big_list>
                <tr>                    
                    <td colspan="3">
                        #GEMI.CUSTOMER_FULLNAME#
                    </td>
                    
                </tr>
                <tr>
                    <td>
                        <b style="width:100%">Contact Person</b>
                        #GEMI.CUSTOMER_NAME# #GEMI.CUSTOMER_SURNAME#
                    </td>
                    <td>
                        <b style="width:100%">Ship Phone</b>
                        #GEMI.CUSTOMER_TELCODE# #GEMI.CUSTOMER_TEL#
                    </td>
                    <td>
                        <b style="width:100%">Ship Mail</b>
                        #GEMI.CUSTOMER_MAIL# 
                    </td>
                </tr>
            </cf_big_list>
        </td>
    </tr>
</cf_big_list>

</cfoutput>

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
