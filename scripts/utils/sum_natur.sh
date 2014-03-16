#!/bin/bash
#
test -z ${1} && echo "Especifica el numero hasta el que sumar" && exit 1
echo ${1} | egrep -E "[0-9]{1,}" 2>&1 > /dev/null || (echo "Especifica un numero entero" && exit 2)

let big_number=$1
let num=1
let sum=0

while [ $num -le $big_number ];
do
  let sum=${num}+${sum}
  let num=${num}+1 
done

echo "La suma es : ${sum}"

