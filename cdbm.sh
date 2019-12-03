#!/bin/bash

BKMRK_FILE=$HOME/.bkmrks

cdbm() {
    if [[ -f $BKMRK_FILE ]]; then
        local loc
        if [[ $# == 0 ]]; then
            loc=$(head -n1 $BKMRK_FILE)
        else
            loc=$(cat $BKMRK_FILE | grep "$1:" | cut -d ":" -f 2)
        fi
        cd $loc
        echo "cd $loc"
    else
        cd
        echo "$HOME" > $BKMRK_FILE
    fi
}

bm() {
    local PARAM=""
    local REMOVE=0

    while (( "$#" )); do
        case "$1" in
            -r|-rm|--remove)
                REMOVE=1
                shift
                ;;
            -p|--print)
                cat <(printf "TEMP_BKMRK:") ~/.bkmrks | column -t -s ":"
                return
                shift
                ;;
            -*|--*=) # unsupported flags
                echo "Error: Unsupported flag $1" >&2
                return
                ;;
            *) # preserve positional arguments
                PARAM="$1"
                shift
                ;;
        esac
    done

    if [[ $REMOVE == 1 ]]; then
        sed -i "\|$PARAM:.*|d" $BKMRK_FILE
        echo "Removed $PARAM bookmark"
    else
        if [[ "$PARAM" == "" ]]; then
            sed -i "1s|.*|$(pwd)|" $BKMRK_FILE
            echo "Set $(pwd) to temporary bookmark"
        else
            if (grep "$PARAM:" $BKMRK_FILE >/dev/null 2>/dev/null); then
                sed -i "s|$PARAM:.*|$PARAM:$(pwd)|" $BKMRK_FILE
                echo "Overwrote $PARAM ($(pwd))"
            else
                echo "$PARAM:$(pwd)" >> $BKMRK_FILE
                echo "Added $PARAM ($(pwd)) to list of bookmarks"
            fi
        fi
    fi
}

_cdbm_autocomplete() {
    if [[ "${#COMP_WORDS[@]}" != "2" ]]; then
        return
    fi
    local words=$(tail -n +2 $BKMRK_FILE | cut -d ":" -f1 | tr "\n" " ")
    COMPREPLY=($(compgen -W "$words" "${COMP_WORDS[1]}"))
}


complete -F _cdbm_autocomplete cdbm
complete -F _cdbm_autocomplete bm
