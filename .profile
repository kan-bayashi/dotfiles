if [ -t 1 ] && [ -z "$ZSH_OVERRIDE" ]; then
    export ZSH_OVERRIDE=1    # prevent infinite recursion
    exec /usr/bin/zsh -l     # replace current shell with zsh as login shell
fi
