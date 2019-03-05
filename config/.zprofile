export DEFAULT_USER=nicolas
export PATH=$PATH:~/.npm-global/bin

function mkcd() { mkdir -p "$@" && cd "$_"; }
function tarpg() { tar cf - $1 -P | pv -s $(du -sb $1 | awk '{print $1}') | gzip > $2.tar.gz }

alias ls=exa
alias k=kubectl
