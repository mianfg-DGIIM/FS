#!/bin/bash

MOSTRAR_AYUDA=false
DIRECTORIO_BASURA=/tmp/trash

if [[ $1 == "--grupo" ]]; then
  ee
elif [[ $1 == "--ruta" ]]; then
  if [[ $# == 2 ]]; then
    DIRECTORIO_BASURA=$2
  else
    MOSTRAR_AYUDA=true
  fi
elif [[ $1 == "--ayuda" ]]; then
  MOSTRAR_AYUDA=true
else
  ABS_PATH=`cd $DIRECTORIO_BASURA; pwd`
  echo ABS $ABS_PATH
  NUM_FICHEROS=`ls -l $ABS_PATH | wc -l`
  NUM_FICHEROS=`expr $NUM_FICHEROS - 1`
  echo NUMF $NUM_FICHEROS
  NUM_FICHEROS_RECIENTES=`cd $ABS_PATH; find -mtime 5 -not -path '*/\.*' | wc -l`
  echo NUMFR $NUM_FICHEROS_RECIENTES
  if [[ $NUM_FICHEROS_RECIENTES == 0 ]]; then
    echo "[ ] Se han leído $NUM_FICHEROS ficheros, $NUM_FICHEROS_RECIENTES más recientes de 5 días. No se hace nada (`date +%D`)"
  else
    echo "[ ] Se han leído $NUM_FICHEROS ficheros, $NUM_FICHEROS_RECIENTES más recientes de 5 días. No se hace nada (`date +%D`)"# >> ~/tmp.log
  fi
fi

if [[ $MOSTRAR_AYUDA == true ]]; then
  echo ayuda
fi
