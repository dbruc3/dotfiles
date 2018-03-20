#DEV
alias pip='pip3'

#MISCELLANEOUS
alias weather='~/.scripts/weather.py'
alias forecast='~/.scripts/forecast.py'
alias whereami='~/.scripts/whereami.py'

#NAVIGATION
alias vm='vim'
alias ls='ls --color=auto'
alias cls='clear'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

#SOCIAL
abook()
{
	if [ ! -f ~/.abook/addressbook ]
	then
		~/.abook/vcf2abook.py ~/.abook/contacts ~/.abook/addressbook
	fi
	abook --datafile=~/.abook/addressbook
	~/.abook/abook2vcf.py ~/.abook/addressbook ~/.abook/contacts
}

#WEB
ddg()
{
	elinks -no-numbering "https://ddg.gg/?q=$*"
}
bang()
{
	ddg !$*
}
alias wiki='bang w'
bangs()
{
	curl -sL https://ddg.gg/bang_lite.html | grep "$1" | grep "<br>" | sed "s/<br>//g"
}

