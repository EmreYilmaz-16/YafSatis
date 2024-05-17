<div>
    <button onclick="getlist()">Liste Getir</button>
</div>

<div id="ListeAlani">

</div>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
    function getlist(params) {
      var FormStr="";
        AjaxPageLoad(
    "index.cfm?fuseaction=sales.emptypopup_list_vessels&FormData=" +
      FormStr,
    "ListeAlani",
    1,
    "Yükleniyor"
  );
    }
</script>