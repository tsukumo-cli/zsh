export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="tsu"

export EDITOR="vim"

alias lla='ls -Alh'
alias link='ln -s'

alias zshconfig="${EDITOR} ~/.zshrc; source ~/.zshrc"
alias zshtheme="${EDITOR} ~/.oh-my-zsh/themes/$ZSH_THEME.zsh-theme; source ~/.zshrc"
alias zshrc='zshconfig'

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

