# PS1='$(tput bold)\W \$ $(tput sgr0)'
PS1='\W \$ '
[[ -z "$FUNCNEST" ]] && export FUNCNEST=250          # limits recursive functions, see 'man bash'

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."
alias cl='cd $HOME && clear && fetch'
alias untar='tar -xvf'
alias keys='xev | awk -F'\''[ )]+'\'' '\''/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'\'''
alias nv='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME="nvidia" __VK_LAYER_NV_optimus="NVIDIA_only" $1'

function xses() {
	read -r -p "Session command: " session
	read -r -p "Resolution: " screen
	startx ~/.xinitrc $session -- /usr/bin/Xephyr -screen $screen :1 & disown
}
