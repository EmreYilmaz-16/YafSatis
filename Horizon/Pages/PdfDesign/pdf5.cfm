<cfmail from="info@partnerbilgisayar.com" to="yazilim@partnerbilgisayar.com">
    Merhaba Dünya
</cfmail>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap');

    * {
        padding: 0;
        margin: 0;
        box-sizing: border-box;
        scroll-behavior: smooth;
        font-family: "Roboto", sans-serif;
    }

    /* .page-div{
        height: 842px;
        width: 595px;
        margin-left: auto;
        margin-right: auto;
    } */

    .page-div {
        height: 100% !important;
    }

    .div-container {
        width: 100%;
        margin: 0 auto;
    }

    .header-div {
        height: 250px;
        border-bottom: 2px solid black;
    }

    .banner-div {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-bottom: 10px;
    }

    .banner-left {
        display: flex;
        justify-content: left;
        align-items: center;
        width: 100%;
    }

    .banner-left h4 {
        text-align: start;
    }

    .banner-right {
        display: flex;
        justify-content: left;
        align-items: center;
        width: 100%;
    }

    .banner-right h4 {
        text-align: start;
    }

    .header-div {
        position: relative;
    }


    .banner-img {
        width: 75% !important;
        height: auto;
        position: absolute;
        top: 0px;
        left: 0px;
    }

    .header-titles {
        position: absolute;
        bottom: 15%;
        right: 0px;
        text-align: left;
        width: 70%;
    }


    .header-titles h1 {
        font-size: 16px;
        font-weight: 700;
        color: black;
        margin-bottom: 10px;
    }

    .header-titles p {
        font-size: 12px;
        font-weight: 500;
        color: #909090;
        margin-bottom: 5px;
    }

    .body-top {
        display: flex;
        justify-content: space-between;
        align-self: center;
        width: 100%;
        margin-top: 20px;
    }

    .top-right-div {
        width: 100%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        margin-bottom: 8px;
    }

    .body-top-right {
        width: 100%;
        text-align: start;
    }

    .body-top-left {
        width: 100%;
        text-align: start;
    }

    .body-top-left p {
        font-size: 10px;
        font-weight: 600;
    }

    .div-elements {
        display: flex;
        justify-content: start;
        align-items: start;
    }

    .input-title {
        text-align: left;
        padding-right: 10px;
        font-weight: 700;
        font-size: 10px;
        width: 30%;
        color: #9AA0A6;
    }

    .input-value {
        text-align: left;
        margin-left: 30px;
        font-weight: 400;
        font-size: 10px;
        color: #4A4A4A;
    }

    .body-info {
        width: 100%;
    }

    .body-info h2 {
        font-size: 18px;
        font-weight: 600;
        text-align: start;
    }

    .body {
        margin-top: 10px;
    }

    .body .body-title {
        font-weight: 700;
        font-size: 24px;
        text-align: center;
    }

    /* TABLE */

    .table-div {
        border: 1px solid #9AA0A6;
        border-radius: 5px;
        margin-top: 50px;
        margin-bottom: 50px;
    }

    .table-top {
        width: 100%;
        color: #4A4A4A;
        padding-block: 10px;
        border-bottom: 1px solid #4A4A4A;
    }

    .table-top-div {
        display: flex;
        justify-content: start;
        align-items: end;
        gap: 20px;
    }

    .table {
        padding-block: 10px;
        padding-inline: 20px;
        border-radius: 5px;
    }

    .table-x {
        width: 100%;
    }

    .table-head {
        width: 50px !important;
        font-size: 30px !important;
        border-bottom: 1px dotted #4A4A4A !important;
    }

    .table-tr {
        border-bottom: 1px solid black;
    }

    tr {
        border-bottom: 1px solid #ddd !important;
    }

    tr:nth-child(even) {
        background-color: #fff4b869;
    }

    .imza {
        position: absolute;
        bottom: 10px;
        left: 10px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        gap: 10px;
    }

    .imza-title{
        font-size: 12px;
        font-weight: 600;
    }

    .imza-body{
        font-size: 12px;
        font-weight: 600;
    }

    .imza-footer{
        font-size: 12px;
        font-weight: 600;
    }

    @media (min-width: 992px) {
        .banner-img {
            width: 30% !important;
            height: auto;
            position: absolute;
            top: 0px;
            left: 0px;
        }
    }
