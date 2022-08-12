#!/bin/sh

if [ "$1" = "dropbear" ] ; then
    CONF_DIR="/etc/dropbear"
    SSH_KEY_DSS="${CONF_DIR}/dropbear_dss_host_key"
    SSH_KEY_RSA="${CONF_DIR}/dropbear_rsa_host_key"

    # Check if conf dir exists
    if [ ! -d ${CONF_DIR} ]; then
        sudo mkdir -p ${CONF_DIR}
    fi
    sudo chown root:root ${CONF_DIR}
    sudo chmod 755 ${CONF_DIR}

    # Check if keys exists
    if [ ! -f ${SSH_KEY_DSS} ]; then
        sudo dropbearkey  -t dss -f ${SSH_KEY_DSS}
    fi
    sudo chown root:root ${SSH_KEY_DSS}
    sudo chmod 600 ${SSH_KEY_DSS}

    if [ ! -f ${SSH_KEY_RSA} ]; then
        sudo dropbearkey  -t rsa -f ${SSH_KEY_RSA} -s 2048
    fi
    sudo chown root:root ${SSH_KEY_RSA}
    sudo chmod 600 ${SSH_KEY_RSA}

    exec sudo /usr/sbin/dropbear -j -k -s -E -F
fi

echo "run some: $@"
exec "$@"
