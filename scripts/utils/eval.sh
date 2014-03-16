#!/bin/bash

FILE_VAR1=/tmp/1
FILE_VAR2=/tmp/2

array_vars=(VAR1 VAR2)

for ((ix=0; ix<${#array_vars[*]}; ix++)) 
do
  eval MI_VARIABLE="\$FILE_${array_vars[$ix]}"
  echo "Elemento [$ix]: ${array_vars[$ix]}, Fichero: ${MI_VARIABLE}"
done

