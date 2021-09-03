export DEFAULT_USER=nicolas

# Make directory and change directory in one command
function mkcd() { mkdir -p "$@" && cd "$_"; }

# Useful aliases
alias ls=exa
alias l="ls"
alias ll="ls -la"
alias k=kubectl

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Set up ZSH pure prompt
fpath+=$HOME/.zsh/pure
autoload -Uz promptinit; promptinit
prompt pure
