. ~/.bash_aliases
PROMPT="%~: "
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
tmux && exit
