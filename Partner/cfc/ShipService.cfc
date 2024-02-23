<cfcomponent>
    <cfset dsn = application.systemParam.systemParam().dsn>
    <cffunction name="GetShips" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="CustomerId" default="">
        <cfargument name="Keyword" default="">
        <cfargument name="ShipId" default="">
        <cfargument name="ShipStatus" default="">
        <cfargument name="ShipType" default="">
        <cfargument name="RowCount" default="20">
        <cfargument name="Page" default="1">
        <cfquery name="getShip" datasource="#dsn#"> 
            SELECT TOP #arguments.RowCount# S.SHIP_NAME,S.BUILD_YEAR,S.GROSS_TONNAGE,S.DEAD_WEIGHT_TONNAGE,S.LENGTH,S.WIDTH,ST.SHIP_TYPE,C.NICKNAME,C.FULLNAME,S.SHIP_ID,SAC.ACTION_TYPE FROM CatalystQA.PBS_SHIPS AS S
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
            <cfif len(arguments.Keyword)>
                AND S.SHIP_NAME LIKE '%#arguments.Keyword#%'
            </cfif>
            <cfif len(arguments.CustomerId)>
                AND SC.COMPANY_ID =#arguments.CustomerId#
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
        <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>

    <cffunction name="AddShip" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="SHIP_NAME">
        <cfargument name="BUILD_YEAR">
        <cfargument name="GROSS_TONNAGE">
        <cfargument name="DEAD_WEIGHT_TONNAGE">
        <cfargument name="LENGTH">
        <cfargument name="WIDTH">
        <cfargument name="SHIP_TYPE_ID">
        <cfargument name="RECORD_EMP">
        <cfargument name="CustomerId" default="">
        <cfargument name="ACTION_TYPE" default="">
       <cftry>
       
       <cfquery name="Add" datasource="#dsn#" result="res">
            INSERT INTO [CatalystQA].[PBS_SHIPS]
           ([SHIP_NAME]
           ,[BUILD_YEAR]
           ,[GROSS_TONNAGE]
           ,[DEAD_WEIGHT_TONNAGE]
           ,[LENGTH]
           ,[WIDTH]
           ,[SHIP_TYPE_ID]
           ,[RECORD_DATE]
           ,[RECORD_EMP]
           ,[IS_SHIP_ALIVE])
     VALUES
           ('#arguments.SHIP_NAME#'
           ,<cfif len(arguments.BUILD_YEAR)>#arguments.BUILD_YEAR#<cfelse>NULL</cfif> 
           ,<cfif len(arguments.GROSS_TONNAGE)>#arguments.GROSS_TONNAGE#<cfelse>NULL</cfif> 
           ,<cfif len(arguments.DEAD_WEIGHT_TONNAGE)>#arguments.DEAD_WEIGHT_TONNAGE#<cfelse>NULL</cfif> 
           ,<cfif len(arguments.LENGTH)>#arguments.LENGTH#<cfelse>NULL</cfif> 
           ,<cfif len(arguments.WIDTH)>#arguments.WIDTH#<cfelse>NULL</cfif> 
           ,<cfif len(arguments.SHIP_TYPE_ID)>#arguments.SHIP_TYPE_ID#<cfelse>NULL</cfif> 
           ,GETDATE()
           ,<cfif len(arguments.RECORD_EMP)>#arguments.RECORD_EMP#<cfelse>NULL</cfif>           
           ,1)
        </cfquery>
        <cfquery name="ins2" datasource="#dsn#">
            INSERT INTO [CatalystQA].[PBS_SHIP_COMPANY_RELATION]
           ([SHIP_ID]
           ,[COMPANY_ID]
           ,[ACTION_DATE]
           ,[ACTION_TYPE]
           ,[SHIP_STATUS])
     VALUES
           (#res.IDENTITYCOL#
           ,#arguments.CustomerId#
           ,GETDATE()
           ,#arguments.ACTION_TYPE#
           ,1)
        </cfquery>
        <cfreturn GetShips(ShipId=res.IDENTITYCOL)>
        <cfcatch>
            <cfsavecontent  variable="control5">
                <cfdump  var="#CGI#">                
     
                <cfdump var="#arguments#">
                <cfdump var="#cfcatch#">
               </cfsavecontent>
               <cffile action="write" file = "c:\CfCatchAddShip.html" output="#control5#"></cffile>
            <cfreturn replace(serializeJSON(cfcatch),"//","")>
            
        </cfcatch>
       </cftry>
    </cffunction>
    <cffunction name="MoveShip">
        <cfargument name="SHIP_ID">
        <cfargument name="ToCustomerId">
        <cfargument name="ACTION_TYPE">

        <cfquery name="upLs" datasource="#dsn#">
            select * from PBS_SHIP_COMPANY_RELATION where SHIP_ID=#SHIP_ID# AND SHIP_STATUS=1
        </cfquery>
<cfquery name="upd" datasource="#dsn#">
    UPDATE PBS_SHIP_COMPANY_RELATION SET SHIP_STATUS=0 WHERE ID=#upLs.ID#
</cfquery>
<cfquery name="ins2" datasource="#dsn#">
    INSERT INTO [CatalystQA].[PBS_SHIP_COMPANY_RELATION]
   ([SHIP_ID]
   ,[COMPANY_ID]
   ,[ACTION_DATE]
   ,[ACTION_TYPE]
   ,[SHIP_STATUS])
VALUES
   (#res.IDENTITYCOL#
   ,#arguments.ToCustomerId#
   ,GETDATE()
   ,#arguments.ACTION_TYPE#
   ,1)
</cfquery>
<cfreturn GetShips(ShipId=arguments.SHIP_ID)>
    </cffunction>
    <cffunction name="UpdateShip">
        <cfargument name="SHIP_ID">
        <cfargument name="SHIP_NAME">        
        <cfargument name="BUILD_YEAR">
        <cfargument name="GROSS_TONNAGE">
        <cfargument name="DEAD_WEIGHT_TONNAGE">
        <cfargument name="LENGTH">
        <cfargument name="WIDTH">
        <cfargument name="SHIP_TYPE_ID">
        <cfargument name="UPDATE_EMP">        
       <cftry>
       
       <cfquery name="Add" datasource="#dsn#" result="res">
           UPDATE [CatalystQA].[PBS_SHIPS] SET 
           SHIP_NAME='#arguments.SHIP_NAME#',
           BUILD_YEAR=#arguments.BUILD_YEAR#,
           GROSS_TONNAGE=#arguments.GROSS_TONNAGE#,
           DEAD_WEIGHT_TONNAGE=#arguments.DEAD_WEIGHT_TONNAGE#,
           LENGTH=#arguments.LENGTH#,
           WIDTH=#arguments.WIDTH#,
           SHIP_TYPE_ID=#arguments.SHIP_TYPE_ID#,
           UPDATE_DATE=GETDATE(),
           UPDATE_EMP=#arguments.UPDATE_EMP#
           WHERE SHIP_ID=#arguments.SHIP_ID#
        </cfquery>        
        <cfreturn GetShips(ShipId=arguments.SHIP_ID)>
        <cfcatch>
            <cfsavecontent  variable="control5">
                <cfdump  var="#CGI#">                
     
                <cfdump var="#arguments#">
                <cfdump var="#cfcatch#">
               </cfsavecontent>
               <cffile action="write" file = "c:\CfCatchAddShip.html" output="#control5#"></cffile>
            <cfreturn replace(serializeJSON(cfcatch),"//","")>
            
        </cfcatch>
       </cftry>
    </cffunction>
 
   
</cfcomponent>