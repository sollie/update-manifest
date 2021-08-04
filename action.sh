#!/bin/bash
set -e

export SSH_AUTH_SOCK=${INPUT_SSH_AUTH_SOCK}

mkdir -p /home/runner/.ssh
ssh-keyscan $INPUT_GHES_HOST >> /home/runner/.ssh/known_hosts
echo "$INPUT_SSH_PRIVATE_KEY" > /home/runner/.ssh/github_actions
chmod 600 /home/runner/.ssh/github_actions
ssh-agent -a $INPUT_SSH_AUTH_SOCK > /dev/null
ssh-add /home/runner/.ssh/github_actions

git config --global --add url."git@${INPUT_GHES_HOST}:".insteadOf "https://${INPUT_GHES_HOST}/"
git config --global user.name ${INPUT_MANIFEST_NAME}
git config --global user.email ${INPUT_MANIFEST_NAME}@${INPUT_GHES_HOST}
git clone git@${INPUT_GHES_HOST}:${INPUT_MANIFEST_ORG}/${INPUT_MANIFEST_REPO}.git ${INPUT_MANIFEST_REPO}

cd ${INPUT_MANIFEST_REPO}/${INPUT_MANIFEST_PATH}/${INPUT_MANIFEST_NAME}
OLD_IMAGE=$(cat kustomization.yaml | grep -A3 ${INPUT_MANIFEST_NAME} | grep newTag | awk '{print $2}')
NEW_IMAGE=${INPUT_IMAGE_TAG}
sed -i "s|${OLD_IMAGE}|${NEW_IMAGE}|g" kustomization.yaml
git commit -m "Bump image - ${INPUT_MANIFEST_NAME}:${INPUT_IMAGE_TAG}" kustomization.yaml
git push --force
