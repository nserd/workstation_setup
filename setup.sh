#!/bin/bash
set -e

PLAYBOOK=$1

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
rm get-pip.py
pip install ansible
sudo dnf install -y git

git clone https://github.com/nserd/workstation_setup.git $HOME/.ws_setup
cd $HOME/.ws_setup
ansible-galaxy install -r requirements.yml
ansible-playbook $PLAYBOOK -D