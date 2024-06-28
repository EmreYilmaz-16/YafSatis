<script src="https://cdn.tailwindcss.com"></script>

<style>
    body {
        background: #fff;
    }

    .custom_div:after,
    .custom_div:before {
        display: block !important;
        content: none !important;
    }
</style>

<div class="container mx-auto min-h-screen">
    <div class="flex justify-between items-start mt-8">
        <div class="h-auto w-full">
            <img src="../assets/image017.png" class="w-[100px] lg:w-[200px] h-auto"
                alt="logo">
        </div>

        <div class="w-full h-auto w-full float-end flex flex-col justify-end items-end">
            <img src="../assets/image006.png"
                class="float-end w-[80px] lg:w-[130px] h-auto" alt="logo">
            <div
                class="text-end w-full flex flex-col justif-center items-end [&>h1]:font-bold [&>h1]:text-sm lg:[&>h1]:text-xl">
                <h1 class="uppercase me-8">YAF DIESEL SHIP PARTS TRADING LTD. CO</h1>
                <span class="uppercase me-8 text-[9px] lg:text-base w-full text-nowrap">evliya celebi mah. rauf orbay
                    cad. yaf group is mer. no:39/2 tuzla
                    istanbul</span>
                <span class="uppercase mt-12 text-3xl font-semibold line-clamp-3 tracking-[.30rem] text-[#F1A73A]">DEBIT
                    NOTE</span>
            </div>
        </div>
    </div>

    <div class="grid grid-cols-2 custom_div">
        <div class="flex flex-col justify-start items-start [&>span]:font-semibold">
            <span class="uppercase">Solna denizcilik</span>
        </div>

        <div class="flex flex-col justify-start items-start">
            <div class="flex justify-start items-start [&>span]:font-semibold">
                <span class="uppercase">Date : </span>
                <span class="uppercase"></span>
            </div>
            <div class="flex justify-start items-start [&>span]:font-semibold">
                <span class="uppercase">Our ref no : </span>
                <span class="uppercase"></span>
            </div>

            <div class="flex justify-start items-start [&>span]:font-semibold">
                <span class="uppercase">your ref no : </span>
                <span class="uppercase"></span>
            </div>
        </div>

    </div>

    <div class="w-full flex- justify-center items-center uppercase text-xl lg:text-2xl font-semibold text-[#F1A73A] mt-6">
        delivery receipt
    </div>

    <div class="overflow-hidden mt-6">
        <table class="table-auto w-full">
            <tr class="[&>th]:font-semibold uppercase">
                <th>no</th>
                <th>part no</th>
                <th>part name</th>
                <th>qty</th>
                <th>unit</th>
            </tr>
            <tbody>
                <tr class=" [&>td]:text-center">
                    <td>1</td>
                    <td>:XX.XX.XX</td>
                    <td>:XX.XX.XX</td>
                    <td>:XX.XX.XX</td>
                    <td>:XX.XX.XX</td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="grid grid-cols-2 mt-36 gap-4 custom_div">
        <div class="flex flex-col justify-start items-start">
            <div class="flex justify-start items-start [&>span]:uppercase">
                <span>recipient</span>
                <span></span>
            </div>
            <div class="flex justify-start items-start [&>span]:uppercase">
                <span>name</span>
                <span></span>
            </div>
            <div class="flex justify-start items-start [&>span]:uppercase">
                <span>surname</span>
                <span></span>
            </div>
            <div class="flex justify-start items-start [&>span]:uppercase">
                <span>address</span>
                <span></span>
            </div>
        </div>

        <div class="flex flex-col justify-start items-center gap-4 [&>span]:uppercase">
            <span>date</span>
            <div class="flex justify-center items-center">
                <span>......</span>
                <span>/</span>
                <span>......</span>
                <span>/</span>
                <span>......</span>
            </div>
            <span>signature</span>
        </div>
    </div>


</div>