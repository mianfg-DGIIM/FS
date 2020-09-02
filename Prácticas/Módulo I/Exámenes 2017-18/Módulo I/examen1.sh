# EXAMEN 1 BASH - FUNDAMENTOS DEL SOFTWARE 1º DGIIM GRUPO 1
# Alumno: Miguel Ángel Fernández Gutiérrez, 20070335Y

#!/bin/bash

function _ayuda {
	echo 'Este script tiene el siguiente funcionamiento:'
	echo '    ./examen1.sh --c argumentos : los argumentos pueden ser uno o más nombres de archivos planos que serán copiados en el último argumento que deberá ser el nombre de un archivo tipo directorio. En caso de que los argumentos no representen nombres de archivos del tipo esperado, se mostrará esta ayuda'
	echo '     ./examen1.sh --b nombre_directorio o ./examen1.sh nombre_directorio : copia el directorio dado como argumento en otro directorio con nombre formado con el nombre_directorio terminado en "_backup" previo confirmación'
	echo '     ./examen1.sh --h o sin : muestra ayuda en pantalla'
	echo "Si el guion se ejecuta sin argumentos o con un número erróneo de argumentos o un tipo de argumento no esperado, el script mostrará el error y la ayuda"
}

if [[ $# == 0 ]]; then
	_ayuda
else
	if [[ $1 == "--h" ]]; then
		_ayuda
	elif [[ $1 == "--c" ]]; then
		if [[ $# -ge 3 ]]; then
			ARCHIVOS_A_COPIAR=""
			COPIAR=true  # para que si hay algún error no se realice la copia
			for argumento in $@; do
				# comprobamos si se trata del primer argumento, --c
				if [[ $argumento == "--c" ]]; then
					COPIAR=true
				# comprobamos si se trata del último argumento, en cuyo caso querremos saber si es un directorio válido
				elif [[ $argumento == ${!#} ]]; then
					# comprobaremos si existe el directorio al que se quiere copiar
					if [[ `test -d $argumento; echo $?` == 1 ]]; then
						echo 'ERROR: No ha insertado un directorio válido a copiar. Inténtelo de nuevo'
						COPIAR=false
					fi
				# el resto de los argumentos deben ser archivos válidos
				else
					if [[ `test -f $argumento; echo $?` == 0 ]]; then
						ARCHIVOS_A_COPIAR=`echo "$ARCHIVOS_A_COPIAR $argumento"`
					else
						# hay algún error (no existe algún archivo), no efectuaremos la copia
						echo 'ERROR: Uno de los archivos que ha insertado no existe. Inténtelo de nuevo'
						COPIAR=false
					fi
				fi
			done
			# copiar los archivos si es posible
			if [[ $COPIAR == true ]]; then
				cp $ARCHIVOS_A_COPIAR ${!#}
				echo 'Los archivos se han copiado satisfactoriamente'
			else
				echo "-------------------------"
				_ayuda
			fi
		else
			echo 'ERROR: Número incorrecto de argumentos'
			echo "-------------------------"
			_ayuda
		fi

	elif [[ $1 == "--b" ]]; then
		# comprobamos si existe el directorio que queremos copiar
		if [[ `test -d $2; echo $?` == 0 ]]; then
			DIRECTORIO_A_COPIAR=`echo $2"_backup"`
			# confirmación de copia
			read -p "¿Desea copiar $2 en $DIRECTORIO_A_COPIAR? (y/n): " CONFIRMACION
			if [[ $CONFIRMACION == y ]]; then
				# creamos el directorio donde queremos copiar, en caso de que no exista todavía
				if ! [[ `test -d $DIRECTORIO_A_COPIAR; echo $?` == 0 ]]; then
					mkdir $DIRECTORIO_A_COPIAR
				fi
				cp -r $2/* $DIRECTORIO_A_COPIAR
				echo "Los contenidos de $2 han sido copiados satisfactoriamente en $DIRECTORIO_A_COPIAR"
			elif [[ $CONFIRMACION == n ]]; then
				echo 'No se realizará ninguna copia'
			else
				echo 'ERROR: No ha confirmado correctamente. Tenga en cuenta que debe introducir la letra y en minúscula para proceder'
				echo "-------------------------"
				_ayuda
			fi
		else
			echo 'ERROR: El directorio no existe. Inténtelo de nuevo'
			echo "-------------------------"
			_ayuda
		fi
	elif [[ `test -d $1; echo $?` == 0 ]]; then
		DIRECTORIO_A_COPIAR=`echo $1"_backup"`
		# confirmación de copia
		read -p "¿Desea copiar $1 en $DIRECTORIO_A_COPIAR? (y/n): " CONFIRMACION
		if [[ $CONFIRMACION == y ]]; then
			# creamos el directorio donde queremos copiar, en caso de que no exista todavía
			if ! [[ `test -d $DIRECTORIO_A_COPIAR; echo $?` == 0 ]]; then
				mkdir $DIRECTORIO_A_COPIAR
			fi
			cp -r $1/* $DIRECTORIO_A_COPIAR
			echo "Los contenidos de $1 han sido copiados satisfactoriamente en $DIRECTORIO_A_COPIAR"
		elif [[ $CONFIRMACION == n ]]; then
			echo 'No se realizará ninguna copia'
		else
			echo 'ERROR: No ha confirmado correctamente. Tenga en cuenta que debe introducir la letra y en minúscula para proceder'
			echo "-------------------------"
			_ayuda
		fi
	else
		echo 'ERROR: Ha insertado unos argumentos inválidos. Inténtelo de nuevo'
		echo "-------------------------"
		_ayuda
	fi
fi
