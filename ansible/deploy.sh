#!/usr/bin/env bash

# TODO include storage after fixing ssh access there
ansible-playbook lab.yml -i hosts -u lab --limit '!storage' -K
# --ask-pass to set up SSH keys
