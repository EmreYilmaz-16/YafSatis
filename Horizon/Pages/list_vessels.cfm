<div>
    <button onclick="getlist()">Liste Getir</button>
</div>

<div id="ListeAlani">

</div>

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