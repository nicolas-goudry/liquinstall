#!/usr/bin/env bash

WEBSTORM_VERSION=2017.2.5
NODE_VERSION=6

echo "Updating distribution dependencies..."

sudo apt-get update 1>/dev/null
sudo apt-get upgrade -y 1>/dev/null

echo "Installing git, curl, zsh and terminator..."
sudo apt-get install terminator zsh curl git -y 1>/dev/null

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Downloading powerlevel9k theme for oh-my-zsh..."
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k 1>/dev/null

echo "Downloading powerline compatible font..."
mkdir -p ~/.fonts
curl -fSLO https://raw.githubusercontent.com/powerline/fonts/master/Meslo%20Dotted/Meslo%20LG%20M%20DZ%20Regular%20for%20Powerline.ttf --output "~/.fonts/Meslo LG M DZ Regular for Powerline.ttf"

echo "Rebuilding font cache..."
fc-cache -f 1>/dev/null

echo "Installing nodejs..."
curl -fsSL "https://deb.nodesource.com/setup_$NODE_VERSION.x" | sudo -E bash -
sudo apt-get install nodejs -y 1>/dev/null

echo "Fixing npm permissions..."
mkdir -p ~/.npm-global
npm config set prefix "~/.npm-global"

echo "Upgrading npm..."
npm i -g npm 1>/dev/null

echo "Removing old npm and linking new npm..."
sudo rm -rf /usr/{bin/npm,lib/node_modules}
sudo ln -s ~/.npm-global/lib/node_modules/npm/bin/npm-cli.js /usr/bin/npm

echo "Installing user apps..."
mkdir -p ~/bin

WEBSTORM_PID=

echo "Downloading Webstorm $WEBSTORM_VERSION..."
curl -fSL "https://download.jetbrains.com/webstorm/WebStorm-$WEBSTORM_VERSION.tar.gz" --output ~/bin/webstorm.tar.gz

echo "Installing Webstorm $WEBSTORM_VERSION..."
mkdir -p ~/bin/webstorm
tar -xzf ~/bin/webstorm.tar.gz -C ~/bin/webstorm --strip-components 1
~/bin/webstorm/bin/webstorm.sh &
sleep 5
WEBSTORM_PID=$(ps x -o "%r %c" | grep webstorm | awk '{print $1}')
kill -TERM -- -$WEBSTORM_PID

echo "Installing AnalyseSI..."
curl -fSL https://launchpad.net/analysesi/trunk/0.8/+download/AnalyseSI-O.80.jar --output ~/bin/analysesi.jar

echo "Downloading exa..."
curl -fSL https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip --output ~/bin/exa.zip

echo "Installing exa..."
unzip -d ~/bin ~/bin/exa.zip
sudo ln -s ~/bin/exa-linux-x86_64 /usr/bin/exa

echo "Downloading Franz..."
curl -fSL https://github.com/meetfranz/franz-app-legacy/releases/download/4.0.4/Franz-linux-x64-4.0.4.tgz --output ~/bin/franz.tgz

echo "Installing Franz..."
mkdir -p ~/bin/franz
tar -xzf ~/bin/franz.tgz -C ~/bin/franz --strip-components 1
mkdir -p ~/.local/share/applications
curl -fsSL https://raw.githubusercontent.com/nicolas-goudry/liquinstall/shortcuts/franz.desktop --output ~/.local/share/applications/franz.desktop

echo "Creating dev dir..."
mkdir -p ~/dev/osp
