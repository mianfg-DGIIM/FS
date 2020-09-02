# EXAMEN 2 BASH - FUNDAMENTOS DEL SOFTWARE 1º DGIIM GRUPO 1
# Alumno: Miguel Ángel Fernández Gutiérrez, 20070335Y
# Ejercicio 1

#!/bin/bash

function _ayuda {
	echo 'El script tiene el siguiente funcionamiento:'
	echo './examen1.sh --p fichero_destino'
	echo '    Concatena los contenidos de los ficheros planos del directorio de trabajo en el fichero_destino en el orden en que aparecen'
	echo './examen1.sh --p directorio_destino (debe existir previamente)'
	echo '    Copia los ficheros planos del directorio en directorio_destino'
	echo './examen1.sh --h'
	echo '    Muestra esta ayuda en pantalla'
	echo './examen1.sh --u (sin argumentos)'
	echo '    Muestra el número y estado de los procesos del usuario'
}

if [[ $# == 0 ]]; then
	_ayuda
else
	if [[ $1 == "--p" ]]; then
		if [[ $# == 2 ]]; then
			if [[ `test -d $2; echo $?` == 0 ]]; then
				for archivo in $(ls)
				do
					if [[ $archivo != "examen1.sh" ]]; then
						if [[ `test -f $archivo; echo $?` == 0 ]]; then
							cp $archivo $2
						fi
					fi
				done
			elif [[ `test -f $2; echo $?` == 0 ]]; then
				echo "Es un archivo"
				for archivo in $(ls)
				do
					if [[ $archivo != $2 ]]; then
						if [[ `test -f $archivo; echo $?` == 0 ]]; then
							if [[ $archivo != "examen1.sh" ]]; then
								cat $archivo >> $2
							fi
						fi
					fi
				done
			else
				_ayuda
			fi
		else
			_ayuda
		fi
	elif [[ $1 == "--h" ]]; then
		_ayuda
	elif [[ $1 == "--u" ]]; then
		if [[ $# == 1 ]]; then
			ps -u $USER
		else
			_ayuda
		fi
	else
		_ayuda
	fi
fi
