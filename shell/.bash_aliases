#DEV
alias pip='pip3'

#MISCELLANEOUS
alias weather='~/.scripts/weather.py'
alias forecast='~/.scripts/forecast.py'
alias whereami='~/.scripts/whereami.py'
alias wifi='~/.scripts/wifi-scan.py'

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
khalbin=`which khal`
alias month="$khalbin"
ikhal()
{
	$khalbin interactive
	pushd ~/.config/khal/calendar
	changes=`git add * && git commit -a -m auto-commit && git push`
	if [ -z "$changes" ]
	then
		if [ ! -f ~/.config/khal/.header ]
		then
			rm ~/.config/khal/.header
			~/.config/khal/header.sh
		fi
	fi
}
alias khal='khal list now 7 days'
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

