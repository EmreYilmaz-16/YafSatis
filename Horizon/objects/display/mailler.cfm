	
			<link href="/JS/assets/lib/kothing/css/kothing-editor.min.css?v=18112020" rel="stylesheet">

			<link rel="stylesheet" href="/JS/codemirror/lib/codemirror.css">
			<link rel="stylesheet" href="/JS/codemirror/theme/mdn-like.css">
			<script src="/JS/codemirror/lib/codemirror.js"></script>		
			<script src="/JS/codemirror/mode/xml/xml.js"></script>
			<script src="/JS/codemirror/mode/javascript/javascript.js"></script>
			<script src="/JS/codemirror/mode/css/css.js"></script>
			<script src="/JS/codemirror/mode/vbscript/vbscript.js"></script>
			<script src="/JS/codemirror/mode/htmlmixed/htmlmixed.js"></script>
			<script src="/JS/codemirror/addon/show-hint.js"></script>
			<script src="/JS/codemirror/addon/selection/selection-pointer.js"></script>
			<script src="/JS/codemirror/addon/css-hint.js"></script>
			<script src="/JS/codemirror/addon/lint.js"></script>
			<script src="/JS/codemirror/addon/css-lint.js"></script>

<cf_box title="Mail Gönder" scroll="1" collapsable="1" resize="1" popup_box="1">
    <div>
        <a href="javascript://" onclick="MailGonderCanim()" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left"><i class="fa fa-repeat"></i>CHANGE STATUS</a>
    </div>
    <br>
<div style="display:flex">
    <div style="width:50%">
        <textarea name="plus_content" id="plus_content"></textarea>
    </div>
    <div style="width:50%">
        <div>
<cfset attributes.preview=1>
            <cfinclude template="/AddOns/YafSatis/Horizon/Pages/PdfDesign/PdfPrint.cfm">
        </div>
    </div>
</div>

</cf_box>



    <script>
			
            var buttonList = [
                ['undo', 'redo'],
                ['font', 'fontSize', 'formatBlock'],
                ['bold', 'underline', 'italic', 'strike', 'subscript', 'superscript'],
                ['removeFormat'],
                ['fontColor', 'hiliteColor'],
                ['outdent', 'indent'],
                ['align', 'horizontalRule', 'list', 'table'],
                ['link', 'image', 'video'],
                ['showBlocks', 'codeView'],
                ['fullScreen','preview']
            ];
        
    if(typeof CKEDITOR == 'undefined') var CKEDITOR = {instances: {}};
    $(document).ready(function() { 
        
        setTimeout(function(){
            weditor_plus_content = KothingEditor.create('plus_content', {
                mode: "classic",
                display: 'block',
                popupDisplay : 'local',
                iframe : true,
                width: '100%',
                height : '200',
                codeMirror: CodeMirror,			
                charCounter: true,
                
                stickyToolbar : "45",
                toolbarItem : buttonList,
                imageUploadHeader: {"Access-Control-Allow-Origin": "*"},
                imageUploadUrl : "/fckeditor/cfc/editor.cfc?method=upload_image"	
            });		
            weditor_plus_content.onChange = function(contents) {
                /*zero-width space replace ediliyor*/
                content_val = contents.replace(/\u200B/g,'');
                var find = '​';
                var rgx = new RegExp(find, 'g');
                content_val = content_val.replace(rgx, '');
                $('textarea[name="plus_content"]').val(content_val);
            };
            /*CK Editor kullanılıyorken yapılan kontroller için yeni editörde benzer fn oluşturldu SA030920*/
            if(!CKEDITOR.instances.hasOwnProperty('plus_content')) CKEDITOR["instances"]["plus_content"] = {};
            CKEDITOR["instances"]["plus_content"] = {
                getData: function() {
                    /*zero-width space replace ediliyor*/
                    content = weditor_plus_content.getContents();
                    content_val = content.replace(/\u200B/g,'');
                    var find = '​';
                    var rgx = new RegExp(find, 'g');
                    content_val = content_val.replace(rgx, '');
                    return content_val
                }
            };
            
        },300);				
    });

    $(document).on('change', '#item-plus_content .CodeMirror', function() {
        $("#item-plus_content ._ke_command_codeView").trigger("click").trigger("click");
        weditor_plus_content.save();
    });
    
    
    
</script>
<script src="/JS/assets/lib/kothing/kothing-editor.min.js?v=02022021"></script>	
<script src="/JS/assets/lib/kothing/src/lang/en.js"></script>
<!------------------>