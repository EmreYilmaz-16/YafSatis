<cfset attributes.is_sale=0>
<cfset attributes.offer_id=26>
<cfset FNMN=CreateUUID()>

<!----
<cftry>
	<cfhttp url="http://127.0.0.1:8995/PDFgServlet/verify" method="get" result="httpResult"></cfhttp>
	<cfdump var="#httpResult#" label="Verify PDFg service using CFHTTP - Result">
<cfcatch type="any" >
	<cfdump var="#cfcatch#" label="Verify PDFg service using CFHTTP - Error">
</cfcatch>	
</cftry>


<cfdocument
name="TEST_PDF"
format="PDF"
pagetype="A4"
margintop="1"
marginbottom="1"
marginright="1"
marginleft="2"
unit="cm"
mimetype="image/png"
filename="C:/MailPdf/sab#FNMN#.pdf"
overwrite="true"
localurl="true">
<cfinclude template="/AddOns/YafSatis/Horizon/Pages/PdfDesign/PdfPrint.cfm">
</cfdocument>+----->

<cfhtmltopdf pagetype="A4" overwrite="true"  destination="C:/W3/PROD/devcatalyst/MailPdf/#FNMN#.pdf" name="PDF_ALAN_YER">
    
   <cfinclude template="/AddOns/YafSatis/Horizon/Pages/PdfDesign/PdfPrint.cfm"><!----- ---->
   Merhaba Dnya Ben Emre Buralar Çok Yeşil
    
</cfhtmltopdf>

<cfset FORMDATAM.MailTOList="yazilim@partnerbilgisayar.com">
<cfset FORMDATAM.CClist="yazilim@partnerbilgisayar.com">
<cfset FORMDATAM.BCClist="yazilim@partnerbilgisayar.com">

<cfset MailService=createObject("component","AddOns.YafSatis.Partner.cfc.mailService")>

<cfscript>
    MailService.SendMail(MailBody="FORMDATAM.FHtml",FromMail="info@partnerbilgisayar.com",ToMailList="#FORMDATAM.MailTOList#",ToCCMailList="#FORMDATAM.CClist#",ToBCCMailList="#FORMDATAM.BCClist#",fffile="#FNMN#.pdf",ffftype="application/pdf",fffcontent="#PDF_ALAN_YER#",subject="Deneme Mailidir")
</cfscript>