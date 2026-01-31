########################
#    basic settings    #
########################
# prevent duplicate PATH entries
typeset -U PATH

# language setting
export LANG=en_US.UTF-8

# vim like movement
bindkey -v
bindkey -M viins ^o vi-cmd-mode
bindkey "^?" backward-delete-char

# clear prompt function
function clear-prompt {
    clear
    zle reset-prompt
}
zle -N clear-prompt
bindkey "^o^o" clear-prompt

# command history setting
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=1000000
setopt HIST_IGNORE_ALL_DUPS # do not record duplicate cmd
setopt HIST_IGNORE_SPACE    # do not record cmd whose start char is space
setopt HIST_FIND_NO_DUPS    # reduce deprecated cmd when finding
setopt HIST_REDUCE_BLANKS   # remove blank
setopt HIST_NO_STORE        # do not record history cmd

# function to refresh tmux env
if [ -n "$TMUX" ]; then
    function _update_tmux_env {
        local val
        val=$(tmux show-environment DISPLAY 2>/dev/null)
        [[ $val == DISPLAY=* ]] && export "$val"
        val=$(tmux show-environment SSH_CONNECTION 2>/dev/null)
        [[ $val == SSH_CONNECTION=* ]] && export "$val"
    }
    function refresh {
        _update_tmux_env
        tmux source-file ~/.tmux.conf
    }
    # update env on shell startup in tmux
    _update_tmux_env
else
    function refresh { :; }
fi
autoload -Uz add-zsh-hook
add-zsh-hook preexec refresh

# SSH agent: use forwarded agent when connected via SSH, otherwise use 1Password
if [[ -z "$SSH_CONNECTION" ]]; then
    export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
fi

# reset cursor to blinking underline on each prompt
_reset_cursor() {
    echo -ne '\e[3 q'
}
add-zsh-hook precmd _reset_cursor

# disable ctrl+s in vim
stty stop undef
stty start undef

#########################
#      Zplug init       #
#########################
if [[ -f ~/.zplug/init.zsh ]]; then
  source ~/.zplug/init.zsh
else
  echo "zplug not found. Please install: https://github.com/zplug/zplug"
fi

#########################
#     Zplug plugins     #
#########################
autoload colors && colors
setopt prompt_subst

# manage zplug by zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# make command completion stronger
zplug "zsh-users/zsh-completions"
# make command auto suggestion based on history
zplug "zsh-users/zsh-autosuggestions"
# command line syntax highlight
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# load theme from local
zplug "~/.zsh/themes/", from:local, use:bullet-train.zsh-theme, defer:3

# install check and then load
zplug check || zplug install
zplug load

bindkey '^]' autosuggest-accept

#########################
#  completion settings  #
#########################
# enable completion
zmodload -i zsh/complist
autoload -Uz compinit
# Regenerate zcompdump only once per day
if [[ -z ~/.zcompdump(#qN.mh-24) ]]; then
  compinit
else
  compinit -C
fi
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi

# colorized path completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' verbose no
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# vim like movement when completion
zstyle ':completion:*:default' menu select=2
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# completion from intermediate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

########################
#    alias settings    #
########################
if command -v lsd > /dev/null; then
    alias ls="lsd"
else
    alias ls="ls --color=auto"
fi
if command -v nvim > /dev/null; then
    alias vim="nvim"
fi
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"
alias free="free -g"
alias watch='watch '
alias timg='timg -pk'

########################
#     SSH settings     #
########################
# SSH forward agent
[[ "$SSH_AUTH_SOCK" != "$HOME/.ssh/sock" && -S "$SSH_AUTH_SOCK" ]] \
    && ln -snf "$SSH_AUTH_SOCK" "$HOME/.ssh/sock" \
    && export SSH_AUTH_SOCK="$HOME/.ssh/sock"

########################
#     path settings    #
########################
export VOLTA_HOME="$HOME/.volta"
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export ANDROID_HOME="/opt/homebrew/share/android-commandlinetools"
export PATH="$VOLTA_HOME/bin:$HOME/.local/bin:/opt/homebrew/bin:$HOME/local/bin:$HOME/.pyenv/bin:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"

if command -v pyenv > /dev/null; then
    eval "$(pyenv init -)"
fi
if command -v atuin > /dev/null; then
    eval "$(atuin init zsh --disable-up-arrow)"
fi
[[ -f ~/.zshrc.takedalab ]] && source ~/.zshrc.takedalab || true
[[ -f ~/google-cloud-sdk/path.zsh.inc ]] && source ~/google-cloud-sdk/path.zsh.inc || true
[[ -f ~/google-cloud-sdk/completion.zsh.inc ]] && source ~/google-cloud-sdk/completion.zsh.inc || true
[[ -f ~/.safe-chain/scripts/init-posix.sh ]] && source ~/.safe-chain/scripts/init-posix.sh || true
[[ -f ~/.atuin/bin/env ]] && source "$HOME/.atuin/bin/env" || true
[[ -f ~/.orbstack/shell/init.zsh ]] && source ~/.orbstack/shell/init.zsh || true
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env" || true
