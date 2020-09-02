#!/bin/bash

# nota importante: para poder mantener el alias, es necesario ejecutar el
# script usando source, de forma que el alias se mantenga en la consola y no
# sólo durante la ejecución del script

DIR_BASURA=~/Escritorio

function palabras {
  echo "Mostrando las palabras que comienzan por mayúscula:"
  grep "^[A-Z].*" $1
  echo "Son en total: `grep "^[A-Z].*" $1 | wc -l` palabras"
  echo "Además, el fichero tiene en total: `cat $1 | wc -l` palabras"
}

if [[ $1 == "--eliminar" ]]; then
  unalias rm
else
  echo "Ahora puede usar rm de otra forma. Ejecute --uninstall para eliminar la funcionalidad"
  alias rm='mv $@ $DIR_BASURA; palabras'
fi
