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
	tmux &>> ~/.log && exit
fi
clear
if [ ! -f ~/.config/khal/.header ]
then
	~/.config/khal/header.sh
else
	cat ~/.config/khal/.header
fi
