#!/bin/sh

podman run --rm -it --volume './:/proj:Z' mcr.microsoft.com/vscode/devcontainers/base:debian-10 bash -c ' \
    type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y) \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && (echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null) \
    && apt-get update \
    && apt-get install -y gh \
    && bash /proj/.devcontainer/scripts/node.sh \
    && cd /proj \
    && (cd common && npm install && npm run build) \
    && (cd github-action/ && npm install && npm run build && npm run package)'

exit 0

podman run --rm -it --volume './:/proj:Z' mcr.microsoft.com/vscode/devcontainers/base:debian-10 bash -c ' \
    type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y) \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && (echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null) \
    && apt-get update \
    && apt-get install -y gh \
    && bash /proj/.devcontainer/scripts/node.sh \
    && cd /proj \
    && (cd common && npm install && npm run build) \
    && (cd github-action/ && npm install && npm run build && npm run package) \
    && git config user.name "Steven van der Schoot" \
    && git config user.email "steven.van.der.schoot@wefabricate.com" \
    && echo " ##################################################################### " \
    && echo " ##################################################################### " \
    && echo " ##################################################################### " \
    && TAG_NAME=v3.1 RELEASE_NAME=v3.1 ./scripts/gh-release.sh'
