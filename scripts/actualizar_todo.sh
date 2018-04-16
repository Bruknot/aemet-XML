#!/bin/bash

#Se establecen las variables con las rutas
# de los archivos del proyecto
PREDHORASHTML="../html/pred_horas.html"
PREDHORASXML="../xml/pred_horas.xml"
PREDHORASXSL="../xsl/pred_horas.xsl"
CSS="../css/estilo.css"
PRED7DHTML="../html/pred_7dias.html"
PRED7DXML="../xml/pred_7dias.xml"
PRED7DXSL="../xsl/pred_7dias.xsl"

#Se establecen las variables con las rutas
# de los archivos en el servidor web (en local)
PREDHORASSERV="/var/www/html/aemet-huesca/pred_horas.html"
PRED7DSERV="/var/www/html/aemet-huesca/pred_7dias.html"
CSSSERV="/var/www/html/aemet-huesca/css/estilo.css"

#Se establecen las URL de los XML proporcionados
# por la web AEMET para el municipio seleccionado
PREDHORASURL="http://www.aemet.es/xml/municipios_h/localidad_h_22125.xml"
PRED7DURL="http://www.aemet.es/xml/municipios/localidad_22125.xml"

#Se obtiene el texto con la fecha/hora actual
# para el mensaje del commit
FECHAHORA1=`date +%d/%m/%Y_%H:%M`
FECHAHORA2=`date +"el día "%d/%m/%Y" a las "%H:%M`

#Se borran los ficheros XML antiguos
rm $PREDHORASXML
rm $PRED7DXML

#Se obtienen los XML actualizados de AEMET
wget $PREDHORASURL -O $PREDHORASXML
wget $PRED7DURL -O $PRED7DXML

#Se generan los html a partir de los XML nuevos
# y las plantillas XSLT
xsltproc $PREDHORASXSL $PREDHORASXML > $PREDHORASHTML
xsltproc $PRED7DXSL $PRED7DXML > $PRED7DHTML

#Se sustituyen los archivos generados
# por los publicados en el servidor web
# para actualizarlos con los nuevos datos
cp $PRED7DHTML $PRED7DSERV
cp $PREDHORASHTML $PREDHORASSERV
cp $CSS $CSSSERV

#Se actualiza el servidor git
#Atención, si ejecutamos este script dos veces
#seguidas, como los xml serán iguales no cambiará
#el resultado HTML de la transformación XSL, por
#lo que es normal que nos diga el git commit que 
#está todo actualizado y no hay ningún cambio
git add -A
git commit -m "Actualiza archivos $FECHAHORA1" -m "Actualiza los archivos xml y html en el proyecto local $FECHAHORA2"
git push
