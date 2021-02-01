# MISC
alias x="exit"
alias xo="xdg-open"
alias more="less"
alias ag="ag --pager 'less'"
alias -g G="| grep -i"
alias -g L="| less"
alias -g TL="| tail -20"
alias -g NUL=">/dev/null 2>&1"
alias -g ERRNUL="2>/dev/null"

alias h="history"
alias H="history | grep -i"

## k is the new ls
alias k='k -h'
alias l='k -h'
alias ll='k -h'
alias la='k -Ah'
#sorted by date,recursive,show type,human readable
alias lr='ls -tRFh --color=always'


# FASD
#eual "$(fasd --init auto)"
#alias c='fasd_cd -d'
# f for files
# a for dirs and files
# c for dirs
# open everything
#alias e='f -e ec' # quick opening files with emacs
#alias o='a -e xdg-open' # quick opening files with xdg-open

# WEB DEV
alias serve='python -m SimpleHTTPServer 8000'

alias cd..="cd .." # I often make this mistake
