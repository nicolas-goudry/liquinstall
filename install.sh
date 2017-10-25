#!/usr/bin/env bash

WEBSTORM_RELEASE=2017.2
WEBSTORM_VERSION="$WEBSTORM_RELEASE.5"
NODE_VERSION=6
YELLOW='\033[1;33m'
NC='\033[0m'

function ec () {
  echo -e "${YELLOW}$*${NC}"
}

ec "Updating distribution dependencies..."
sudo apt-get update
sudo apt-get upgrade -y

ec "Installing git, curl, zsh and terminator..."
sudo apt-get install terminator zsh curl git -y

ec "Installing oh-my-zsh..."
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

ec "Installing nodejs..."
curl -fsSL "https://deb.nodesource.com/setup_$NODE_VERSION.x" | sudo -E bash -
sudo apt-get install nodejs -y

ec "Fixing npm permissions..."
mkdir -p ~/.npm-global
npm config set prefix "~/.npm-global"

ec "Upgrading npm..."
npm i -g npm

ec "Removing old npm and linking new npm..."
sudo rm -rf /usr/{bin/npm,lib/node_modules}
sudo ln -s ~/.npm-global/lib/node_modules/npm/bin/npm-cli.js /usr/bin/npm

ec "Installing user apps..."
mkdir -p ~/bin

ec "Downloading Chrome..."
curl -fSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --output ~/bin/chrome.deb

ec "Installing Chrome..."
sudo dpkg -i ~/bin/chrome.deb
sudo apt-get install -fy
rm -f ~/bin/chrome.deb

ec "Downloading Webstorm $WEBSTORM_VERSION..."
curl -fSL "https://download.jetbrains.com/webstorm/WebStorm-$WEBSTORM_VERSION.tar.gz" --output ~/bin/webstorm.tar.gz

ec "Installing Webstorm $WEBSTORM_VERSION..."
mkdir -p ~/bin/webstorm
tar -xzvf ~/bin/webstorm.tar.gz -C ~/bin/webstorm --strip-components 1
rm -f ~/bin/webstorm.tar.gz

ec "Downloading AnalyseSI..."
curl -fSL https://launchpad.net/analysesi/trunk/0.8/+download/AnalyseSI-0.80.jar --output ~/bin/analysesi.jar

ec "Downloading exa..."
curl -fSL https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip --output ~/bin/exa.zip

ec "Installing exa..."
unzip -d ~/bin ~/bin/exa.zip
rm -f ~/bin/exa.zip
sudo ln -s ~/bin/exa-linux-x86_64 /usr/bin/exa

ec "Downloading Franz..."
curl -fSL https://github.com/meetfranz/franz-app-legacy/releases/download/4.0.4/Franz-linux-x64-4.0.4.tgz --output ~/bin/franz.tgz

ec "Installing Franz..."
mkdir -p ~/bin/franz
tar -xzvf ~/bin/franz.tgz -C ~/bin/franz --strip-components 1
rm -f ~/bin/franz.tgz
mkdir -p ~/.local/share/applications
curl -fSL https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/shortcuts/franz.desktop --output ~/.local/share/applications/franz.desktop

ec "Downloading GitKraken..."
curl -fSL https://release.gitkraken.com/linux/gitkraken-amd64.deb --output ~/bin/gitkraken.deb

ec "Installing GitKraken..."
sudo dpkg -i ~/bin/gitkraken.deb
sudo apt-get install -fy
rm -f ~/bin/gitkraken.deb

ec "Installing Sublime Text 3..."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https -y
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text -y

ec "Creating dev dir..."
mkdir -p ~/dev/osp

ec "Downloading powerlevel9k theme for oh-my-zsh..."
mkdir -p ~/.oh-my-zsh/custom/themes
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

ec "Downloading powerline compatible font..."
mkdir -p ~/.fonts
curl -fSL https://raw.githubusercontent.com/powerline/fonts/master/Meslo%20Dotted/Meslo%20LG%20M%20DZ%20Regular%20for%20Powerline.ttf --output ~/.fonts/Meslo\ LG\ M\ DZ\ Regular\ for\ Powerline.ttf

ec "Rebuilding font cache..."
fc-cache -vf

ec "Configuring terminator..."
mkdir -p ~/.config/terminator
curl -fSL https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/config/terminator-config --output ~/.config/terminator/config

ec "Configuring Sublime Text..."
curl -fSL https://raw.githubusercontent.com/nicolas-goudry/subl-autoconf/master/install.sh | bash -s 3

ec "Configuring zsh..."
sed -i '/ZSH_THEME="robbyrussell"/c\ZSH_THEME="powerlevel9k/powerlevel9k"' ~/.zshrc
echo 'export DEFAULT_USER=nicolas' >> ~/.zshrc
echo 'export PATH=$PATH:~/.npm-global/bin' >> ~/.zshrc
echo 'function mkcd() { mkdir -p "$@" && cd "$_"; }' >> ~/.zshrc
echo 'alias ls=exa' >> ~/.zshrc

ec "Configuring Webstorm $WEBSTORM_VERSION..."
mkdir -p "~/.WebStorm$WEBSTORM_RELEASE/config"
curl -fSL https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/config/webstorm-config.tar.gz --output ~/webstorm-config.tar.gz
tar -xjvf ~/webstorm-config.tar.gz -C ~ --strip-components 2
# ~/bin/webstorm/bin/webstorm.sh &

ec "Making zsh the default shell..."
chsh -s $(grep /zsh$ /etc/shells | tail -1)
