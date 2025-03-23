# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#
zstyle ':zim:zmodule' use 'degit'

ZIM_HOME=~/.zim
# Initialize modules.
source ${ZIM_HOME}/init.zsh
# -----------------
# Zsh configuration
# -----------------
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh
#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# Import colorscheme from 'wal' asynchronously
# # &   # Run the process in the background.
# # ( ) # Hide shell job control messages.
#
# # Alternative (blocks terminal for 0-3ms)
#
# # To add support for TTYs this line can be optionally added.
export TERM="xterm-256color"
# Path to your oh-my-zsh configuration.
# ZSH=$HOME/.oh-my-zsh


zsh_wifi_signal(){
        local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I)
        local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')

        if [ "$airport" = "Off" ]; then
                local color='%F{black}'
                echo -n "%{$color%}Wifi Off"
        else
                local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
                local speed=$(echo $output | grep 'lastTxRate' | awk -F': ' '{print $2}')
                local color='%F{black}'

                [[ $speed -gt 100 ]] && color='%F{black}'
                [[ $speed -lt 50 ]] && color='%F{red}'

                echo -n "%{$color%}$speed Mbps \uf1eb%{%f%}" # removed char not in my PowerLine font
        fi
}

POWERLEVEL9K_CONTEXT_TEMPLATE='%n'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_BATTERY_CHARGING='yellow'
POWERLEVEL9K_BATTERY_CHARGED='green'
POWERLEVEL9K_BATTERY_DISCONNECTED='$DEFAULT_COLOR'
POWERLEVEL9K_BATTERY_LOW_THRESHOLD='10'
POWERLEVEL9K_BATTERY_LOW_COLOR='red'
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_BATTERY_ICON='\uf1e6 '
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{014}\u2570%F{cyan}\uF460%F{073}\uF460%F{109}\uF460%f "
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context battery dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time dir_writable ip custom_wifi_signal ram load background_jobs vi_mode)

POWERLEVEL9K_SHORTEN_DIR_LENGTH=1

POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M \uf073 %d/%m/%y}"
POWERLEVEL9K_TIME_BACKGROUND='white'
POWERLEVEL9K_RAM_BACKGROUND='yellow'
POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND="white"
POWERLEVEL9K_LOAD_WARNING_BACKGROUND="white"
POWERLEVEL9K_LOAD_NORMAL_BACKGROUND="white"
POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND="red"
POWERLEVEL9K_LOAD_WARNING_FOREGROUND="yellow"
POWERLEVEL9K_LOAD_NORMAL_FOREGROUND="black"
POWERLEVEL9K_LOAD_CRITICAL_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_LOAD_WARNING_VISUAL_IDENTIFIER_COLOR="yellow"
POWERLEVEL9K_LOAD_NORMAL_VISUAL_IDENTIFIER_COLOR="green"
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_STATUS_CROSS=true
#ZSH_THEME="honukai"
# ZSH_THEME="flazz"
#ZSH_THEME="avit"
# POWERLEVEL9K_VI_INSERT_MODE_STRING="I"
# POWERLEVEL9K_VI_COMMAND_MODE_STRING="N"
    # Set 'dir_writable' segment colors
# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="false"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

INTERACTIVECOMMENTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#
# plugins=(brew)

export PATH=/usr/local/bin:$PATH:/usr/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/git/bin:/System/Library/Perl/Extras/5.8.6:/Library/Perl/5.8.1:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/texlive/2013/bin/universal-darwin:~/Library/Mathematica/Applications:~/code/Mathematica:/usr/local/ff++/openmpi/3.47/bin
export PATH=$PATH:/Applications/Mathematica.app/Contents/MacOS:/usr/local/bin:/home/junior/.local/bin:/Users/junior/.local/bin:/Users/junior/.cabal/bin
export PATH=$PATH:/Users/junior/Library/Python/3.10/bin

# source $ZSH/oh-my-zsh.sh

LSCOLORS=

# Customize to your needs...
# export DROPBOX=~/Dropbox/
export MMA=/Applications/Mathematica\ Home\ Edition.app/SystemFiles/Links/MathLink/DeveloperKit/CompilerAdditions
export PYTHONIOENCODING=utf-8
# export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages
export CUDA_ROOT=/usr/local/cuda/bin
export DYLD_LIBRARY_PATH=/usr/local/cuda/lib/:$DYLD_LIBRARY_PATH
# export CLICOLOR=1
export TERM="xterm-256color"
export box_name='rmbpro'
export FZF_DEFAULT_COMMAND='ag -g ""'
export ML_PATH=/Users/junior/code/estudos/hands-on-ml
#
#
set -o vi

excel()  {  open -a "Microsoft Excel" "$@"  }
word()   {  open -a "Microsoft Word" "$@"  }
ppt()    {  open -a "Microsoft Powerpoint" "$@"  }
ff()     {  open -a "/Applications/Firefox.app" "$@"  }
vimr()     {  open -a "/Applications/VimR.app" "$@"  }
safari() {  open -a Safari "$@"  }
# paraview() {  open -a "/Applications/paraview.app/Contents/MacOS/paraview" "$@"  }
utf8()
{
    iconv -f ISO-8859-1 -t UTF-8 $1 > $1.tmp
	    rm $1
		    mv $1.tmp $1
			}
