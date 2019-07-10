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

ec "Installing packages"
sudo apt-get install -y \
  terminator \
  zsh \
  git \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common \
  build-essential \
  openjdk-11-jdk

ec "Configuring terminator"
mkdir -p ~/.config/terminator
curl -fSL https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/config/terminator-config --output ~/.config/terminator/config

ec "Configuring Git"
curl -fSL https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/config/.gitconfig --output ~/.gitconfig

ec "Installing oh-my-zsh"
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
mkdir -p ~/.oh-my-zsh/custom/themes
mkdir -p ~/.fonts
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
sed -i '/ZSH_THEME="robbyrussell"/c\ZSH_THEME="powerlevel9k/powerlevel9k"' ~/.zshrc
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
curl -fSL https://raw.githubusercontent.com/powerline/fonts/master/Meslo%20Dotted/Meslo%20LG%20M%20DZ%20Regular%20for%20Powerline.ttf --output ~/.fonts/Meslo\ LG\ M\ DZ\ Regular\ for\ Powerline.ttf
fc-cache -vf

ec "Configuring zsh"
curl -fSL https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/config/.zprofile --output ~/.zprofile
echo 'source .zprofile' >> ~/.zshrc

ec "Installing nodejs"
curl -fsSL "https://deb.nodesource.com/setup_$NODE_VERSION.x" | sudo -E bash -
sudo apt-get install nodejs -y

ec "Fixing npm permissions"
mkdir -p ~/.npm-global
npm config set prefix "~/.npm-global"

ec "Upgrading npm"
npm i -g npm

ec "Updating npm/npx symlinks in /usr/bin"
sudo rm -rf /usr/{bin/npm,bin/npx,lib/node_modules}
sudo ln -s ~/.npm-global/lib/node_modules/npm/bin/npm-cli.js /usr/bin/npm
sudo ln -s ~/.npm-global/lib/node_modules/npm/bin/npx-cli.js /usr/bin/npx

ec "Installing global npm packages"
npm i -g expo-cli npm-check-updates prettier standard react-native create-react-native-app

ec "Downloading apps"
mkdir -p ~/bin
curl -fSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --output ~/bin/chrome.deb
curl -fSL https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip --output ~/bin/exa.zip
curl -fSL https://release.gitkraken.com/linux/gitkraken-amd64.deb --output ~/bin/gitkraken.deb
curl -fSL https://github.com/sindresorhus/caprine/releases/download/v2.33.1/caprine-2.33.1-x86_64.AppImage --output ~/bin/caprine.AppImage
curl -fSL https://github.com/sqlectron/sqlectron-gui/releases/download/v1.30.0/Sqlectron_1.30.0_amd64.deb --output ~/bin/sqlectron.deb
curl -fSL https://downloads.slack-edge.com/linux_releases/slack-desktop-3.4.2-amd64.deb --output ~/bin/slack.deb

ec "Installing Chrome"
sudo dpkg -i ~/bin/chrome.deb
sudo apt-get install -fy

ec "Installing exa"
unzip -d ~/bin ~/bin/exa.zip
sudo mv ~/bin/exa-linux-x86_64 /usr/bin/exa

ec "Installing GitKraken"
sudo dpkg -i ~/bin/gitkraken.deb
sudo apt-get install -fy

ec "Installing Caprine"
sudo mv ~/bin/caprine.AppImage /usr/bin/caprine

ec "Installing Sqlectron"
sudo dpkg -i ~/bin/sqlectron.deb
sudo apt-get install -fy

ec "Installing Slack"
sudo dpkg -i ~/bin/slack.deb
sudo apt-get install -fy

ec "Clean downloaded apps"
rm -rf ~/bin

ec "Install Redis server"
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
sudo make install

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

ec "Adding Insomnia REST sources to apt"
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc | sudo apt-key add -

ec "Adding kubectl sources to apt"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

ec "Installing Docker, VSCode, GCloud SDK, Insomnia REST and kubectl"
sudo apt-get update
sudo apt-get install -y google-cloud-sdk code docker-ce docker-ce-cli containerd.io insomnia kubectl

ec "Configuring VSCode"
curl -fSL https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/config/vscode-config --output ~/.config/Code/User/settings.json

ec "Installing VSCode extensions"
code --install-extension peterjausovec.vscode-docker
code --install-extension mikestead.dotenv
code --install-extension prisma.vscode-graphql
code --install-extension eg2.vscode-npm-script
code --install-extension esbenp.prettier-vscode
code --install-extension chenxsan.vscode-standardjs
code --install-extension vscode-icons-team.vscode-icons

ec "Make sure clock seconds are displayed"
gsettings set org.gnome.desktop.interface clock-show-seconds true
