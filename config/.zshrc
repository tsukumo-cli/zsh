export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="custom"

export EDITOR="vim"

alias lla='ls -Alh'
alias link='ln -s'


alias zshconfig="${EDITOR} ~/.zshrc; source ~/.zshrc"
alias zshtheme="${EDITOR} ~/.oh-my-zsh/themes/$ZSH_THEME.zsh-theme; source ~/.zshrc"
alias zshrc='zshconfig'

cdp () {
    if [ $# -gt 1 ];then;echo 'too many arguments';return;fi
    if [ $# -lt 1 ];then;echo 'too few arguments';return;fi

    mkdir -p $1
    cd $1
}

# Comment the following line to hide red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"


plugins=(git)

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"


# User feature control

hidehost () { ZSH_HIDEHOST=1 }
showhost () { unset ZSH_HIDEHOST }

hideuser () { ZSH_HIDEUSER=1 }
showuser () { unset ZSH_HIDEUSER }

hidetime () { ZSH_HIDETIME=1 }
showtime () { unset ZSH_HIDETIME }

hideface () { ZSH_HIDEFACE=1 }
showface () { unset ZSH_HIDEFACE }


hidehost
hideface

