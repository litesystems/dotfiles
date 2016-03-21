# Aliases

alias df='df -h'
alias tmux='tmux -2'

if _command_exists stack; then
  alias ghc='stack ghc --'
  alias ghci='stack ghci --'
  alias runghc='stack runghc --'
  alias runhaskell='stack runhaskell --'
fi

alias generate-django-secret-key="python -c \"import random; print(''.join(random.SystemRandom().choice('abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)') for i in range(50)))\""
alias http-server="python2 -m SimpleHTTPServer"

# Suffix aliases

alias -s js=node
alias -s py=python
alias -s txt=cat

# 各種圧縮ファイルの解凍
function _extract() {
  case $1 in
    *tar.bz|*.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz) tar xJvf $1;;
    *.tar.Z|*.taz) tar xzvf $1;;
    *.arj) unarj $1;;
    *.bz2) bzip2 -dc $1;;
    *.gz) gzip -dc $1;;
    *.lzh) lha e $1;;
    *.rar) unrar x $1;;
    *.tar) tar xvf $1;;
    *.xz) xz -dv $1;;
    *.Z) uncompress $1;;
    *.zip) unzip $1;;
  esac
}
alias -s {arz,bz2,gz,lzh,rar,tar,tbz,tgz,xz,Z,zip}=_extract

if [ $uname = 'Darwin' ]; then
  _load_library $ZDOTDIR/aliases_darwin.zsh
elif [ $uname = 'Linux' ]; then
  _load_library $ZDOTDIR/aliases_linux.zsh
fi
