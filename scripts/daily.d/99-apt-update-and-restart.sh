#!/bin/bash

set -o errtrace
trap 'on_error $LINENO' ERR;
PROGNAME=$(basename $0)
PROGPATH="$( cd "$(dirname "$0")" ; pwd -P )"   # The absolute path to kickstart.sh



function on_error () {
    local exit_code=$?
    local prog=$BASH_COMMAND
    echo -en "'$prog' (Exit code: $exit_code on ${PROGNAME} line $1)\n" 1>&2

    cp /tmp/resolv.conf.host /host/etc/resolv.conf

    exit 1
}







cp /host/etc/resolv.conf /tmp/resolv.conf.host

cp /etc/resolv.conf /host/etc/resolv.conf

chroot /host apt-get update
chroot /host apt-get upgrade -y


cp /tmp/resolv.conf.host /host/etc/resolv.conf
