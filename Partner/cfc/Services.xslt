<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
  <html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous"></link>
    </head>
  <body>
  <div class="card" >
  <div class="card-body">
    <h5 class="card-title"><xsl:value-of select="Service/name" /></h5>
    <h6 class="card-subtitle mb-2 text-body-secondary"><xsl:value-of select="Service/service_path" /></h6>
    <p class="card-text">
    

    
    <table class="table table-sm table-striped">
      <tr >
        <th style="width:30%">Fonksiyon</th>
        <th>Parametreler</th>
      </tr>
      <xsl:for-each select="Service/methods/method">
      <tr>
        <td>
            <xsl:value-of select="name" /><br/>
         <code>
            <b>Dönüş Tipi :</b> <xsl:value-of select="returns" /><br/>
           <b>Açıklama :</b> <xsl:value-of select="description" /><br/>
        </code>
        </td>
        <td><table class="table table-sm table-striped">
            <tr>
                <th>
                    Parametre Adı
                </th>
                <th>
                    Tip
                </th>
                <th>
                    Zorunlu
                </th>
                <th>
                    Açıklama
                </th>
            </tr>
            <xsl:for-each select="./params/name">
       <tr>
        <td style="width:20%"> <xsl:value-of select="." /></td>
        <td style="width:20%"> <xsl:value-of select="./@type" /></td>
        <td style="width:20%"> <xsl:value-of select="./@required" /></td>
        <td style="width:40%">  <xsl:value-of select="./@description" /></td>
        
    
    </tr>
    </xsl:for-each>
</table>
</td>
      </tr>
      </xsl:for-each>
    </table>
        </p>   
  </div>
</div>
  </body>
  </html>
</xsl:template>
</xsl:stylesheet>
