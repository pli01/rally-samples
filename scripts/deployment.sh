#!/bin/bash

FILE=${1:-deployment/rally-admin-cloud.rc}
NAME=${2:-my_cloud}

rally deployment create --file=$FILE --name=${NAME}

