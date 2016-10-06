#!/bin/bash
CHECK_LOOP=15
LINK='http://www.madrid.org/cs/Satellite?pagename=ComunidadMadrid/Comunes/Presentacion/popupGestionTelematica&language=es&c=CM_ConvocaPrestac_FA&cid=1354178312070&nombreVb=listas&other=1'
GLOBAL_LINK="http://www.madrid.org"
TMP_LAST_INTERIM_CALLED=/tmp/ultimos_interinos_citados.pdf
TMP_NEXT_INTERIM_CALLED=/tmp/siguientes_interinos_citados.pdf
TMP_LAST_VOLUNTEER_CALLED=/tmp/ultimos_voluntarios_citados.pdf
TMP_NEXT_VOLUNTEER_CALLED=/tmp/siguientes_voluntarios_citados.pdf
TMP_INC_CALLED=/tmp/incorporados_lista.pdf

# Function to retrieve the file to download. Parameters:
# 1 - Type of list (i.e.:interinos, voluntarios)
# 2 - File to write
function get_file()
{
  PARTIAL_LINK=$(wget ${LINK} -O - -o/dev/null | grep "${1}" -A2 | awk -F 'a href=' {'print $2'}  | awk {'print $1'} | grep '[a-z]' | tr -d "'")
  TOTAL_LINK="${GLOBAL_LINK}/${PARTIAL_LINK}"
  echo "wget ${TOTAL_LINK} -O \"${2}\""
  wget ${TOTAL_LINK} -O "${2}"
}

function get_list_date()
{
  wget ${LINK} -o/dev/null -O - | grep "interinos\|voluntarios" | grep -E '\([0-9]{0,2}/[0-9]{0,2}/[0-9]{1,4}\)' -o | sort | uniq
}

# Returns:
# 0: Valid Date 
# 1: Invalid Date 
function is_valid_date()
{
  echo $1 | egrep -E "[0-9]{2}/[0-9]{2}/[0-9]{4}" > /dev/null
  echo $?
}

function retrieve_files()
{
  echo "Retrieving files ..."
  get_file "Últimos interinos citados" ${TMP_LAST_INTERIM_CALLED}  
  get_file "Próximos interinos" ${TMP_NEXT_INTERIM_CALLED}  
  get_file "últimos interinos citados para puestos de carácter voluntario" ${TMP_LAST_VOLUNTEER_CALLED}  
  get_file "Interinos citados para puestos de carácter voluntario" ${TMP_NEXT_VOLUNTEER_CALLED}
  get_file "Incorporados a la lista en su orden" "${TMP_INC_CALLED}"
}

LAST_DATE=$(get_list_date)

while true;
do
  NOW_DATE=$(get_list_date)
  NOW_INVALID_DATE=$(is_valid_date ${NOW_DATE})
  LAST_INVALID_DATE=$(is_valid_date ${LAST_DATE})

  echo "NOW_DATE=${NOW_DATE}"
  echo "LAST_DATE=${LAST_DATE}"
  echo "NOW_INVALID_DATE=${NOW_INVALID_DATE}"
  echo "LAST_INVALID_DATE=${LAST_INVALID_DATE}"
  echo 

  if [ "${NOW_DATE}" != "${LAST_DATE}" ] && [ ${NOW_INVALID_DATE} -eq 0 ] && [ ${LAST_INVALID_DATE} -eq 0 ];
  then
    retrieve_files
    /usr/local/src/sendEmail/sendEmail -f from@mail.com -t to@mail.com -u "Actualizacion de listas de interinos" -u "Actualizacion de listas de interinos" -m "Se ha detectado una actualizacion en la lista de interinos. Fecha antigua:${LAST_DATE}, Fecha nueva:${NOW_DATE}.\nConsulte el enlace:\n${LINK}" -v -xu user -xp password -a "${TMP_LAST_INTERIM_CALLED}" -a "${TMP_NEXT_INTERIM_CALLED}" -a "${TMP_LAST_VOLUNTEER_CALLED}" -a "${TMP_NEXT_VOLUNTEER_CALLED}" -a "${TMP_INC_CALLED}"

    LAST_DATE=${NOW_DATE}
  fi
  sleep ${CHECK_LOOP}
done

