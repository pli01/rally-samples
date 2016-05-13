#!/bin/bash
CLOUD=${1:-my_cloud}
TASK=${2:-/root/rally.git/samples/tasks/scenarios/nova/boot-and-delete.json}
TIME=$(date  +%Y%m%d-%H%M%S)

test -f /var/www/html/index.html && rm -rf /var/www/html/index.html

# use cloud
rally deployment use ${CLOUD}
# task
rally task start ${TASK}

UUID=$(rally task status | awk ' /Task/ { print $2 } ' |sed -e 's/://')
# output reports
( cd /var/www/html/ && rally task report $UUID --html-static --out output-${CLOUD}-${UUID}-${TIME}.html )

