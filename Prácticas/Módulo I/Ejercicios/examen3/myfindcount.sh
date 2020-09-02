#!/bin/bash

if [[ $# == 2 ]]; then
  if [[ `test -d $1; echo $?` ]]; then
    NUMARCHIVOS=`find $1 -name $2 | wc -l`
    echo "Tiene $NUMARCHIVOS archivos que coinciden con el criterio"
  else
    echo "No ha introducido un directorio válido"
  fi
elif [[ $# == 1 ]]; then
  NUMARCHIVOS=`find . -name $1 | wc -l`
  echo "Tiene $NUMARCHIVOS archivos que coinciden con el criterio"
else
  echo "Número incorrecto de argumentos"
fi
