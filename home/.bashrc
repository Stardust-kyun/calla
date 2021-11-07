PS1='\W \$ '
# fetch
[[ -z "$FUNCNEST" ]] && export FUNCNEST=250          # limits recursive functions, see 'man bash'

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."
alias cl='cd $HOME && clear && fetch'
alias untar='tar -xvf'
alias keys='xev | awk -F'\''[ )]+'\'' '\''/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'\'''
