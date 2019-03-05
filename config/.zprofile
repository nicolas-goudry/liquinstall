export DEFAULT_USER=nicolas
export PATH=$PATH:~/.npm-global/bin

function mkcd() { mkdir -p "$@" && cd "$_"; }
function tarpg() { tar cf - $1 -P | pv -s $(du -sb $1 | awk '{print $1}') | gzip > $2.tar.gz }
function split_file() { gzip -c $1 | split -b $2MiB - $1.gz_ }
function join_file() { cat $1.gz_* | gunzip -c > $2 }

alias ls=exa
alias k=kubectl
