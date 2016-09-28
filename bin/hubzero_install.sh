#!/bin/bash
set -o errexit

service mysql start

#if [ ! -d "/home/hubzero/$HUBSITE" ]; then
echo "Installing hub $HUBSITE"
hzcms install $HUBSITE --uri $HUBURI
hzcms update
a2dissite default default-ssl
a2ensite $HUBSITE $HUBSITE-ssl
service apache2 stop
#fi

exit 0
