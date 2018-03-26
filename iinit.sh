#!/usr/bin/env bash

_set_irods_env() {
  local OUTFILE=$HOME/.irods/irods_environment.json
  if [ -f $HOME/.irods/irods_environment.json ]; then
    IRODS_HOST=$(jq '.irods_host' $OUTFILE | tr -d '\"')
    IRODS_PORT=$(jq '.irods_port' $OUTFILE | tr -d '\"')
    IRODS_USER_NAME=$(jq '.irods_user_name' $OUTFILE | tr -d '\"')
    IRODS_ZONE_NAME=$(jq '.irods_zone_name' $OUTFILE | tr -d '\"')
    IRODS_DEFAULT_RESOURCE=$(jq '.irods_default_resource' $OUTFILE | tr -d '\"')
    IRODS_HOME=$(jq '.irods_home' $OUTFILE | tr -d '\"')
  else
    IRODS_HOST=localhost
    IRODS_PORT=1247
    IRODS_USER_NAME=rods
    IRODS_ZONE_NAME=tempZone
    IRODS_PASSWORD=rods
    IRODS_DEFAULT_RESOURCE=null
    IRODS_HOME=null
  fi
}

_irods_environment_json() {
  if [ ! -d $HOME/.irods ]; then
    mkdir -p $HOME/.irods
  fi
  local OUTFILE=$HOME/.irods/irods_environment.json
  local TEMPFILE=$OUTFILE.tmp
  jq -n \
    --arg h "${IRODS_HOST}" \
    --arg p "${IRODS_PORT}" \
    --arg z "${IRODS_ZONE_NAME}" \
    --arg u "${IRODS_USER_NAME}" \
    '{"irods_host": $h, "irods_port": $p | tonumber, "irods_zone_name": $z,
    "irods_user_name": $u}' > $OUTFILE
  if [[ "${IRODS_DEFAULT_RESOURCE}" != "null" ]]; then
    # echo "setting IRODS_DEFAULT_RESOURCE"
    jq --arg d ${IRODS_DEFAULT_RESOURCE} '. + {irods_default_resource: $d}' $OUTFILE > $TEMPFILE
    mv $TEMPFILE $OUTFILE
  fi
  if [[ "${IRODS_HOME}" != "null" ]]; then
    # echo "setting IRODS_HOME"
    jq --arg m ${IRODS_HOME} '. + {irods_home: $m}' $OUTFILE > $TEMPFILE
    mv $TEMPFILE $OUTFILE
  fi
}

### main ###
if [ "$#" == 0 ]; then
  IINIT_CMD_LINE=true
else
  IINIT_CMD_LINE=false
fi

OPTS=`getopt -o h:p:u:z:s:r:m: --long irods_host:,irods_port:,irods_user_name:,irods_zone_name:,irods_password:,irods_default_resource:,irods_home: -n 'parse-options' -- "$@"`

if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

# echo "$OPTS"
eval set -- "$OPTS"

IRODS_HOST=null
IRODS_PORT=1247
IRODS_USER_NAME=null
IRODS_ZONE_NAME=null
IRODS_PASSWORD=null
IRODS_DEFAULT_RESOURCE=null
IRODS_HOME=null

_set_irods_env

while true; do
  case "$1" in
    -h | --irods_host ) IRODS_HOST="$2"; shift; shift ;;
    -p | --irods_port ) IRODS_PORT="$2"; shift; shift ;;
    -u | --irods_user_name ) IRODS_USER_NAME="$2"; shift; shift ;;
    -z | --irods_zone_name ) IRODS_ZONE_NAME="$2"; shift; shift ;;
    -s | --irods_password ) IRODS_PASSWORD="$2"; shift; shift ;;
    -r | --irods_default_resource ) IRODS_DEFAULT_RESOURCE="$2"; shift; shift;;
    -m | --irods_home ) IRODS_HOME="$2"; shift; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if $IINIT_CMD_LINE; then
  rm -rf $HOME/.irods
  iinit
  echo "IINIT: ${HOME}/.irods/irods_environment.json"
  cat $HOME/.irods/irods_environment.json
else
  _irods_environment_json
  if [[ "${IRODS_PASSWORD}" != "null" ]]; then
    echo $IRODS_PASSWORD | iinit
  else
    iinit
  fi
  echo "IINIT: ${HOME}/.irods/irods_environment.json"
  cat $HOME/.irods/irods_environment.json
fi

### uncomment for debugging ###
# echo IRODS_HOST=$IRODS_HOST
# echo IRODS_PORT=$IRODS_PORT
# echo IRODS_USER_NAME=$IRODS_USER_NAME
# echo IRODS_ZONE_NAME=$IRODS_ZONE_NAME
# echo IRODS_PASSWORD=$IRODS_PASSWORD
# echo IRODS_DEFAULT_RESOURCE=$IRODS_DEFAULT_RESOURCE
# echo IRODS_HOME=$IRODS_HOME

exit 0;
