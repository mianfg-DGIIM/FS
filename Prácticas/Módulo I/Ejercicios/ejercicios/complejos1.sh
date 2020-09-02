#!/bin/bash

ERROR=false
if [[ -e $1 ]]; then
  echo "El archivo ya existe. Compresión abortada"
  ERROR=true
else
  for val in $@; do
    if [[ $val != $1 ]]; then
      if [[ ! -e $val ]]; then
        echo "No existe $val, operación abortada"
        ERROR=true
      else
        LIST=`echo $LIST $val`
      fi
    fi
  done
fi

if [[ $ERROR == false ]]; then
  tar -czf $1 $LIST
  echo "Compresión realizada"
fi
