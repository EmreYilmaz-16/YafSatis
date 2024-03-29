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
            SELECT S.SHIP_NAME
                ,S.BUILD_YEAR
                ,S.GROSS_TONNAGE
                ,S.DEAD_WEIGHT_TONNAGE
                ,S.LENGTH
                ,S.WIDTH
                ,ST.SHIP_TYPE
                ,ST.SHIP_TYPE_ID
                ,C.NICKNAME AS CUSTOMER_NICKNAME
                ,C.FULLNAME AS CUSTOMER_FULLNAME
                ,C.COMPANY_PARTNER_NAME AS CUSTOMER_NAME
                ,C.COMPANY_PARTNER_SURNAME AS CUSTOMER_SURNAME
                ,C.MAIL AS CUSTOMER_MAIL
                ,C.COMPANY_PARTNER_TELCODE AS CUSTOMER_TELCODE
                ,C.COMPANY_PARTNER_TEL AS CUSTOMER_TEL
                ,C.ADRESS AS CUSTOMER_ADRESS
                ,C.COMPANY_ID AS CUSTOMER_COMPANY_ID
                ,C.PARTNER_ID AS CUSTOMER_PARTNER_ID
                ,C2.NICKNAME AS CARE_OF_NICKNAME
                ,C2.FULLNAME AS CARE_OF_FULLNAME
                ,C2.COMPANY_PARTNER_NAME AS CARE_OF_NAME
                ,C2.COMPANY_PARTNER_SURNAME AS CARE_OF_SURNAME
                ,C2.MAIL AS CARE_OF_MAIL
                ,C2.COMPANY_PARTNER_TELCODE AS CARE_OF_TELCODE
                ,C2.COMPANY_PARTNER_TEL AS CARE_OF_TEL
                ,C2.ADRESS AS CARE_OF_ADRESS
                ,C2.COMPANY_ID AS CARE_OF_COMPANY_ID
                ,C2.PARTNER_ID AS CARE_OF_PARTNER_ID 
                ,S.SHIP_ID
                ,SAC.ACTION_TYPE
                ,S.IMO_NUMBER
                ,S.HULL_NUMBER
                ,S.SHIP_YARD
                ,S.FLAG
                ,S.CLASS
            FROM CatalystQA.PBS_SHIPS AS S
            INNER JOIN CatalystQA.PBS_SHIP_TYPES AS ST ON ST.SHIP_TYPE_ID = S.SHIP_TYPE_ID
            LEFT JOIN CatalystQA.PBS_SHIP_COMPANY_RELATION AS SC ON SC.SHIP_ID = S.SHIP_ID
                AND SHIP_STATUS = 1
            LEFT JOIN (
                SELECT CP.COMPANY_PARTNER_NAME
                    ,CP.PARTNER_ID
                    ,CP.COMPANY_PARTNER_SURNAME
                    ,ISNULL(CB.COMPBRANCH_ADDRESS, C.COMPANY_ADDRESS) AS ADRESS
                    ,CP.COMPANY_PARTNER_TELCODE
                    ,CP.COMPANY_PARTNER_TEL
                    ,C.NICKNAME
                    ,C.FULLNAME
                    ,CP.MAIL
                    ,C.COMPANY_ID
                    
                FROM CatalystQA.COMPANY_PARTNER CP
                LEFT JOIN CatalystQA.COMPANY_BRANCH AS CB ON CB.BRANCH_ID = CP.COMPBRANCH_ID
                LEFT JOIN CatalystQA.COMPANY AS C ON C.COMPANY_ID = CP.COMPANY_ID
                ) AS C ON C.PARTNER_ID = SC.PARTNER_ID
            LEFT JOIN (
                SELECT CP.COMPANY_PARTNER_NAME
                    ,CP.PARTNER_ID
                    ,CP.COMPANY_PARTNER_SURNAME
                    ,ISNULL(CB.COMPBRANCH_ADDRESS, C.COMPANY_ADDRESS) AS ADRESS
                    ,CP.COMPANY_PARTNER_TELCODE
                    ,CP.COMPANY_PARTNER_TEL
                    ,C.NICKNAME
                    ,C.FULLNAME
                    ,CP.MAIL
                    ,C.COMPANY_ID
                FROM CatalystQA.COMPANY_PARTNER CP
                LEFT JOIN CatalystQA.COMPANY_BRANCH AS CB ON CB.BRANCH_ID = CP.COMPBRANCH_ID
                LEFT JOIN CatalystQA.COMPANY AS C ON C.COMPANY_ID = CP.COMPANY_ID
                ) AS C2 ON C2.PARTNER_ID = S.CARE_OF_PARTNER_ID
            LEFT JOIN CatalystQA.PBS_SHIP_ACTION_TYPES AS SAC ON SAC.SHIP_ACTION_TYPE_ID = SC.ACTION_TYPE
            WHERE 1 = 1          
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
        <!-----[IMO_NUMBER] [nvarchar](50) NULL,
	[CARE_OF_COMPANY] [int] NULL,
	[CARE_OF_PARTNER_ID] [int] NULL,
	[HULL_NUMBER] [nvarchar](50) NULL,
	[SHIP_YARD] [nvarchar](50) NULL,
	[FLAG] [nvarchar](50) NULL,
	[CLASS] [nvarchar](50) NULL,
    -- CARE_OF_PARTNER_ID CARE_OF_COMPANY_ID CUSTOMER_COMPANY_ID CUSTOMER_PARTNER_ID
    
    ----->
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
                item.SHIP_TYPE_ID=SHIP_TYPE_ID;
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
                item.CUSTOMER_ADRESS=CUSTOMER_ADRESS;
                item.CUSTOMER_COMPANY_ID=CUSTOMER_COMPANY_ID;
                item.CUSTOMER_PARTNER_ID=CUSTOMER_PARTNER_ID;
                item.CARE_OF_NICKNAME=CARE_OF_NICKNAME;
                item.CARE_OF_FULLNAME=CARE_OF_FULLNAME;
                item.CARE_OF_NAME=CARE_OF_NAME;
                item.CARE_OF_SURNAME=CARE_OF_SURNAME;
                item.CARE_OF_MAIL=CARE_OF_MAIL;
                item.CARE_OF_TELCODE=CARE_OF_TELCODE;
                item.CARE_OF_TEL=CARE_OF_TEL;
                item.CARE_OF_ADRESS=CARE_OF_ADRESS;
                item.CARE_OF_PARTNER_ID=CARE_OF_PARTNER_ID;
                item.CARE_OF_COMPANY_ID=CARE_OF_COMPANY_ID;
                item.IMO_NUMBER=IMO_NUMBER;
                item.HULL_NUMBER=HULL_NUMBER;
                item.SHIP_YARD=SHIP_YARD;
                item.FLAG=FLAG;
                item.CLASS=CLASS;
                arrayAppend(ReturnArr,item);
            </cfscript>
        </cfloop>
        <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>
    <cffunction name="getShipTypes" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="GetST" datasource="#dsn#">
            SELECT SHIP_TYPE_ID,SHIP_TYPE FROM CatalystQA.PBS_SHIP_TYPES
        </cfquery>
        <cfset ReturnArr=arrayNew(1)>
        <cfloop query="GetST">
            <cfset Item=structNew()>
            <cfset Item.SHIP_TYPE_ID=SHIP_TYPE_ID>
            <cfset Item.SHIP_TYPE=SHIP_TYPE>
            <cfscript>
                arrayAppend(returnArr,Item);
            </cfscript>
        </cfloop>
        <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>

    <cffunction name="AddShip" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="FData">
        <cfset FormData=deserializeJSON(arguments.FData)>
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
           ,[IS_SHIP_ALIVE]
           ,[IMO_NUMBER]
           ,[CARE_OF_COMPANY]
           ,[CARE_OF_PARTNER_ID]
           ,[HULL_NUMBER]
           ,[SHIP_YARD]
           ,[FLAG]
           ,[CLASS])
     VALUES
           ('#FormData.SHIP_NAME#'
           ,<cfif len(FormData.BUILD_YEAR)>#FormData.BUILD_YEAR#<cfelse>NULL</cfif> 
            ,<cfif len(FormData.GROSS_TONNAGE)>#FormData.GROSS_TONNAGE#<cfelse>NULL</cfif> 
           ,<cfif len(FormData.DEAD_WEIGHT_TONNAGE)>#FormData.DEAD_WEIGHT_TONNAGE#<cfelse>NULL</cfif> 
            ,<cfif len(FormData.LENGTH)>#FormData.LENGTH#<cfelse>NULL</cfif> 
            ,<cfif len(FormData.WIDTH)>#FormData.WIDTH#<cfelse>NULL</cfif> 
            ,<cfif len(FormData.SHIP_TYPE)>#FormData.SHIP_TYPE#<cfelse>NULL</cfif> 
            ,GETDATE()
           ,<cfif isDefined("FormData.RECORD_EMP") and  len(FormData.RECORD_EMP)>#FormData.RECORD_EMP#<cfelse>NULL</cfif>
           ,1
           ,<cfif len(FormData.IMO_NUMBER)>'#FormData.IMO_NUMBER#'<cfelse>NULL</cfif> 
            ,<cfif len(FormData.CAREOF_NICKNAME)>#FormData.CAREOF_ID#<cfelse>NULL</cfif>
            ,<cfif len(FormData.CAREOF_NAME)>#FormData.CAREOF_EMP_ID#<cfelse>NULL</cfif>
            ,<cfif len(FormData.HULL_NUMBER)>'#FormData.HULL_NUMBER#'<cfelse>NULL</cfif> 
            ,<cfif len(FormData.SHIP_YARD)>'#FormData.SHIP_YARD#'<cfelse>NULL</cfif> 
            ,<cfif len(FormData.FLAG)>'#FormData.FLAG#'<cfelse>NULL</cfif> 
            ,<cfif len(FormData.CLASS)>'#FormData.CLASS#'<cfelse>NULL</cfif> )
        </cfquery>

        <cfquery name="ins2" datasource="#dsn#">
            
