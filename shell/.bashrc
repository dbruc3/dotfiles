clear
. ~/.bash_aliases
#PROMPT="%~: "
PS1="\w: "
eval "$(ssh-agent -s)" &>> .log
ssh-add ~/.ssh/id_rsa &>> .log

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
	~/.scripts/wifi-scan.py
	echo
	rm ~/.first
fi

agenda="~/.config/khal/.header"
if [ -f $agenda ]
then
	cat $agenda
fi
