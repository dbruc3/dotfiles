clear
. ~/.bash_aliases
#PROMPT="%~: "
#PS1="\w: "
PS1='$(gbt $?)'
export GBT_CARS='Status, Dir, Git, Sign'
export GBT_CAR_DIR_BG='black'

export TERM='xterm-256color'
export TMP="~/.tmp"
eval "$(ssh-agent -s)" # &>> $TMP/.log
ssh-add ~/.ssh/id_rsa #&>> $TMP/.log
clear

export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

export TZ=$(getprop persist.sys.timezone)
if [ ! -n "$SSH_CONNECTION" ]
then
	if ! tmux info &> /dev/null
	then
		touch .first
		up=`apt list --upgradable | grep upgradable | wc -l`
		if [[ $up > 0 ]]
		then
			pkg upgrade
		fi
		tmux &>> ~/.log && exit
	fi
fi

if [ -f ~/.first ]
then
	neofetch
	~/.scripts/wifi-scan.py | head -6
	echo
	rm ~/.first
fi

agenda="~/.config/khal/.header"
if [ -f $agenda ]
then
	cat $agenda
fi
