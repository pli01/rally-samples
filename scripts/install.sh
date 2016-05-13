#!/bin/bash

# as root
# install debian pre req
apt-get -qqy install libssl-dev libffi-dev python-dev libxml2-dev libxslt1-dev libpq-dev
apt-get -qqy install python-pbr python3-pbr
apt-get -qqy install apache2

# install pip and pbr
[ -z "$https_proxy" ] || pip_args=" --proxy=$https_proxy "
pip3 install --upgrade $pip_args -i https://pypi.python.org/simple pip
pip install --upgrade $pip_args  -i https://pypi.python.org/simple pbr

curl https://raw.githubusercontent.com/openstack/rally/master/install_rally.sh > install_rally.sh

# patch to use http_proxy
[ -z "$https_proxy" ] || perl -pi -e 's/pip install/pip install --proxy=\$https_proxy/' install_rally.sh

# launch install
/root/install_rally.sh -p /usr/bin/python3

