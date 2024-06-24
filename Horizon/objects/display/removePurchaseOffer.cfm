<cfquery name="rem" datasource="#dsn3#">
    DELETE FROM PBS_OFFER WHERE OFFER_ID =#attributes.OFFER_ID#
</cfquery>
<cfquery name="REM2" datasource="#DSN3#">
    DELETE FROM PBS_OFFER_ROW WHERE OFFER_ID=#attributes.OFFER_ID#
</cfquery>
<cfquery name="REMM3" datasource="#DSN3#">
    DELETE FROM PBS_OFFER_MONEY WHERE ACTION_ID=#attributes.OFFER_ID#
</cfquery>


<script>
alert("Silinmiştir")
    window.opener.location.reload();
    this.close();
</script>