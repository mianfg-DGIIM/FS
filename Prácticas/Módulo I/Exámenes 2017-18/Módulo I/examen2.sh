# EXAMEN 1 BASH - FUNDAMENTOS DEL SOFTWARE 1º DGIIM GRUPO 1
# Alumno: Miguel Ángel Fernández Gutiérrez, 20070335Y

#!/bin/bash

find / -user root -and -atime +7 -and -perm /o=r -and ! -name "*p*"
