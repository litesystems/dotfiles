if _command_exists peco; then
    function peco-select-history() {
        local tac
        if _command_exists tac; then
            tac="tac"
        else
            tac="tail -r"
        fi
        BUFFER=$(\history -n 1 | eval $tac | awk '!a[$0]++' | peco --query "$LBUFFER")
        CURSOR=$#BUFFER
    }
    zle -N peco-select-history
    bindkey '^R' peco-select-history
fi
