<cfcomponent>
    <cfset dsn = application.systemParam.systemParam().dsn>
    <cffunction name="GetShips" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="CompanyId" default="">
        <cfargument name="ShipId" default="">
        <cfargument name="ShipStatus" default="">
        <cfargument name="ShipType" default="">
        <cfquery name="getShip" datasource="#dsn#"> 
         SELECT S.SHIP_NAME,S.BUILD_YEAR,S.GROSS_TONNAGE,S.DEAD_WEIGHT_TONNAGE,S.LENGTH,S.WIDTH,ST.SHIP_TYPE,C.NICKNAME,C.FULLNAME,S.SHIP_ID,SAC.ACTION_TYPE FROM CatalystQA.PBS_SHIPS AS S
	INNER JOIN CatalystQA.PBS_SHIP_TYPES AS ST ON ST.SHIP_TYPE_ID =S.SHIP_TYPE_ID
	INNER JOIN CatalystQA.PBS_SHIP_COMPANY_RELATION AS SC ON SC.SHIP_ID=S.SHIP_ID AND SHIP_STATUS =1
	INNER JOIN CatalystQA.COMPANY AS C ON C.COMPANY_ID=SC.COMPANY_ID
	INNER JOIN CatalystQA.PBS_SHIP_ACTION_TYPES AS SAC ON SAC.SHIP_ACTION_TYPE_ID=SC.ACTION_TYPE
	WHERE 1=1 
            <cfif len(arguments.ShipStatus)>
                AND S.IS_SHIP_ALIVE =#arguments.ShipStatus#
            </cfif>
            <cfif len(arguments.ShipId)>
                AND S.SHIP_ID =#arguments.ShipId#
            </cfif>
            <cfif len(arguments.CompanyId)>
                AND SC.COMPANY_ID =#arguments.CompanyId#
            </cfif>
            <cfif len(arguments.ShipType)>
                AND S.SHIP_TYPE_ID =#arguments.ShipType#
            </cfif>
        </cfquery>
        <cfset ReturnArr=arrayNew(1)>
        <cfloop query="getShip">
            <cfscript>
                item=structNew();
                item.SHIP_ID=SHIP_ID;
                item.SHIP_NAME=SHIP_NAME;
                item.BUILD_YEAR=BUILD_YEAR;
                item.GROSS_TONNAGE=GROSS_TONNAGE;
                item.DEAD_WEIGHT_TONNAGE=DEAD_WEIGHT_TONNAGE;
                item.LENGTH=LENGTH;
                item.WIDTH=WIDTH;
                item.ACTION_TYPE=ACTION_TYPE;
                item.SHIP_TYPE=SHIP_TYPE;
                item.NICKNAME=NICKNAME;
                item.FULLNAME=FULLNAME;
                arrayAppend(ReturnArr,item);
            </cfscript>
        </cfloop>
    </cffunction>

    <cffunction name="AddShip">

    </cffunction>
    <cffunction name="MoveShip">

    </cffunction>
    <cffunction name="UpdateShip">

    </cffunction>
   
</cfcomponent>