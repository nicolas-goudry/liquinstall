#!/usr/bin/env bash

YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NC='\033[0m'

function ec () {
  echo -e "${YELLOW}==> $*${NC}"
}

function topic () {
  printf "\n${GREEN}=== $* ===${NC}\n\n"
}

topic DISTRO

ec "Update dependencies"
sudo apt update && sudo apt upgrade -y

ec "Install packages"
sudo apt install terminator zsh git software-properties-common build-essential openjdk-16-jdk apt-transport-https ca-certificates curl gnupg lsb-release

topic TOOLS

ec "Install oh-my-zsh and pure-prompt"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir -p "$HOME/.zsh"
git clone git://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

ec "Install Docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io

ec "Install Google Cloud SDK and kubectl"
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk kubectl

ec "Install AWS CLI"
curl -fSL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip --output /tmp/awscliv2.zip
unzip -d /tmp /tmp/awscliv2.zip
sudo /tmp/aws/install

ec "Install Node.js LTS through nvm as well as some global npm packages"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
nvm install --lts
npm i -g npm-check-updates standard yarn

ec "Install exa"
curl -fSL https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip --output /tmp/exa.zip
unzip -d /tmp /tmp/exa.zip
sudo mv /tmp/exa-linux-x86_64 /usr/local/bin/exa

topic APPS

ec "Install Google Chrome"
curl -fSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --output /tmp/chrome.deb
sudo dpkg -i /tmp/chrome.deb

ec "Install VSCode"
curl -fSL https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 --output /tmp/code.deb
sudo dpkg -i /tmp/code.deb

ec "Install GitKraken"
curl -fSL https://release.gitkraken.com/linux/gitkraken-amd64.deb --output /tmp/gitkraken.deb
sudo dpkg -i /tmp/gitkraken.deb

ec "Install sqlectron"
curl -fSL https://github.com/sqlectron/sqlectron-gui/releases/download/v1.37.1/sqlectron_1.37.1_amd64.deb --output /tmp/sqlectron.deb
sudo dpkg -i /tmp/sqlectron.deb

ec "Install Lens IDE"
curl -fSL https://api.k8slens.dev/binaries/Lens-5.1.3-latest.20210722.1.amd64.deb --output /tmp/lens.deb
sudo dpkg -i /tmp/lens.deb

topic CONFIG

ec "Configure zsh custom profile"
curl -fSL https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/config/.zprofile --output ~/.zprofile
echo 'source .zprofile' >> ~/.zshrc

ec "Configure Docker to run without sudo"
sudo groupadd docker
sudo usermod -aG docker $USER

ec "Configure git"
curl -fSL https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/config/.gitconfig --output ~/.gitconfig

ec "Configure terminator"
mkdir -p ~/.config/terminator
curl -fSL https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/config/terminator-config --output ~/.config/terminator/config

ec "Configure VSCode"
mkdir -p ~/.config/Code/User
curl -fSL https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/config/vscode-config --output ~/.config/Code/User/settings.json

ec "Install VSCode extensions"
code --install-extension ms-azuretools.vscode-docker
code --install-extension mikestead.dotenv
code --install-extension yzhang.markdown-all-in-one
code --install-extension chenxsan.vscode-standardjs
code --install-extension vscode-icons-team.vscode-icons

ec "Enable GitKraken Pro"
git clone https://github.com/5cr1pt/GitCracken.git /tmp/gitcracken
cd /tmp/gitcracken/GitCracken && yarn install && yarn build && cd -
sudo node /tmp/gitcracken/GitCracken/dist/bin/gitcracken.js patcher
echo "0.0.0.0 release.gitkraken.com" | sudo tee -a /etc/hosts

ec "Display clock seconds"
gsettings set org.gnome.desktop.interface clock-show-seconds true

topic SSH

ec "Create RSA keypair"
ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N "" -C "nicolas@kubolabs.io"

ec "You must set RSA public key on online services that requires it"
cat "$HOME/.ssh/id_rsa.pub"
