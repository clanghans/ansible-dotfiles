
# emacs client
function ec () {
    emacsclient -n -c -a "" $@
}

# reload zsh/shell configuration
function reload () {
    source ~/.zshrc
    source ~/.zshenv
}

# create directory [if necessary] and jump into it
function mcd () {
    if [[ "$#" -gt 1 ]] ;then
        echo "$0: too many arguments"
        return 1
    fi
    mkdir -p $1
    cd $1
}

# Jump to workspace directory
function w () {
    mcd ~/Workspace
}

# calc hashsums of the most common hashalgorithms
function hashsum () {
    for file in "$@"
    do
        if [ -f $file ] ;then
            echo "$file"
            echo "MD5: $(md5sum "$file")"
            echo "SHA1: $(sha1sum "$file")"
            echo "SHA256: $(sha256sum "$file")"
            echo "SHA512: $(sha512sum "$file")"
            echo ""
        fi
    done
}

# Recursive file search. ENTER opens $EDITOR
ff() {
    local out file key
    IFS=$'\n' out=($(fzf --exact --query="$1" --exit-0))
    key=$(head -1 <<< "$out")
    file=$(head -2 <<< "$out" | tail -1)
    if [ -n "$file" ]; then
        ${EDITOR:-vim} "$file"
    fi
}

# fd - cd to selected directory
ffd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
               -o -type d -print 2> /dev/null | fzf +m) &&
        cd "$dir"
}

# fda - including hidden directories
ffda() {
    local dir
    dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fh - repeat history
fh() {
    eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# fuzzy grep open via ag with line number
vg() {
    local file
    local line

    read -d ":" -r file line <<<"$(ag --nobreak --noheading $@ | fzf -e -0 -1 | awk -F: '{print $1, $2}')"

    echo "FILENAME: $file"
    echo "LINE: $line"
    if [[ -n $file ]]
    then
        ec +$line $file
    fi
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(git branch --all | grep -v HEAD             |
                 sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
                 sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$((echo "$tags"; echo "$branches") |
               fzf --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
fcoc() {
    local commits commit
    commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
        commit=$(echo "$commits" | fzf --tac +s +m -e) &&
        git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
        fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
            --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
                FZF-EOF"
}

# Compress pdf files with ghostscript
pdfcompress()
{
    # this function uses 2 arguments:
    #     $1 input file name
    #     $2 output file name
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen \
       -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${2} ${1}
}

# Extract ranged pdf pages with ghostscript
pdfpextr()
{
    # this function uses 3 arguments:
    #     $1 is the first page of the range to extract
    #     $2 is the last page of the range to extract
    #     $3 is the input file
    #     output file will be named "inputfile_pXX-pYY.pdf"
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
       -dFirstPage=${1} \
       -dLastPage=${2} \
       -sOutputFile=${3%.pdf}_p${1}-p${2}.pdf \
       ${3}
}