INSERT INTO [CatalystQA].[PBS_SHIP_COMPANY_RELATION]
           ([SHIP_ID]
           ,[COMPANY_ID]
           ,[ACTION_DATE]
           ,[ACTION_TYPE]
           ,[SHIP_STATUS]
           ,[PARTNER_ID])
     VALUES
           (#res.IDENTITYCOL#
           ,#FormData.CUSTOMER_ID#
           ,getdate()
           ,1
           ,1
           ,#FormData.CUSTOMER_EMP_ID#)
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
    <cffunction name="MoveShip" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfargument name="FData">
        <cfset FormData=deserializeJSON(arguments.FData)>

        <cfquery name="upLs" datasource="#dsn#">
            select * from PBS_SHIP_COMPANY_RELATION where SHIP_ID=#FormData.SHIP_ID# AND SHIP_STATUS=1
        </cfquery>
<cfquery name="upd" datasource="#dsn#">
    UPDATE PBS_SHIP_COMPANY_RELATION SET SHIP_STATUS=0 WHERE SHIP_ID=#FormData.SHIP_ID#
</cfquery>
<cfquery name="ins2" datasource="#dsn#">
    INSERT INTO [CatalystQA].[PBS_SHIP_COMPANY_RELATION]
   ([SHIP_ID]
           ,[COMPANY_ID]
           ,[ACTION_DATE]
           ,[ACTION_TYPE]
           ,[SHIP_STATUS]
           ,[PARTNER_ID])
VALUES
   (#FormData.SHIP_ID#
   ,#FormData.CUSTOMER_ID#
   ,GETDATE()
   ,#FormData.ACTION_TYPE#
   ,1
   ,#FormData.CUSTOMER_EMP_ID#)
</cfquery>
<cfreturn GetShips(ShipId=arguments.SHIP_ID) >
    </cffunction>
    <cffunction name="UpdateShip" access="remote" httpMethod="Post" returntype="any" returnFormat="json"> 
        <cfargument name="FData">
        <cfset FormData=deserializeJSON(arguments.FData)>      
       <cftry>
       <!-------
        ([SHIP_NAME]
           ,[BUILD_YEAR]
           ,[GROSS_TONNAGE]
           ,[DEAD_WEIGHT_TONNAGE]
           ,[LENGTH]
           ,[WIDTH]
           ,[SHIP_TYPE_ID]
           ,[RECORD_DATE]
           ,[RECORD_EMP]
           ,[IS_SHIP_ALIVE]
           ,[IMO_NUMBER]
           ,[CARE_OF_COMPANY]
           ,[CARE_OF_PARTNER_ID]
           ,[HULL_NUMBER]
           ,[SHIP_YARD]
           ,[FLAG]
           ,[CLASS])------>
       <cfquery name="Add" datasource="#dsn#" result="res">
           UPDATE [CatalystQA].[PBS_SHIPS] SET 
           SHIP_NAME='#FormData.SHIP_NAME#',
           BUILD_YEAR=#FormData.BUILD_YEAR#,
           GROSS_TONNAGE=#FormData.GROSS_TONNAGE#,
           DEAD_WEIGHT_TONNAGE=#FormData.DEAD_WEIGHT_TONNAGE#,
           LENGTH=#FormData.LENGTH#,
           WIDTH=#FormData.WIDTH#,
           SHIP_TYPE_ID=#FormData.SHIP_TYPE#,
           UPDATE_DATE=GETDATE(),
           UPDATE_EMP=#FormData.UPDATE_EMP#,
           IMO_NUMBER='#FormData.IMO_NUMBER#',
           HULL_NUMBER='#FormData.HULL_NUMBER#',
           SHIP_YARD='#FormData.SHIP_YARD#',
           FLAG='#FormData.FLAG#',
           CLASS='#FormData.CLASS#',
           CARE_OF_COMPANY=<CFIF LEN(FormData.CAREOF_NICKNAME)>#FormData.CAREOF_ID#<CFELSE>NULL</CFIF>,
            CARE_OF_PARTNER_ID=<CFIF LEN(FormData.CAREOF_NAME)>#FormData.CAREOF_EMP_ID#<CFELSE>NULL</CFIF>
           WHERE SHIP_ID=#FormData.SHIP_ID#
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
    <cffunction name="getActionTypes" access="remote" httpMethod="Post" returntype="any" returnFormat="json">
        <cfquery name="GetST" datasource="#dsn#">
            SELECT TOP (1000) [SHIP_ACTION_TYPE_ID]
      ,[ACTION_TYPE]
  FROM [CatalystQA].[CatalystQA].[PBS_SHIP_ACTION_TYPES]
        </cfquery>
         <cfset ReturnArr=arrayNew(1)>
         <cfloop query="GetST">
             <cfset Item=structNew()>
             <cfset Item.SHIP_ACTION_TYPE_ID=SHIP_ACTION_TYPE_ID>
             <cfset Item.ACTION_TYPE=ACTION_TYPE>
             <cfscript>
                 arrayAppend(returnArr,Item);
             </cfscript>
         </cfloop>
         <cfreturn replace(serializeJSON(ReturnArr),"//","")>
    </cffunction>
   
</cfcomponent>