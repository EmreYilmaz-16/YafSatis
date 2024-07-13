
function getCatProperties(cat_id) {
    AjaxPageLoad(
        "index.cfm?fuseaction=objects.emptypopup_hrz_pbs_smartTools&ListType=catProps&PRODUCT_CATID=" +
          cat_id,
        "PROP_AREA",
        1,
        "Yükleniyor"
      );
  }