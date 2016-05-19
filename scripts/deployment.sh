#!/bin/bash

FILE=${1:-deployment/rally-admin-cloud.rc}
NAME=${2:-my_cloud}

test -f $FILE || exit 1

# supprime config existante
rally deployment show $NAME && rally deployment destroy $NAME
rally deployment create --file=$FILE --name=$NAME

# verif acces keystone
rally deployment use $NAME && rally deployment check $NAME

# verif acces services images
rally show images
