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
		echo "Checking for updates..."
		updates=`~/.tmux/updates.py`
		if [ ! -z $updates ]
		then
			pkg upgrade
		fi
		termux-clipboard-set ""
		tmux &>> ~/.log && exit
	fi
fi
clear
if [ ! -f ~/.config/khal/.header ]
then
	~/.config/khal/header.sh
else
	cat ~/.config/khal/.header
fi
