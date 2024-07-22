<cfset attributes.fuseaction="">
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#" enctype="multipart/form-data" >
<cfquery name="getpt" datasource="#dsn3#">
    select PROCESS_TYPE.PROCESS_ID,PROCESS_TYPE.PROCESS_NAME,PROCESS_TYPE_ROWS.PROCESS_ROW_ID,PROCESS_TYPE_ROWS.STAGE,CASE WHEN PROCESS_TYPE.PROCESS_ID=193 THEN 'SATIŞ SÜREÇLERİ' ELSE 'ALIŞ SÜREÇLERİ' END AS ISLEM_TIPI from CatalystQA.PROCESS_TYPE_ROWS 
LEFT JOIN CatalystQA.PROCESS_TYPE ON PROCESS_TYPE.PROCESS_ID=PROCESS_TYPE_ROWS.PROCESS_ID
WHERE PROCESS_TYPE.PROCESS_ID IN (193,194) ORDER BY PROCESS_ID,LINE_NUMBER
</cfquery>
    <div class="form-group">
        <select name="PTA" multiple>
            <cfoutput query="getpt" group="PROCESS_ID">
            <optgroup label="#ISLEM_TIPI#">
                <cfoutput>
                    <option value="#PROCESS_ROW_ID#">#STAGE#</option>
                </cfoutput>
            </optgroup>
        </cfoutput>
        </select>
</div>
    <div class="form-group">
        <input type="file" name="file_11" id="file_11">
        <input type="hidden"  name="FileName" id="FileName"> 
    </div>
  
<input type="submit">
<input type="hidden" name="is_submit">
</cfform>
<cfoutput>
    #expandPath("./AddOns/YafSatis/PrintFiles")#
</cfoutput>
<cfif isDefined("attributes.is_submit")>

    <cffile action = "upload"
    fileField = "file_11"
    destination = "#expandPath("./AddOns/YafSatis/PrintFiles")#" 
    nameConflict = "Overwrite" result="resul"> 
<!----
    <cfif isDefined("Form.FileContents") > 
        <cffile action = "upload" fileField = "FileContents" destination = "#expandPath("../WORKCUBE_DOSYA/LIVE/Documents/service")#" nameConflict = "Overwrite" result="aaaa">
        </cfif>
      <cfset emre= CreateUUID()>
        
---->
<cfset emre= CreateUUID()>
<cffile action="rename" source="#resul.SERVERDIRECTORY#/#resul.CLIENTFILE#" destination="#resul.SERVERDIRECTORY#/#emre#.#resul.CLIENTFILEEXT#" result="nbbb">

<cfquery name="ins" datasource="#dsn3#">
    INSERT INTO PROCESS_TYPE_PRINTS (PROCESS_ROW_ID,PRINT_FILE_PATH) VALUES(#attributes.PTA#,'#resul.SERVERDIRECTORY#/#emre#.#resul.CLIENTFILEEXT#')
</cfquery>






</cfif>


<script>    
    $('#file_11').change(function(e){
    var fileName = e. target. files[0]. name;
    $("#FileName").val(fileName)
    });
</script>