<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#" enctype="multipart/form-data" >
    <div class="form-group">
        <input type="file" name="file_11" id="file_11">
        <input type="hidden"  name="FileName" id="FileName"> 
    </div>
  
<input type="submit">
<input type="hidden" name="is_submit">
</cfform>

<cfif isDefined("attributes.is_submit")>
    <cffile action = "upload"
	fileField = "file_11"
	destination = "#expandPath("./ExDosyalar")#" 
	nameConflict = "Overwrite" result="resul"> 

    <cfspreadsheet  action="read" src = "#expandPath("./ExDosyalar/#attributes.fileName#")#" query = "res">

	<cfquery name = "get_invoice_no" dbtype = "query" result="ressa">
		SELECT *                 
		FROM
			res     
	</cfquery>

<cfdump var="#ressa#">

<cfloop from="7" to="#listLen(ressa.COLUMNLIST)-4#" index="i" step="4">
    <cfset IS_IMPORTANT=evaluate("COL_#i#")>
    <cfset CP=evaluate("COL_#i+1#")>
    <cfset PROP=evaluate("COL_#i+2#")>
    <cfset VARS=evaluate("COL_#i+3#")>
<cfoutput>
    IS_IMPORTANT: #IS_IMPORTANT#<br>
    C/P: #CP#<br>
    PROPERTY: #PROP#<br>
    VARIATION: #VARS#<br>
</cfoutput>


</cfloop>




</cfif>




<script>    
    $('#file_11').change(function(e){
            var fileName = e. target. files[0]. name;
            $("#FileName").val(fileName)
        });
    </script>