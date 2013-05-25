#!/bin/bash
#Tomamos dir raiz y dir destino
DIR=$1;
DEST=$2;

#Metodo con un for que convierte y copia las imagenes
convertir(){
	#Accedemos al dir raiz
	cd $DIR;
	#Para que el listado de archivos sea archivo por linea
	dir=$(dir -1);
	#Convertimos las imagenes
	for file in $dir;do
		#Convertimos con la herramienta convert de imageMagick
		echo "Convirtiendo: "$file;
		convert $file -quality 50 $DEST$file;
	done;
}

#Validamos que el directorio raiz existe
if [ -d $DIR ];
then
	#Si exste valida que el dir destino tambien exista
	if [ -d $DEST ];
	then
		#Si existe el destino llama el metodo convertir que crea las imagenes
		convertir;
	else
		#Manda el mensaje que el directorio destio no existe
		echo "¿Quieres crear el directorio "$DEST" ? [y/n]";
		read resp;
		#Si la respuesta es si creamos el dir
		if [ $resp = "y" ];
		then
			#Si se crea el destino llama el metodo, si no manda el error
			echo "Creando: "$DEST;
			if ( mkdir $DEST );
			then
				convertir;
			else
				echo "No se pudo crear "$DEST;
			fi
		else
			echo "El directorio destino no existe";
		fi
	fi
else
	#Manda el mensaje porque el directorio raiz no existe
	echo "El Directorio no existe";
fi
