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
        height: 100%;
    }

    .div-container {
        width: 100%;
        margin: 0 auto;
    }

    .header-div {
        position: relative;
        height: 250px;
    }

    .iso-img {
        width: 15%;
        height: auto;
        position: absolute;
        top: 40px;
        right: 25px;
    }

    .banner-img {
        width: 60%;
        height: auto;
        position: absolute;
        top: 0px;
        left: 0px;
    }

    .header-titles {
        position: absolute;
        bottom: 0px;
        right: 25px;
        text-align: right;
    }

    .header-top-title {
        font-size: 18px;
        font-weight: 800;
        display: flex;
        flex-direction: column;
        align-items: end;
    }

    .header-sub-title {
        font-size: 9px;
        font-weight: 400;
        color: grey;
    }

    .header-big-text {
        font-size: 40px;
        text-align: end;
        color: #FAD402;
        margin-bottom: 20px;
    }


    /* BODY */
    .information-div {
        display: flex;
        justify-content: space-between;
        align-items: start;
        text-align: start;
        margin-bottom: 15px;
    }

    .left-div {
        width: 100%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        margin-bottom: 3px;
    }

    .right-div {
        width: 100%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        margin-bottom: 3px;
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
        font-size: 12px;
        color: #4A4A4A;
    }

    /* TABLE */

    .table-div {
        border: 1px solid #9AA0A6;
        border-radius: 5px;
    }

    .table-top {
        width: 100%;
        background-color: #fff4b869;
        color: #FAD402;
        padding-block: 10px;
        border-bottom: 1px solid #FAD402;
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
        font-size: 10px !important;
    }

    .table-tr {
        border-bottom: 1px solid black;
    }

    .page-text-div {
        margin-top: 10px;
    }

    .page-text-div {
        font-size: 10px;
        text-align: center;
    }

    .total-div {
        display: flex;
        justify-content: space-between;
        align-self: center;
        margin-block: 40px;
        width: 100%;
    }

    .total-div-left {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: center;
        width: 100%;
        border-right: 1px solid #9AA0A6;
    }

    .total-title {
        font-size: 18px;
        font-weight: 400;
        font-style: italic;
        color: #4A4A4A;
        margin-bottom: 20px;
    }

    .total-left-info-left {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: center;
        gap: 8px;
        width: 100%;
        border-left: 2px solid #FAD402;
        border-bottom: 2px solid #FAD402;
        border-radius: 0px 0px 0px 5px;
        background-color: #fff4b869;
    }

    .total-left-info-left p {
        font-size: 10px;
    }

    .total-left-info-right {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: center;
        gap: 8px;
        width: 100%;
        border-left: 2px solid #FAD402;
        border-bottom: 2px solid #FAD402;
        border-radius: 0px 0px 0px 5px;
        background-color: #fff4b869;
    }


    .total-left-info-right a {
        font-size: 10px;
    }

    .total-left-info-div {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 20px;
        width: 100%;

    }

    .total-div-right {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: end;
        width: 100%;
        border-left: 2px solid #9AA0A6;
    }

    .total-price-div {
        border: 2px solid #9AA0A6;
        display: flex;
        flex-direction: column;
        justify-content: start;
        align-items: start;
        background-color: aqua;
        border-radius: 5px;
        width: 80%;
    }

    .total-pirce-top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
        border-bottom: 2px solid #9AA0A6;
        background-color: white;
    }

    .total-price-top-left {
        width: 100%;
        font-size: 10px;
        font-weight: bold;
        padding: 5px;
        text-align: end;
        border-right: 2px solid #9AA0A6;

    }

    .total-price-top-right {
        width: 100%;
        font-size: 10px;
        padding: 5px;
        font-weight: bold;
        text-align: end;
    }

    .total-price-bottom {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
        background-color: #FAD402;
    }

    .total-price-bottom-left {
        width: 100%;
        font-size: 12px;
        font-weight: 700;
        padding: 5px;
        text-align: end;
        border-right: 2px solid #9AA0A6;
    }

    .total-price-bottom-right {
        width: 100%;
        font-size: 12px;
        font-weight: 700;
        padding: 5px;
        text-align: end;
    }

    .foot-text {
        color: #9AA0A6;
        font-size: 5.9px;
        text-align: center;
    }

    tr>th {
        font-size: 8px !important;
    }

    tr>td {
        font-size: 8px !important;
    }

    @media (min-width: 992px) {
        .banner-img {
            width: 30%;
            height: auto;
            position: absolute;
            top: 0px;
            left: 0px;
        }

        .iso-img {
            width: 10%;
            height: auto;
            position: absolute;
            top: 40px;
            right: 25px;
        }
    }
</style>


