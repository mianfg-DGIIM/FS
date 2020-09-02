#!/bin/bash

echo "Resolveremos la ecuación ax²+bx+c=0"
read -p "Inserte a, b y c separados por espacios: " a b c

SOL_1=`echo "(-$b+sqrt($b*$b-4*$a*$c))/(2*$a)" | bc`
SOL_2=`echo "(-$b-sqrt($b*$b-4*$a*$c))/(2*$a)" | bc`

echo Las soluciones son: x=$SOL_1 y x=$SOL_2
