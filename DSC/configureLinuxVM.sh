#!/bin/bash

#########################################################
# Script Name: configureLinuxVM.sh
# Author: Quest
# Version: 0.1
# Description:
#  This script configures InTrust Agent
#
# Note :
# This script has only been tested on RedHat 7
#########################################################
#---BEGIN VARIABLES---
AZ_ACCOUNT_NAME=''
AZ_ACCOUNT_PWD=''


 function usage()
 {
    echo "INFO:"
    echo "Usage: configureLinuxVM.sh -a -p"
}

function log()
{
    # If you want to enable this logging add a un-comment the line below and add your account id
    #curl -X POST -H "content-type:text/plain" --data-binary "${HOSTNAME} - $1" https://logs-01.loggly.com/inputs/<key>/tag/es-extension,${HOSTNAME}
    echo "$1"
}

#---PARSE AND VALIDATE PARAMETERS---
if [ $# -ne 4 ]; then
    log "ERROR:Wrong number of arguments specified. Parameters received $#. Terminating the script."
    usage
    exit 1
fi

while getopts :a:p: optname; do
    log "INFO:Option $optname set with value ${OPTARG}"
  case $optname in
    a) # Azure Private Storage Account Name- SSH Keys
      AZ_ACCOUNT_NAME=${OPTARG}
      ;;
    p) # Azure Private Storage Account Key - SSH Keys
      AZ_ACCOUNT_PWD=${OPTARG}
      ;;

    \?) #Invalid option - show help
      log "ERROR:Option -${BOLD}$OPTARG${NORM} not allowed."
      usage
      exit 1
      ;;
  esac
done

#---PARSE AND VALIDATE PARAMETERS---


function ConfigureInTrustAgent()
{
    yum install libuuid.i686 -y --setopt=protected_multilib=false 
    yum install glibc.i686 -y --setopt=protected_multilib=false
    yum install samba-client -y
    smbget smb://${AZ_ACCOUNT_NAME}:${AZ_ACCOUNT_PWD}@10.0.0.5/Agent/linux_intel/adcscm_package.linux_intel.sh
    ./adcscm_package.linux_intel.sh
}

ConfigureInTrustAgent
