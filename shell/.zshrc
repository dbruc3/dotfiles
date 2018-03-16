. ~/.bash_aliases
PROMPT="%~: "
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
export GOPATH="$HOME/projects/go"
export PATH="$PATH:$GOPATH/bin"
tmux && exit
