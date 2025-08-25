#!/bin/bash
set -e

PLAYBOOK=$1
LOCAL_REPO_PATH="$HOME/.ws_setup"

if [ ! -d "$LOCAL_REPO_PATH" ]; then
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python get-pip.py
    rm get-pip.py
    pip install ansible
    sudo dnf install -y git python3-libdnf-5

    git clone https://github.com/nserd/workstation_setup.git $HOME/.ws_setup
    cd $HOME/.ws_setup
    ansible-galaxy install -r requirements.yml
fi

shift
ansible-playbook $PLAYBOOK -D $@