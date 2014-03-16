#!/bin/bash
cadena=TRWAGMYFPDXBNJZSQVHLCKE
posicion=$(echo "$1 % 23" | bc)
letra=${cadena:$posicion:1}
echo 
echo "TU DNI es:=>$1-$letra<="
echo 
