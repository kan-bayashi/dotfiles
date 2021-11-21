[ -x /usr/bin/zsh ] && exec /bin/zsh -l
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
