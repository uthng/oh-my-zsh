# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/u/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="blinks"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose extract golang systemd rsync debian cp)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

unsetopt share_history
setopt no_share_history

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

function make()
{
     #local MAKE="`which make`"
     local MAKE="/usr/bin/make"
     ${MAKE} $* 2>&1|sed -f $HOME/.rules.sed
     # PIPESTATUS in CAPITAL LETTER in BASH
     status=${pipestatus[0]}
     return $status
}

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

function pingts
{
    ping $1 | while read line; do echo "$(date): $line"; done
}

alias grep='grep --color=auto'
# $1: search pattern
# $2: file pattern
# $3: in folder
# $4: exclude folder
# Ex: filegrep "middleware" "*.go" "vendor\|workflow"
function fgr {
    if [ -z "$4" ]; then
        find "$3" -name "$2" | xargs grep --color=auto -in -e "$1"
    else
        find "$3" -name "$2" | grep -v -e "$4" | xargs grep --color=auto -in -e "$1"
    fi
}

# $1: search pattern
# $2: replace pattern
# $3: file pattern
# $4: in folder
# $5: exclude pattern
# Ex: filesearchreplace "taskflow/token" "taskflow/common/token" "*.go" "vendor\|workflow"
function fsr {
    #fgr "$1" "$3" "$4" "$5" |  awk -F':[0-9]+:' '{ print $1 }' | uniq | xargs sed -ie 's/'"$1"'/'"$2"'/g'
    fgr "$1" "$3" "$4" "$5" |  awk -F':[0-9]+:' '{ print $1 }' | uniq | xargs sed -i 's/'"$1"'/'"$2"'/g'
}

#export KUBECONFIG="${KUBECONFIG}:$HOME/Documents/Projets/Kubernetes/coreos-kubernetes/multi-node/vagrant/kubeconfig"

# DOCKER commands
alias docker-rm-all='docker rm $(docker ps -a -q)'
alias docker-rmi-none='docker rmi $(docker images -f "dangling=true" -q)'

alias cdprj='cd /data/Projets'

# GIT
alias glsg='git log --stat --pretty=fuller --graph --abbrev-commit --decorate'
alias glsgp='git log --stat --pretty=fuller --graph --abbrev-commit --decorate -p'

 #GO STUFFS
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/pulse
export PATH=$PATH:/usr/local/pulse
export PATH=$PATH:/usr/local/go/bin
export GOPATH=/data/Projets/go
export GOBIN=$GOPATH/bin
export GOSRC=$GOPATH/src
export PATH=$PATH:$GOBIN

# GO-WORKFLOW
export PATH=$PATH:/usr/local/go-workflow/bin
