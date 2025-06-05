export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

if [ -t 1 ] && [ -z "$ZSH_OVERRIDE" ]; then
    export ZSH_OVERRIDE=1    # prevent infinite recursion
    exec /usr/bin/zsh -l     # replace current shell with zsh as login shell
fi
