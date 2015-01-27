# .zshrc
#
# Copyright (c) 2012-2015, Yusuke Miyazaki.

# Profiling
#zmodload zsh/zprof && zprof

# ----- Helper -----

local uname=`uname`

function command_exists() {
    command -v "$1" &> /dev/null
}

function add_path_if_exists() {
    if [ -d "$1" ]; then
        export PATH="$1:$PATH"
    fi
}

# ----- / Helper -----

# ----- Environment variables -----

# PATH
# Homebrew
if [ $uname = 'Darwin' ]; then
    add_path_if_exists /usr/local/bin
fi
if command_exists brew; then
    export HOMEBREW_VERBOSE=true
fi
# Linux CUDA
add_path_if_exists /usr/local/cuda/bin
if [ -d /usr/local/cuda/lib64 ]; then
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
fi
# Go
if [ -d ~/Development/Go ]; then
    export GOPATH=~/Development/Go
fi
# Home
add_path_if_exists $HOME/.local/bin
if [ -d $HOME/.local/lib ]; then
    export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
fi

# Node Version Manager
# OS X (Homebrew)
if [ $uname = 'Darwin' ] && [ $(brew --prefix nvm)/nvm.sh ]; then
    export NVM_DIR=~/.nvm
    # Lazy
    nvm() {
        unset -f nvm
        source $(brew --prefix nvm)/nvm.sh
        nvm "$@"
    }
fi
# Linux
if [ $uname = 'Linux' ] && [ -e "${HOME}/.nvm/nvm.sh" ]; then
    # Lazy
    nvm() {
        unset -f nvm
        source ~/.nvm/nvm.sh
        nvm "$@"
    }
fi

# virtualenvwrapper
if command_exists virtualenvwrapper.sh; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Development
    source virtualenvwrapper.sh
fi

# Google Cloud SDK
if [ -e ~/Development/google-cloud-sdk/path.zsh.inc ]; then
    source ~/Development/google-cloud-sdk/path.zsh.inc
fi

# OPAM configuration
if [ -e ~/.opam/opam-init/init.zsh ]; then
    . ~/.opam/opam-init/init.zsh &> /dev/null || true
fi

# Auto completion
# Homebrew の site-functions を追加
if [ -d /usr/local/share/zsh/site-functions ]; then
    fpath=(/usr/local/share/zsh/site-functions $fpath)
fi
if [ -d /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# ls コマンドの色分け設定
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# ----- / Environment variables -----

# Remove path duplications
typeset -U path cdpath fpath manpath
typeset -T LD_LIBRARY_PATH ld_library_path
typeset -U ld_library_path

# ls コマンドの色分け設定
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

# cd コマンドなしでディレクトリを移動する
setopt auto_cd

# ディレクトリスタックに自動で push する
# cd -<TAB> でスタックのリストを確認できる
setopt auto_pushd

# Auto completion
autoload -Uz compinit
compinit

# コマンドのオートコレクション
# オートコレクションを実行してほしくないときは
# nocorrect <command> とする
setopt correct

# リストを詰めて表示
setopt list_packed

# ビープ音を鳴らさない
setopt nobeep
setopt nolistbeep

# 末尾の / を自動的に削除しない
setopt noautoremoveslash

# Vi キーバインド
bindkey -v

# 標準のキーバインドだと, 履歴を見る際にカーソルが先頭に移動する挙動を修正
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history

# Incremental history search
bindkey '^R' history-incremental-search-backward

function load_library() {
    local lib
    lib=$1
    if [ -f $lib ]; then
        . $lib
    fi
}

load_library $ZDOTDIR/aliases.zsh
load_library $ZDOTDIR/completion.zsh
load_library $ZDOTDIR/history.zsh
load_library $ZDOTDIR/prompt.zsh
load_library $ZDOTDIR/rprompt.zsh
load_library $ZDOTDIR/peco.zsh
load_library $ZDOTDIR/tmux.zsh

# Profiling
#if (which zprof > /dev/null) ;then
#  zprof | less
#fi