<div class="page-div">
    <div class="div-container">
        <!-- HEADER -->
        <div class="header-div">
            <img src="/AddOns/muraterennar/test_projects/assets/logodeneme.png" alt="banner" class="banner-img">
            <img src="/AddOns/muraterennar/test_projects/assets/iso9001_logo.png" alt="banner" class="h-auto iso-img">


            <div class="header-titles">
                <h1 class="header-top-title">YAF DIESELSHIP SPARE PARTSTRADING LTD. CO
                    <span class="header-sub-title">EVLIYA CELEBI MAH. RAUF ORBAY CAD.YAF GROUP IS MER. NO:39/2TUZLA
                        ISTANBUL</span>
                </h1>
                <h2 class="header-big-text">
                    ENQUIRY
                </h2>
            </div>
        </div>

        <!-- INFORMATION -->
        <div class="information-div">
            <div class="left-div">
                <div class="div-elements">
                    <div class="input-title">DATE</div>
                    <div class="input-value"><span>:</span> 25.3.2024</div>
                </div>
                <div class="div-elements">
                    <div class="input-title">OUR REF NO</div>
                    <div class="input-value"><span>:</span> YA -56574</div>
                </div>
                <div class="div-elements">
                    <div class="input-title">FROM</div>
                    <div class="input-value"><span>:</span> YANA BAKIR</div>
                </div>
                <div class="div-elements">
                    <div class="input-title">CURRENCY</div>
                    <div class="input-value"><span>:</span> EU</div>
                </div>
            </div>

            <div class="right-div">
                <div class="div-elements">
                    <div class="input-title">DELIVERY PLACE</div>
                    <div class="input-value"><span>:</span> UNKNOWN (EXW/EUROPE)</div>
                </div>
                <div class="div-elements">
                    <div class="input-title">DELIVERY COST</div>
                    <div class="input-value"><span>:</span> </div>
                </div>
                <div class="div-elements">
                    <div class="input-title">PAYMENT TERM</div>
                    <div class="input-value"><span>:</span> </div>
                </div>
                <div class="div-elements">
                    <div class="input-title">VALIDITY</div>
                    <div class="input-value"><span>:</span> 30 DAYS</div>
                </div>
            </div>
        </div>

        <!-- TABLE -->
        <div class="table-div">
            <div class="table-top">
                <div class="table-top-div">
                    <div class="table-top-elements">
                        <p style="font-weight: 700; font-size: 10px;">AIR COMPRESSOR</span>
                    </div>

                    <div class="table-top-elements">
                        <p style="font-size: 10px;">BRAND</p>
                        <p style="font-weight: 700; font-size: 10px;">SPERRE</p>
                    </div>

                    <div class="table-top-elements">
                        <p class="font-size: 10px;">TYPE</p>
                        <p style="font-weight: 700; font-size: 10px;">HL2/105</p>
                    </div>
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
                        <tr class="table-tr">
                            <td>1</td>
                            <td>3036MK2</td>
                            <td>OVERHAUL KIT, LP VALVE</td>
                            <td>3</td>
                            <td>SET</td>
                            <td>83.05 EU</td>
                            <td>249.16 EU</td>
                            <td>OFFERED AS LP VLV REPAIR KIT</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>3037MK2</td>
                            <td>OVERHAUL KIT, HP VALVE</td>
                            <td>5</td>
                            <td>SET</td>
                            <td>51.54 EU</td>
                            <td>257.72 EU</td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="page-text-div">
            <p class="page-text">
                ACCORDING TO SOLAS CHAPTER II-1 PART A-1 REGULATION 3-5,YOU CONFIRM THAT AN OFFERED
                PARTS DOESN'T CONSISTS ASBESTOS. ASBESTOS-FREE
            </p>
        </div>

        <!-- Total Price -->
        <div class="total-div">
            <div class="total-div-left">
                <h3 class="total-title">THANK YOU FOR YOUR QUOTATION !</h3>
                <div class="total-left-info-div">
                    <div class="total-left-info-left">
                        <p>0090 216 494 49 02</p>
                        <p>0090 850 225 23 00</p>
                    </div>
                    <div class="total-left-info-right">
                        <a href="mailto:info@yafdiesel.com.trf" target="_blank">INFO@YAFDIESEL.COM.TR</a>
                        <a href="www.yafdiesel.com.trf" target="_blank">WWW.YAFDIESEL.COM.TR</a>
                    </div>
                </div>
            </div>
            <div class="total-div-right">
                <div class="total-price-div">
                    <div class="total-pirce-top">
                        <p class="total-price-top-left">ENQUIRY SUBTOTAL :</p>
                        <p class="total-price-top-right">506.87 EU</p>
                    </div>
                    <div class="total-pirce-top">
                        <p class="total-price-top-left">TOTAL DISCOUNT :</p>
                        <p class="total-price-top-right">506.87 EU</p>
                    </div>
                    <div class="total-price-bottom">
                        <p class="total-price-bottom-left">TOTAL AMOUNT:</p>
                        <p class="total-price-bottom-right">506.87 EU</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>