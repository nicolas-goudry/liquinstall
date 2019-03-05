#!/usr/bin/env bash

NODE_VERSION=11
YELLOW='\033[1;33m'
NC='\033[0m'

function ec () {
  echo -e "${YELLOW}$*${NC}"
}

ec "Uninstall Docker if installed"
sudo apt-get remove docker docker-engine docker.io containerd runc

ec "Updating distribution dependencies"
sudo apt-get update
sudo apt-get upgrade -y

ec "Installing packages (git, curl, zsh, terminator and packages to allow apt to use a repository over HTTPS)"
sudo apt-get install -y \
  terminator \
  zsh \
  git \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

ec "Installing oh-my-zsh"
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
touch ~/.zprofile

ec "Installing nodejs"
curl -fsSL "https://deb.nodesource.com/setup_$NODE_VERSION.x" | sudo -E bash -
sudo apt-get install nodejs -y

ec "Fixing npm permissions"
mkdir -p ~/.npm-global
npm config set prefix "~/.npm-global"

ec "Upgrading npm"
npm i -g npm

ec "Removing old npm/npx and linking new npm/npx"
sudo rm -rf /usr/{bin/npm,bin/npx,lib/node_modules}
sudo ln -s ~/.npm-global/lib/node_modules/npm/bin/npm-cli.js /usr/bin/npm
sudo ln -s ~/.npm-global/lib/node_modules/npm/bin/npx-cli.js /usr/bin/npx

ec "Downloading user apps"
mkdir -p ~/bin
curl -fSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --output ~/bin/chrome.deb
curl -fSL https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip --output ~/bin/exa.zip
curl -fSL https://github.com/meetfranz/franz/releases/download/v5.0.0-beta.18/franz_5.0.0-beta.18_amd64.deb --output ~/bin/franz.deb
curl -fSL https://release.gitkraken.com/linux/gitkraken-amd64.deb --output ~/bin/gitkraken.deb

ec "Installing Chrome"
sudo dpkg -i ~/bin/chrome.deb
sudo apt-get install -fy

ec "Installing exa"
unzip -d ~/bin ~/bin/exa.zip
sudo mv ~/bin/exa-linux-x86_64 /usr/bin/exa

ec "Installing Franz"
sudo dpkg -i ~/bin/franz.deb
sudo apt-get install -fy

ec "Installing GitKraken"
sudo dpkg -i ~/bin/gitkraken.deb
sudo apt-get install -fy

ec "Clean downloaded apps"
rm -rf ~/bin

ec "Installing Insomnia"
sudo snap install insomnia

ec "Installing kubectl"
sudo snap install kubectl

ec "Adding Docker sources to apt"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

ec "Adding VSCode sources to apt"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

ec "Adding GCloud SDK sources to apt"
CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

ec "Installing Docker, VSCode and GCloud SDK"
sudo apt-get update
sudo apt-get install -y google-cloud-sdk code docker-ce docker-ce-cli containerd.io

ec "Downloading powerlevel9k theme for oh-my-zsh"
mkdir -p ~/.oh-my-zsh/custom/themes
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

ec "Downloading powerline compatible font"
mkdir -p ~/.fonts
curl -fSL https://raw.githubusercontent.com/powerline/fonts/master/Meslo%20Dotted/Meslo%20LG%20M%20DZ%20Regular%20for%20Powerline.ttf --output ~/.fonts/Meslo\ LG\ M\ DZ\ Regular\ for\ Powerline.ttf

ec "Rebuilding font cache"
fc-cache -vf

ec "Configuring terminator"
mkdir -p ~/.config/terminator
curl -fSL https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/config/terminator-config --output ~/.config/terminator/config

ec "Configuring zsh"
sed -i '/ZSH_THEME="robbyrussell"/c\ZSH_THEME="powerlevel9k/powerlevel9k"' ~/.zshrc
echo 'source .zprofile' >> ~/.zshrc

ec "Making zsh the default shell"
chsh -s $(which zsh)
