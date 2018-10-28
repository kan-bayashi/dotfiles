########################
#    basic settings    #
########################
# language setting
LANG=en_US.UTF-8

# alias settings
alias ls="ls -G"
alias la="ls -a"
alias ll="ls -l"
alias free="free -g"
alias watch='watch '

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
HISTSIZE=1000
SAVEHIST=1000000
setopt HIST_IGNORE_DUPS     # do not recode deprecated cmd
setopt HIST_IGNORE_ALL_DUPS # do not recode deprecated cmd
setopt HIST_IGNORE_SPACE    # do not record cmd whose start char is space
setopt HIST_FIND_NO_DUPS    # reduce deprecated cmd when finding
setopt HIST_REDUCE_BLANKS   # remove blank
setopt HIST_NO_STORE        # do not record history cmd

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
# command line syntax highlight
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# useful change directory
zplug "b4b4r07/enhancd", use:init.sh
# load theme from local
zplug "~/.zsh/themes/", from:local, use:bullet-train.zsh-theme, defer:3
# visual mode for zsh vim key binding
zplug "b4b4r07/zsh-vimode-visual", defer:3

# install check and then load
zplug check || zplug install
zplug load

#########################
#   enhancd settings    #
#########################
export ENHANCD_USE_FUZZY_MATCH=0 # do not use fuzzy match
export ENHANCD_DISABLE_HOME=1    # "cd" then go home
export ENHANCD_FILTER=fzf

#########################
#     less settings     #
#########################
export LESS=" -R "

#########################
#      fzf settings     #
#########################
export FZF_DEFAULT_OPTS='
    --height=40% --reverse --border
    --exit-0 --select-1
    --color fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104
    --color info:183,prompt:110,spinner:107,pointer:167,marker:215'
export FZF_CTRL_T_OPTS="
    --preview 'echo {}'
    --preview-window down:2:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="
    --preview 'tree -C {} | head -100'
    --preview-window down:10
    --bind '?:toggle-preview'"
export FZF_CTRL_R_OPTS="
    --preview 'echo {}'
    --preview-window down:3:hidden:wrap
    --bind '?:toggle-preview'"
export FZF_DEFAULT_COMMAND="fd --no-ignore-vcs --ignore-file ~/.ignore --hidden --follow"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --follow --hidden --no-ignore-vcs . $HOME'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '^F' fzf-file-widget
bindkey '^N' fzf-cd-widget

# kill task with fxf
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# show git log and then check diff via ctrl-d
fshow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d --toggle-sort=\`); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
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
# add path
export PATH=/Applications/MacVim.app/Contents/bin:$PATH

# compile zshrc
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi
