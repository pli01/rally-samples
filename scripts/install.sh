#!/bin/bash -ex

# variable env
#  http_proxy=""
#  PYTHON=/usr/bin/python2
#  RALLY_DEST
[ -z "$PYTHON"] && PYTHON=/usr/bin/python2
[ -z "$RALLY_DEST" ] && RALLY_DEST=$HOME/rally
export RALLY_DEST PYTHON http_proxy

if [ -x $RALLY_DEST/bin/rally ] ; then
  if [ $($RALLY_DEST/bin/rally --version) ]; then
    exit 0
  fi
    exit $?
fi
# as root
# install debian pre req
pkg_list="libssl-dev libffi-dev python-dev libxml2-dev libxslt1-dev libpq-dev python-virtualenv build-essential apache2"

if ! dpkg -p $pkg_list ; then
  sudo apt-get -qqy install $pkg_list
fi

# as user
# install pip and pbr
[ -z "$http_proxy" ] || pip_args=" --proxy=$http_proxy "

# create python virtualenv
virtualenv -p $PYTHON $RALLY_DEST
$RALLY_DEST/bin/pip install --upgrade  $pip_args  pip  setuptools

curl https://raw.githubusercontent.com/openstack/rally/master/install_rally.sh > install_rally.sh

test -f install_rally.sh || exit 1

# patch to use http_proxy
[ -z "$http_proxy" ] || perl -pi -e 's/pip install/pip install --proxy=\$http_proxy/' install_rally.sh

# launch install
bash -x install_rally.sh --no-color -d $RALLY_DEST -R

