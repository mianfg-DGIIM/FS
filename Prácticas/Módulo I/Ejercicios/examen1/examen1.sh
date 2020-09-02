#!/bin/bash

if [[ $1 == "--alumno" ]]; then
  echo "Alumno: Miguel Ángel Fernández Gutiérrez"
  echo "DNI:    20070335Y"
  echo "Grupo 1 Fundamentos del Software, 1º DGIIM 2017/2018"
elif [[ $1 == "--ayuda" ]]; then
  echo "Ayuda del programa"
elif [[ $1 == "--copy" ]]; then
  if [[ $# == 2 ]]; then
    if [[ `test -d $2; echo $?` == 0 && `test -h $2; echo $?` == 1 ]]; then
      NUM_FICHEROS=`ls $2 | wc -l`
      read -p "En el directorio hay $NUM_FICHEROS ficheros, ¿desea hacer la copia de seguridad? " DESEA_COPIAR
      if [[ $DESEA_COPIAR == si || $DESEA_COPIAR == sí || $DESEA_COPIAR == yes || $DESEA_COPIAR == s || $DESEA_COPIAR == y ]]; then
        echo "Haremos la copia de seguridad"
        YEAR=`date +%Y`
        YEARTWODIGITS=${YEAR: -2}
        FOLDER=/tmp/backup_`echo $YEARTWODIGITS`_`date +%m`_`date +%d`
        mkdir $FOLDER
        if [[ $? == 1 ]]; then
          echo "Debido a este error, abortaremos la realización de la copia"
        else
          cp -r $2 $FOLDER
          if [[ $? == 0 ]]; then
            echo "Copia de seguridad hecha satisfactoriamente en /tmp/"$FOLDER
          fi
        fi
      else
        echo "Hemos entendido que no desea hacer la copia de seguridad"
      fi
    else
      echo "Error: el directorio insertado o bien no existe o bien es un enlace"
    fi
  else
    echo "Número de argumentos incorrecto"
  fi
else
  echo "Orden no encontrada"
fi