alias apps='open /Applications'
# alias gh='/Applications/Github\ Desktop.app; open .; cd -'
alias ffp='freefem++'
alias killstatus='killall -KILL SystemUIServer'

alias v=nvim
alias vim=nvim
alias ls='lsd'
# alias gh=github
# alias j=autojump
alias vimv='vim ~/.config/nvim/config.lua' 
alias vimz='vim ~/.zshrc'
alias vimi3='vim ~/.config/i3/config'
alias vimfc='vim ~/.fvwm/config'
alias rm='rm -v'
alias cp='cp -v'
alias mv='mv -v'
alias td='tmux detach'
alias vimt='vim ~/.tmux.conf'
alias tls='tmux ls'
alias py3='python3'
alias py2='python2'
alias py='python'
alias ipy3='ipython3'
alias zshr='source ~/.zshrc'
alias gits='git status'
alias dockerd='eval "$(docker-machine env default)"'
alias reload='source ~/.zshrc'
alias bupd='brew update'
alias bupg='brew upgrade'
alias cl='clear'
alias ff++='FreeFem++'
alias f='fuck'
# alias tmux='TERM=xterm-256color tmux -2'
alias tmuxinator='TERM=xterm-256color tmuxinator'
# alias mux='TERM=xterm-256color mux'
# alias octave='octave-cli'
alias vimt='vim ~/.tmux.conf'
alias vimd='vim ~/code/Docker/Dockerfile'
alias ms='MathematicaScript'
alias hsn='h|grep'
alias dockerm='docker run -u junior -t -i minha_imagem:v1'
alias ag='ag --nobreak --nonumbers --noheading . | fzf'
# alias ack='ack --pager="less -FRSX"'

CTAGS=--langmap=fortran:+.f90
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
set -k
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
function push {
    curl -s -F "token=asMoppDBgAybm4cessqpUUmG4yaSQq" \
		    -F "user=uXjLXfmTDSWy1vFqVyVPQ8ux7P1eeg" \
			    -F "title=iTerm" \
				    -F "message=$1" https://api.pushover.net/1/messages.json
	}
alias of231="/usr/bin/open ~/OpenFOAM.sparsebundle; sleep 1; . ~/OpenFOAM/OpenFOAM-2.3.1/etc/bashrc; . ~/.alias";
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:$CUDA_ROOT"

# # Base16 Shell
# BASE16_SHELL="$HOME/Dropbox/Library/base16-material.dark.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
# source ~/.iterm2_shell_integration.`basename $SHELL`
export EDITOR='nvim'
fpath=($HOME/.tmuxinator/completion ${fpath})
autoload -U compinit
compinit
export WORKON_HOME=/Users/junior/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
if [ "$TERM" = "xterm" ]; then
	  export TERM="xterm-256color"
fi
# source ~/.bin/tmuxinator.zsh  
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
# set VIMODE according to the current mode (default “[i]”)
VIMODE='[i]'
function zle-keymap-select {
 VIMODE="${${KEYMAP/vicmd/[n]}/(main|viins)/[i]}"
 zle reset-prompt
}

zle -N zle-keymap-select

# Set the prompt to “[user]@[host[ [vi mode] $ ”
# PROMPT="%n@%m ${VIMODE} \\$ "
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
sc() {find  -E ~/Documents/code/ ~/Dropbox/code/ -regex '.*\.(py|for|c|f|h|edp)'  | fzf | xargs  lvim ;}
# sc() {find  ~/Documents/code/ ~/Dropbox/code/ -regex '.*\.\(py\|for\|c\|f\|h\|edp\)'  | fzf | xargs  nvim ;}
si() {ack -l -m 20 "$1"  ~/Documents/code ~/Dropbox/code/| fzf | xargs lvim ;}
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	        source /etc/profile.d/vte.sh
fi
#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

p () {
    local open
    open=open   # on OSX, "open" opens a pdf in preview
    # ag  -g ".pdf$" \
    find  -E ~/Documents/ ~/Dropbox/ ~/Downloads/ -regex '.*\.(pdf|pdf)' \
    | fast-p \
    | fzf --read0 --reverse -e -d $'\t'  \
        --preview-window down:80% --preview '
            v=$(echo {q} | gtr " " "|"); 
            echo -e {1}"\n"{2} | ggrep -E "^|$v" -i --color=always;
        ' \
    | gcut -z -f 1 -d $'\t' | gtr -d '\n' | gxargs -r --null $open > /dev/null 2> /dev/null
}

j() {
    if [[ "$#" -ne 0 ]]; then
        cd $(autojump $@)
        return
    fi
    cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' |  fzf --height 40% --reverse --inline-info)" 
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
export NODE\_OPTIONS=--experimental-worker
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi
# # Enable autosuggestions automatically
# zle-line-init() {
#     zle autosuggest-start
# }

# zle -N zle-line-init
eval $(thefuck --alias)
 # zsh
  eval "$(fzf --zsh)"


  # source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
eval "$(zoxide init zsh)"
