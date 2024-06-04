<cf_box title="Mail Gönder" scroll="1" collapsable="1" resize="1" popup_box="1">
    <div>
        <a href="javascript://" onclick="MailGonderCanim()" class="ui-wrk-btn ui-wrk-btn-extra ui-wrk-btn-addon-left"><i class="fa fa-repeat"></i>CHANGE STATUS</a>
    </div>
<div class="row">
    <div class="col col-6">
        <textarea name="plus_content"></textarea>
    </div>
    <div class="col col-6">
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
