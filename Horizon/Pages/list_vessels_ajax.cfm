
<cfset ShipService = createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>
<cfset ShipTypes_=ShipService.getShipTypes()>


<cfset FormDatam=deserializeJSON(attributes.FormData)>

<!--------------
<cfargument name="CustomerId" default="">
        <cfargument name="Keyword" default=""> ok
        <cfargument name="ShipId" default=""> ok
        <cfargument name="ShipStatus" default="">
        <cfargument name="ShipType" default=""> ok
        <cfargument name="RowCount" default="20">
        <cfargument name="Page" default="1">
        CareOfId
        iif(isdefined("attributes.draggable"),1,0)#
    ----------->

<cfset ShipList_=ShipService.GetShips(Keyword=FormDatam.KEYWORD,ShipType=FormDatam.SHIP_TYPE,CustomerId=iif(len(FormDatam.CUSTOMER.member_name),FormDatam.CUSTOMER.company_id,""),CareOfId=iif(len(FormDatam.CARE_OF.member_name),FormDatam.CARE_OF.company_id,""))>
<cfset ShipTypes=deserializeJSON(ShipTypes_)>
<cfset ShipList=deserializeJSON(ShipList_)>

<cf_grid_list>
    <thead>
        <tr>
            <th>Vessel Name</th>
            <th>Build Year</th>
            <th>Ship Type</th>
            <th>Customer</th>
            <th>Partner</th>
            <th>IMO Number</th>
            <th>
                <a href="javascript://" onclick="openBoxDraggable('index.cfm?fuseaction=objects.emptypopup_add_vessel')"><span class="icn-md fa fa-plus"></span></a>
            </th>
        </tr>
    </thead>
    <tbody>
        <cfoutput>
        <cfloop array="#ShipList#" item="it">
        <tr>
            <td>#it.SHIP_NAME#</td>
            <td>#it.BUILD_YEAR#</td>
            <td>#it.SHIP_TYPE#</td>
            <td>#it.CUSTOMER_NICKNAME#</td>
            <td>#it.CUSTOMER_NAME# #it.CUSTOMER_SURNAME#</td>
            <td>#it.IMO_NUMBER#</td>
            <td>
                <a href="javascript://" onclick="openBoxDraggable('index.cfm?fuseaction=sales.emptypopup_update_vessel&ShipId=#it.SHIP_ID#')"><span class="icn-md fa fa-edit"></span></a>
                <a href="javascript://" onclick="openBoxDraggable('index.cfm?fuseaction=sales.emptypopup_detail_vessel&ShipId=#it.SHIP_ID#')"><span class="icn-md fa fa-search"></span></a>
                
            </td>
        </tr>
    </cfloop>
    </cfoutput>
    </tbody>
</cf_grid_list>

<!----
      item.SHIP_ID=SHIP_ID;
                item.SHIP_NAME=SHIP_NAME;
                item.BUILD_YEAR=BUILD_YEAR;
                item.GROSS_TONNAGE=GROSS_TONNAGE;
                item.DEAD_WEIGHT_TONNAGE=DEAD_WEIGHT_TONNAGE;
                item.LENGTH=LENGTH;
                item.WIDTH=WIDTH;
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