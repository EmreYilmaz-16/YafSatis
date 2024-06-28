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

<div class="container mx-auto relative min-h-[90vh]">
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
                <span
                    class="uppercase mt-12 text-3xl font-semibold line-clamp-3 tracking-[.30rem] text-[#F1A73A]">CREDIT
                    NOTE</span>
            </div>
        </div>
    </div>


    <div class="grid grid-cols-12 gap-4 custom_div mt-12 container mx-auto">
        <div
            class="flex flex-col justify-start items-start [&>h4]:text-base [&>h4]:capitalize [&>h4]:font-medium col-span-3">
            <h4 class="capitilaze">customer</h4>
            <div class="flex flex-col [&>span]:text-lg [&>span]:text-[#808080]">
                <span>:xx.xx.xx</span>
                <span>:xx.xx.xx</span>
                <span>:xx.xx.xx</span>
            </div>

        </div>
        <div
            class="flex flex-col justify-start items-start [&>h4]:text-base [&>h4]:capitalize [&>h4]:font-medium col-span-3">
            <h4>ship to</h4>
            <div class="flex flex-col [&>span]:text-lg [&>span]:text-[#808080]">
                <span>:xx.xx.xx</span>
                <span>:xx.xx.xx</span>
                <span>:xx.xx.xx</span>
            </div>
        </div>

        <div class="flex flex-col justify-start items-start col-span-6">
            <div
                class="grid grid-cols-2 justify-start items-center [&>h4]:capitilaze gap-2 custom_div [&>h4]:text-base [&>h4]:capitalize [&>h4]:font-medium [&>span]:text-lg [&>span]:text-[#808080] ">
                <h4>credit note #</h4>
                <span>:xx.xx.xx</span>
            </div>
            <div
                class="grid grid-cols-2 justify-start items-center [&>h4]:capitilaze gap-2 custom_div [&>h4]:text-base [&>h4]:capitalize [&>h4]:font-medium [&>span]:text-lg [&>span]:text-[#808080] ">
                <h4>Credit Note Date</h4>
                <span>:xx.xx.xx</span>
            </div>
            <div
                class="grid grid-cols-2 justify-start items-center [&>h4]:capitilaze gap-2 custom_div [&>h4]:text-base [&>h4]:capitalize [&>h4]:font-medium [&>span]:text-lg [&>span]:text-[#808080] ">
                <h4>P.O.#</h4>
                <span>:xx.xx.xx</span>
            </div>
            <div
                class="grid grid-cols-2 justify-start items-center [&>h4]:capitilaze gap-2 custom_div [&>h4]:text-base [&>h4]:capitalize [&>h4]:font-medium [&>span]:text-lg [&>span]:text-[#808080] ">
                <h4>Due Date</h4>
                <span>:xx.xx.xx</span>
            </div>

        </div>
    </div>

    <div class="overflow-hidden border-t border-black w-full mt-12">
        <table class="w-full table-auto">
            <tr
                class="h-12 bg-[#F1A73A] [&>th]:uppercase [&>th]:border-r border-x border-b border-black [&>th]:border-black [&>th:last-child]:border-0">
                <th>qty</th>
                <th>description</th>
                <th class="w-[180px] lg:w-auto">unit price</th>
                <th>amount</th>
            </tr>

            <tr
                class="border-b border-black [&>td]:border-r border-x [&>td]:text-[#808080] [&>td]:text-center [&>td:first-child]:text-black [&>td]:border-black [&>td:last-child]:border-0 ">
                <td>1</td>
                <td>:XX.XX.XX</td>
                <td>:XX.XX.XX</td>
                <td>:XX.XX.XX</td>
            </tr>

            <tr
                class="border-b border-black [&>td]:border-r border-x [&>td]:text-[#808080] [&>td]:text-center [&>td:first-child]:text-black [&>td]:border-black [&>td:last-child]:border-0 ">
                <td>1</td>
                <td>:XX.XX.XX</td>
                <td>:XX.XX.XX</td>
                <td>:XX.XX.XX</td>
            </tr>

            <tr
                class="border-b border-black [&>td]:border-r border-x [&>td]:text-[#808080] [&>td]:text-center [&>td:first-child]:text-black [&>td]:border-black [&>td:last-child]:border-0 ">
                <td>1</td>
                <td>:XX.XX.XX</td>
                <td>:XX.XX.XX</td>
                <td>:XX.XX.XX</td>
            </tr>

            <tr
                class=" [&>td]:border-r [&>td]:text-[#808080] [&>td]:text-center [&>td:first-child]:text-black [&>td]:border-black [&>td:last-child]:border [&>td:nth-child(1)]:border-none [&>td:nth-child(2)]:border-none">
                <td class="invisible"></td>
                <td class="invisible"></td>
                <td>
                    <div class="flex flex-col [&>span]:text-end justify-end items-end">
                        <span class="uppercase text-black me-2">subtotal sales tax 0,5%</span>
                    </div>
                </td>
                <td>
                    <div class="flex flex-col">
                        <span class="uppercase">eu</span>
                        <span class="uppercase">eu</span>
                    </div>
                </td>
            </tr>

            <tr
                class=" [&>td]:border-r [&>td]:text-[#808080] [&>td]:text-center [&>td:first-child]:text-black [&>td]:border-black [&>td:last-child]:border [&>td:nth-child(1)]:border-none [&>td:nth-child(2)]:border-none [&>td:nth-child(3)]:border-none">
                <td class="invisible"></td>
                <td class="invisible"></td>
                <td class="flex flex-col [&>span]:text-end">
                    <span class="uppercase text-xl font-semibold text-black me-2">total</span>
                </td>
                <td class="bg-[#F7A900]">
                    <span class="uppercase text-xl font-semibold text-black">eu</span>
                </td>
            </tr>
        </table>
    </div>

    <div class="absolute bottom-0 left-0">
        <div class="flex justify-start items-center gap-6">
            <div class="border-s border-[#F7A900] px-4 flex flex-col [&>a]:text-[#808080]">
                <a href="tel:+902164944902">+90 216 49 49 02</a>
                <a href="tel:+902164944902">+90 850 225 23 00</a>
            </div>

            <div class="border-s border-[#F7A900] px-4 flex flex-col [&>a]:text-[#808080]">
                <a href="mailto:info@yafdiesel.com.tr">info@yafdiesel.com.tr</a>
                <a href="http://www.yafdiesel.com.tr" target="_blank" rel="noopener noreferrer">www.yafdiesel.com.tr</a>
            </div>
        </div>
    </div>
</div>