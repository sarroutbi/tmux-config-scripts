#!/bin/bash
echo "Testing array: $*"

INPUT_ARRAY=$*
data_array=($(echo $INPUT_ARRAY))
echo "Array length:${#data_array[*]}"
for ((ix=0; ix<${#data_array[*]}; ix++)) 
do
  echo "Elemento [$ix]: ${data_array[$ix]}"
done
