########################
#    basic settings    #
########################
# language setting
LANG=en_US.UTF-8

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
setopt HIST_IGNORE_DUPS     # do not recode deprecated cmd
setopt HIST_IGNORE_ALL_DUPS # do not recode deprecated cmd
setopt HIST_IGNORE_SPACE    # do not record cmd whose start char is space
setopt HIST_FIND_NO_DUPS    # reduce deprecated cmd when finding
setopt HIST_REDUCE_BLANKS   # remove blank
setopt HIST_NO_STORE        # do not record history cmd
setopt share_history        # share history among the tmux panes and windows
unsetopt auto_remove_slash

# function to refresh tmux env
if [ -n "$TMUX" ]; then
    function refresh {
        export OS=`tmux show-environment | grep ^OS | sed -e 's/OS=//g'`
        export DISPLAY=`tmux show-environment | grep ^DISPLAY | sed -e 's/DISPLAY=//g'`
        tmux source-file ~/.tmux.conf
    }
else
    function refresh {
        echo -n ""
    }
fi
autoload -Uz add-zsh-hook
add-zsh-hook preexec refresh

# dircolors setting
if [ -f ~/.dircolors ]; then
    if type dircolors > /dev/null 2>&1; then
        eval $(dircolors ~/.dircolors)
    elif type gdircolors > /dev/null 2>&1; then
        eval $(gdircolors ~/.dircolors)
    fi
fi

# disable ctrl+s in vim
stty stop undef
stty start undef

#########################
#      Zplug init       #
#########################
source ~/.zplug/init.zsh

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
# useful change directory
zplug "b4b4r07/enhancd", use:init.sh
# load theme from local
zplug "~/.zsh/themes/", from:local, use:bullet-train.zsh-theme, defer:3

# install check and then load
zplug check || zplug install
zplug load

bindkey '^]' autosuggest-accept

#########################
#   enhancd settings    #
#########################
export ENHANCD_USE_FUZZY_MATCH=0 # do not use fuzzy match
export ENHANCD_DISABLE_HOME=1    # "cd" then go home
export ENHANCD_FILTER=fzf
export ENHANCD_AWK=awk

#########################
#     less settings     #
#########################
export LESS="-i -R -M"

#########################
#      fzf settings     #
#########################
export FZF_DEFAULT_OPTS='
    --height=40% --reverse --border
    --exit-0 --select-1
    --color fg:188,hl:103,fg+:222,bg+:234,hl+:104
    --color info:183,prompt:110,spinner:107,pointer:167,marker:215'
export FZF_CTRL_R_OPTS="
    --sort
    --preview 'echo {}'
    --preview-window down:3:hidden:wrap
    --bind '?:toggle-preview'"
export FZF_DEFAULT_COMMAND="fd --no-ignore-vcs --ignore-file ~/.ignore --hidden --follow"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# not to use ctrl + T and alt + C
bindkey -r "^T"
bindkey -r "\ec"

# interactively kill task with fzf
fkill () {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill -${1:-9}
  fi
}

#########################
#  completion settings  #
#########################
# enable completion
zmodload -i zsh/complist
autoload -Uz compinit && compinit

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
#    extra settings    #
########################
# path setting
if [ -z "$TMUX" ];then
    export PATH=$HOME/local/bin:$PATH
    if [ -e ${HOME}/.poetry/bin ]; then
        export PATH=$HOME/.poetry/bin:$PATH
    fi
fi

# alias settings
if which lsd > /dev/null; then
    alias ls="lsd"
else
    alias ls="ls --color=auto"
fi
if which nvim > /dev/null; then
    alias vim="nvim"
fi
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"
alias free="free -g"
alias watch='watch '
nless () {
    nkf -Lw ${1} | less
}

function show {
    clear
    convert -resize 512x512 $1 - | imgcat
}
compdef _files show

function git_merge_one_file {
    if [ $# -ne 4 ]; then
        echo -e "Usage : $0 ./path/to/file our_branch base_branch theirs_branch "
    else
        file_name=$1
        ours=$2
        base=$3
        theirs=$4
        git show ${ours}:${file_name} > ${file_name}.ours
        git show ${base}:${file_name} > ${file_name}.base
        git show ${theirs}:${file_name} > ${file_name}.theirs
        git merge-file -p ${file_name}.ours ${file_name}.base ${file_name}.theirs > ${file_name}
        rm ${file_name}.ours ${file_name}.base ${file_name}.theirs
    fi
}

# load environment dependent setting
[ -e ~/.zshrc.takedalab ] && source ~/.zshrc.takedalab

# compile zshrc
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi

# activate pyenv
eval "$(pyenv init -)"

# SSH forward agent
[[ $SSH_AUTH_SOCK != $HOME/.ssh/sock && -S $SSH_AUTH_SOCK ]] \
    && ln -snf "$SSH_AUTH_SOCK" "$HOME/.ssh/sock" \
    && export SSH_AUTH_SOCK="$HOME/.ssh/sock"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
