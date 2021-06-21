#!/bin/bash
set -e

mkdir -p /home/runner/.ssh
ssh-keyscan $INPUT_GHES_HOST >> /home/runner/.ssh/known_hosts
echo "$INPUT_SSH_PRIVATE_KEY" > /home/runner/.ssh/github_actions
chmod 600 /home/runner/.ssh/github_actions
ssh-agent -a $INPUT_SSH_AUTH_SOCK > /dev/null
ssh-add /home/runner/.ssh/github_actions

git config --global --add url."git@$INPUT_GHES_HOST:".insteadOf "https://$INPUT_GHES_HOST/"
