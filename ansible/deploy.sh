#!/usr/bin/env bash

# TODO include storage after fixing ssh access there
ansible-playbook lab.yml -i hosts -u lab --ask-pass --limit !storage
