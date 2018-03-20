clear
. ~/.bash_aliases
PROMPT="%~: "
eval "$(ssh-agent -s)" &>> .log
ssh-add ~/.ssh/id_rsa &>> .log

export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

if [ ! -n "$SSH_CONNECTION" ]
then
	tmux &>> ~/.log && exit
fi
clear
