#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# import __git_ps1 and friends
source /usr/share/git/git-prompt.sh

_RED=$(tput setaf 1)
_GREEN=$(tput setaf 2)
_YELLOW=$(tput setaf 3)
_BLUE=$(tput setaf 4)
_MAGENTA=$(tput setaf 5)
_BOLD=$(tput bold)
_RESET=$(tput sgr0)
PS1='['
PS1+='${_BOLD}${_YELLOW}\u${_GREEN}@${_BOLD}${_YELLOW}\h '
PS1+='${_BLUE}\@ '
PS1+='${_BOLD}${_MAGENTA}\w${_RESET}${_MAGENTA}$(__git_ps1)${_RESET}'
PS1+=']'
PS1+='\n\$ '

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

export MANPAGER="nvim +Man!"

paths=(
    "~/.local/bin/"
)
for path in "${paths[@]}"
do
    export PATH="${PATH:+${PATH}:}$path"
done

