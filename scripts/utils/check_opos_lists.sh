#!/bin/bash
CHECK_LOOP=15
LINK='http://www.madrid.org/cs/Satellite?pagename=ComunidadMadrid/Comunes/Presentacion/popupGestionTelematica&language=es&c=CM_ConvocaPrestac_FA&cid=1354178312070&nombreVb=listas&other=1'

function get_list_date()
{
  wget ${LINK} -o/dev/null -O - | grep -E '\([0-9]{0,2}/[0-9]{0,2}/[0-9]{1,4}\)' -o | uniq
}

# Returns:
# 0: Valid Date 
# 1: Invalid Date 
function is_valid_date()
{
  echo $1 | egrep -E "[0-9]{2}/[0-9]{2}/[0-9]{4}" > /dev/null
  echo $?
}

LAST_DATE=$(get_list_date)

while true;
do
  NOW_DATE=$(get_list_date)
  NOW_INVALID_DATE=$(is_valid_date ${NOW_DATE})
  LAST_INVALID_DATE=$(is_valid_date ${LAST_DATE})

  # QUIT
  echo "NOW_DATE=${NOW_DATE}"
  echo "LAST_DATE=${LAST_DATE}"
  echo "NOW_INVALID_DATE=${NOW_INVALID_DATE}"
  echo "LAST_INVALID_DATE=${LAST_INVALID_DATE}"
  echo 
  # QUIT END

  if [ "${NOW_DATE}" != "${LAST_DATE}" ] && [ ${NOW_INVALID_DATE} -eq 0 ] && [ ${LAST_INVALID_DATE} -eq 0 ];
  then
    /usr/local/src/sendEmail/sendEmail -f from@mail.com -t to@mail.com -u "Actualizacion de listas de interinos" -m "Se ha detectado una actualizacion en la lista de interinos. Fecha antigua:${LAST_DATE}, Fecha nueva:${NOW_DATE}.\nConsulte el enlace\n:${LINK}" -v -xu mail_user -xp mail_password
    LAST_DATE=${NOW_DATE}
  fi
  sleep ${CHECK_LOOP}
done

