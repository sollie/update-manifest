#!/bin/bash
set -e

mkdir -p /home/runner/.ssh
echo ssh-keyscan $INPUT_ghes_host >> /home/runner/.ssh/known_hosts
echo "$INPUT_ssh_private_key" > /home/runner/.ssh/github_actions
chmod 600 /home/runner/.ssh/github_actions
ssh-agent -a $INPUT_ssh_auth_sock > /dev/null
ssh-add /home/runner/.ssh/github_actions
echo SSH_AUTH_SOCK=$INPUT_ssh_auth_sock >> $GITUB_ENV
