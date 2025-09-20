#!/bin/bash
set -e

PLAYBOOK=$1
LOCAL_REPO_PATH="$HOME/.ws_setup"

if [ ! -d $LOCAL_REPO_PATH ] || [ "$WS_FORCE_SETUP" == "1" ]; then
    rm -rf $LOCAL_REPO_PATH
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python get-pip.py
    rm get-pip.py
    pip install ansible
    sudo dnf install -y git python3-libdnf5

    git clone https://github.com/nserd/workstation_setup.git $LOCAL_REPO_PATH
fi

cd $LOCAL_REPO_PATH
ansible-galaxy install -r requirements.yml

shift
ansible-playbook $PLAYBOOK -D $@