<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <head>
        <title>Clima en <xsl:value-of select="/root/nombre"/>: Predicción para las próximas horas.</title>
      </head>
      <body>
        <h1>Clima en <xsl:value-of select="/root/nombre"/>: Predicción para las próximas horas.</h1>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
