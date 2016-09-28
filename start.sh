#!/bin/bash
set -o errexit

/usr/local/bin/hubzero_install.sh

/usr/bin/supervisord -n
