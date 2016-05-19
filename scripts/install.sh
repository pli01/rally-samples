#!/bin/bash -ex

# as root
# install debian pre req
sudo apt-get -qqy install libssl-dev libffi-dev python-dev libxml2-dev libxslt1-dev libpq-dev python-virtualenv build-essential
#sudo apt-get -qqy install python-pbr python3-pbr
sudo apt-get -qqy install apache2

# install pip and pbr
[ -z "$https_proxy" ] || pip_args=" --proxy=$https_proxy "
#sudo pip3 install --upgrade $pip_args -i https://pypi.python.org/simple pip
#sudo pip install --upgrade $pip_args  -i https://pypi.python.org/simple pbr
virtualenv  -p /usr/bin/python2 $HOME/rally
$HOME/rally/bin/pip install --upgrade  $pip_args  pip  setuptools

curl https://raw.githubusercontent.com/openstack/rally/master/install_rally.sh > install_rally.sh

test -f install_rally.sh || exit 1

# patch to use http_proxy
[ -z "$https_proxy" ] || perl -pi -e 's/pip install/pip install --proxy=\$https_proxy/' install_rally.sh

# launch install
bash -x install_rally.sh -d $HOME/rally -R
