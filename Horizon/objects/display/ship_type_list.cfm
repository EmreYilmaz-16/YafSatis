
<cfset ShipService = createObject("component","AddOns.YafSatis.Partner.cfc.ShipService")>

<cfset _ShipTypes=ShipService.getShipTypes()>
<cfset ShipTypes=deserializeJSON(_ShipTypes)>

<ul class="ui-list">
    <li>
        <a href="javascript:void(0)"  onclick=' AjaxPageLoad("index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=addupdshiptype&SHIP_TYPE_ID=","divshtyu",1,"Yükleniyor");'>
            <div class="ui-list-left">
                <span class="ui-list-icon ctl-salvation"></span>
                Yeni Gemi Tipi Ekle
            </div>
            <div class="ui-list-right">
                
                <i class="fa fa-plus" ></i>
            </div>
        </a>
    </li>
    <cfoutput>
    <cfloop array="#ShipTypes#" Item="it">
        <li>
            <a href="javascript:void(0)" >
                <div class="ui-list-left">
                    <span class="ui-list-icon ctl-044-gear"></span>
                    #it.SHIP_TYPE#
                </div>
                <div class="ui-list-right">
                    
                    <i class="fa fa-pencil" onclick=' AjaxPageLoad("index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=addupdshiptype&SHIP_TYPE_ID=#it.SHIP_TYPE_ID#","divshtyu",1,"Yükleniyor");'></i>
                </div>
            </a>
        </li>
</cfloop>   
    </cfoutput>
</ul>