<cfset attributes.fuseaction="">
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#" enctype="multipart/form-data" >
    <div class="form-group">
        <input type="file" name="file_11" id="file_11">
        <input type="hidden"  name="FileName" id="FileName"> 
    </div>
  
<input type="submit">
<input type="hidden" name="is_submit">
</cfform>
<cfoutput>
    #expandPath("./AddOns/YafSatis/Horizon/PrintFiles")#
</cfoutput>
<cfif isDefined("attributes.is_submit")>
    <cffile action = "upload"
    fileField = "file_11"
    destination = "#expandPath("./ExDosyalar")#" 
    nameConflict = "Overwrite" result="resul"> 
<!----
    <cfif isDefined("Form.FileContents") > 
        <cffile action = "upload" fileField = "FileContents" destination = "#expandPath("../WORKCUBE_DOSYA/LIVE/Documents/service")#" nameConflict = "Overwrite" result="aaaa">
        </cfif>
      <cfset emre= CreateUUID()>
        
---->
<cfset emre= CreateUUID()>
<cffile action="rename" source="#resul.SERVERDIRECTORY#/#resul.CLIENTFILE#" destination="#resul.SERVERDIRECTORY#/#emre#.#resul.CLIENTFILEEXT#" result="nbbb">


Horizon\Pages\add_print_file.cfm





</cfif>


<script>    
    $('#file_11').change(function(e){
    var fileName = e. target. files[0]. name;
    $("#FileName").val(fileName)
    });
</script>