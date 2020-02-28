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



 function usage()
 {
    echo "INFO:"
    echo "Usage: configureLinuxVM.sh"
}

function log()
{
    # If you want to enable this logging add a un-comment the line below and add your account id
    #curl -X POST -H "content-type:text/plain" --data-binary "${HOSTNAME} - $1" https://logs-01.loggly.com/inputs/<key>/tag/es-extension,${HOSTNAME}
    echo "$1"
}




function ConfigureInTrustAgent()
{
    yum install libuuid.i686 -y --setopt=protected_multilib=false 
    yum install glibc.i686 -y --setopt=protected_multilib=false
    yum install samba-client -y
    smbget smb://10.0.0.5/Agent/linux_intel/adcscm_package.linux_intel.sh
    ./adcscm_package.linux_intel.sh
}

ConfigureInTrustAgent