</style>
<cfquery name="ourcompanyinfo" datasource="#dsn#">
    SELECT COMPANY_NAME,NICK_NAME,WEB,EMAIL,ADDRESS,SC.CITY_NAME,SCO.COUNTRY_NAME,SCT.COUNTY_NAME,OUR_COMPANY.COMP_ID,MERSIS_NO,TAX_OFFICE,TAX_NO,T_NO FROM CatalystQA.OUR_COMPANY
    LEFT JOIN CatalystQA.SETUP_COUNTRY SCO ON SCO.COUNTRY_ID=OUR_COMPANY.COUNTRY_ID
    LEFT JOIN CatalystQA.SETUP_COUNTY SCT ON SCT.COUNTY_ID=OUR_COMPANY.COUNTY_ID
    LEFT JOIN CatalystQA.SETUP_CITY SC ON SC.CITY_ID=OUR_COMPANY.CITY_ID
    WHERE OUR_COMPANY.COMP_ID=#session.ep.company_id#
    </cfquery>
    
  
    

<div class="page-div">
    <div class="div-container">
        <!-- HEADER -->
        <div class="header-div">
            <img src="/AddOns/YafSatis/Content/img/logodeneme.png" class="banner-img" alt="banner ">
            <div class="header-titles">
                <h1><cfoutput>#ourcompanyinfo.COMPANY_NAME#</cfoutput></h1>
                <p>
                    <cfoutput>#ourcompanyinfo.ADDRESS#  #ourcompanyinfo.COUNTY_NAME# #ourcompanyinfo.CITY_NAME# </cfoutput>
                </p>
                <p>
                    MERSİS NO: <cfoutput>#ourcompanyinfo.MERSIS_NO#</cfoutput>
                </p>
                <p>
                    <cfoutput>#ourcompanyinfo.TAX_OFFICE#</cfoutput> V.D. <cfoutput>#ourcompanyinfo.TAX_NO#</cfoutput>
                </p>
                <p>
                    TİC. SİC. NO: <cfoutput>#ourcompanyinfo.T_NO#</cfoutput>
                </p>
            </div>
        </div>

        <div class="body-top">
            <div class="body-top-left">
                <p>-</p>
            </div>
            <div class="body-top-right">
                <div class="top-right-div">
                    <div class="div-elements">
                        <div class="input-title">DATE</div>
                        <div class="input-value"><span>:</span> <cfoutput>#Offer.OFFER_DATE#</cfoutput></div>
                    </div>
                    <div class="div-elements">
                        <div class="input-title">OUR REF NO</div>
                        <div class="input-value"><span>:</span><cfoutput>#Offer.OFFER_NUMBER#</cfoutput></div>
                    </div>

                    <div class="div-elements">
                        <div class="input-title">YOUR REF NO</div>
                        <div class="input-value"><span>:</span></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="body-info">
            <h2><cfoutput>#Offer.FULLNAME#</cfoutput></h2>
            <p><cfoutput>#Offer.COMPANY_ADDRESS#</cfoutput></p>
            
        </div>



        <div class="body">
            <h2 class="body-title">DELIVERY RECEIPT</h2>
        </div>

        <cfquery name="GETrOWS" datasource="#dsn#_1">
            SELECT POR.*,0 AS PURCHASE_PRICE,'TL' AS PURCHASE_MONEY,'' AS FIRST_REMARK,
            CASE WHEN POR.IS_VIRTUAL <>1 THEN     S.MANUFACT_CODE ELSE VPP.PART_NUMBER END AS MN_CODE FROM PBS_OFFER_ROW AS POR LEFT JOIN STOCKS AS S ON S.STOCK_ID=POR.STOCK_ID 
            LEFT JOIN VIRTUAL_PRODUCTS_PBS AS VPP ON VPP.VP_ID=POR.PRODUCT_ID
            WHERE OFFER_ID=#attributes.OFFER_ID#
        </cfquery>
        
        <!-- TABLE -->
        <cfoutput query="GETrOWS" group="PROP_LIST">
        <div class="table-div">
            <div class="table-top">
                <div class="table-top-div">
                   <CFSET JD=deserializeJSON(JSON_STRINGIM)>
                  
                   <cfloop array="#JD.Filters#" item="it">
                    <div class="table-top-elements">
                        <p style="font-size: 10px;">#it.PNAME#</p>
                        <p style="font-weight: 700; font-size: 10px;">#it.PRODUCT_CAT#</p>
                    </div>
                </cfloop>
                
                </div>
            </div>

            <div class="table">
                <table class="table-x">
                    <thead class="table-head">
                        <tr>
                            <th>NO</th>
                            <th>PART NO</th>
                            <th>PART NAME</th>
                            <th>QTY</th>
                            <th>UNIT</th>
                            <th>UNIT PRICE</th>
                            <th>AMOUNT</th>
                            <th>REMARK</th>
                        </tr>
                    </thead>
                    <tbody>
                        <CFSET IIIX=1>
                         <cfoutput> <tr class="table-tr">
                         
                            <td>#IIIX#</td>
                            <td>#MN_CODE#</td>
                            <td>#PRODUCT_NAME#
                                <cfquery name="getpp" datasource="#dsn#_1">
   SELECT  PRODUCT_PROPERTY.PROPERTY ,PRODUCT_PROPERTY_DETAIL.PROPERTY_DETAIL FROM CatalystQA_product.PRODUCT_DT_PROPERTIES 
LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY ON PRODUCT_PROPERTY.PROPERTY_ID=PRODUCT_DT_PROPERTIES.PROPERTY_ID
LEFT JOIN CatalystQA_product.PRODUCT_PROPERTY_DETAIL ON PRODUCT_PROPERTY_DETAIL.PROPERTY_DETAIL_ID=PRODUCT_DT_PROPERTIES.VARIATION_ID
LEFT JOIN CatalystQA_product.PRODUCT ON PRODUCT.PRODUCT_ID=PRODUCT_DT_PROPERTIES.PRODUCT_ID
WHERE PRODUCT_DT_PROPERTIES.PROPERTY_ID NOT IN(
    SELECT PROPERTY_ID FROM CatalystQA_product.PRODUCT_CAT_PROPERTY WHERE PRODUCT_CAT_ID=PRODUCT.PRODUCT_CATID
) AND PRODUCT_DT_PROPERTIES.PRODUCT_ID=#PRODUCT_ID#

                       </cfquery><br>
<cfloop query="getpp">
    <b>#getpp.PROPERTY#</b>:#PROPERTY_DETAIL#
    </cfloop>
             
                            </td>
                            <td>#QUANTITY#</td>
                            <td>#UNIT#</td>
                            <td>#PRICE_OTHER-DISCOUNT_COST# #OTHER_MONEY#</td>
                            <td>#OTHER_MONEY_VALUE# EU</td>
                           <td>#PRODUCT_NAME2#</td>
                        </tr>
                        <CFSET IIIX=IIIX+1>
                    </cfoutput><!------->
                     
                    </tbody>
                </table>
            </div>
        </div>
    </cfoutput>

            <div class="imza">
                <div class="imza-title">TARİH</div>
                <div class="imza-body">
                    ........ / ........ / ........
                </div>
                <div class="imza-footer">TESLİM EDEN / DELIVERED BY</div>
            </div>
        </div>
    </div>
</div>