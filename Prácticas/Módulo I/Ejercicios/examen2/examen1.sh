#!/bin/bash

DIR_BASURA=/home/$USER/.local/share/Trash
echo $DIR_BASURA
function basura {
  #if ! [[ -d $DIR_BASURA ]]; then
  #  echo "Directorio basura no existe, necesario crearlo"
  #  mkdir $DIR_BASURA
  #fi
  #cd $DIR_BASURA
  NUM_FICHEROS=`ls -l $DIR_BASURA | grep -v ^[lt] | wc -l`
  NUM_FICHEROS_RECIENTES=`find $DIR_BASURA -atime -5 | wc -l`
  # find cuenta el propio directorio como fichero:
  NUM_FICHEROS_RECIENTES=`expr $NUM_FICHEROS_RECIENTES - 1`
  FECHA=`date +%y`_`date +%m`_`date +%d`
  if [[ $NUM_FICHEROS_RECIENTES == 0 ]]; then
    # no hemos encontrado ficheros modificados más recientemente de 5 días
    echo "[ ] Se han leído $NUM_FICHEROS ficheros, $NUM_FICHEROS_RECIENTES más recientes de 5 días. No se hace nada ($FECHA)" >> ~/tmp.log
  else
    MOVIDOS=0
    if ! [[ -d $DIR_BASURA/.tmp-$FECHA ]]; then
      echo "Creando carpeta a la que mover la basura: $DIR_BASURA/.tmp-$FECHA"
      if ! [[ -d $DIR_BASURA/.tmp-$FECHA ]]; then
        mkdir $DIR_BASURA/.tmp-$FECHA
      fi
    fi
    chmod g-rwx,u+rwx,o-rwx $DIR_BASURA/.tmp-$FECHA
    for archivo in `ls $DIR_BASURA`; do
      cd $DIR_BASURA; mv $archivo $DIR_BASURA/.tmp-$FECHA
      MOVIDOS=`expr $MOVIDOS + 1`
    done
    # otra forma: mv $DIR_BASURA/* $DIR_BASURA/.tmp-$FECHA
    echo "[x] No hay ficheros recientes. Se han movido $MOVIDOS ficheros a la carpeta $DIR_BASURA ($FECHA)" >> ~/tmp.log
  fi
  #`find $DIR_BASURA -atime -5; echo $?` # queremos que valor sea 1
}

if [[ $# == 2 ]]; then
  if [[ $1 == --ruta ]]; then
    DIR_BASURA=$2
    basura
  else
    echo "Error: el primer argumento no es válido"
  fi
elif [[ $# == 1 ]]; then
  if [[ $1 == --ayuda ]]; then
    echo ayuda
  elif [[ $1 == --grupo ]]; then
    echo grupo
    groups $USER
  else
    echo "Error: el primer argumento no es válido"
  fi
elif [[ $# == 0 ]]; then
  basura
fi
