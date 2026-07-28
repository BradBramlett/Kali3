#!/bin/bash

# Get entry directory for where to save logs
if [[ "$PWD" == *"Temp"* ]] || [[ "$PWD" == *"Loot"* ]]; then
    LOG_DIR=$(echo "$PWD" | sed -e 's/Temp/Logs/' -e 's/Loot/Logs/')
else
    LOG_DIR="$PWD/Logs"
fi

if [[ ! -d "$LOG_DIR" ]]; then
    mkdir -p "$LOG_DIR"
fi

increment(){
    shopt -s nullglob

    for i in "$LOG_DIR"/tmux.log.*
    do
        CUR=$(echo "$i" | awk -F '.' '{print $NF}')
        NEXT=$((CUR+1))

        echo -e "moving \033[96m${i}\033[0m to \033[92m${LOG_DIR}/tmux.log.${NEXT}\033[0m"

        mv "$i" "$LOG_DIR/tmux.log.$NEXT"
    done

    shopt -u nullglob

    if [[ -f "$LOG_DIR/tmux.log" ]]; then
        mv "$LOG_DIR/tmux.log" "$LOG_DIR/tmux.log.1"
    fi
}

# Start Banner for log parsing later on
echo '==================== Session Start ======================'

# Run the real shell
bash

# End banner
echo '==================== Session End ======================'

# When shell exits (Ctrl+D or exit), show message
read -p 'Would you like to save terminal output? [y/N]: ' ANS

if [[ ${ANS^^} == 'Y' ]]; then

    printf "Logs will be saved at \033[96m%s/tmux.log\033[0m... Is this correct? [Y/n]: " "$LOG_DIR"
    read SAVE_PATH

    if [[ ${SAVE_PATH^^} == 'N' ]]; then
        read -p "Full path to log directory: " LOG_DIR

        if [[ ! -d "$LOG_DIR" ]]; then
            mkdir -p "$LOG_DIR"
        fi
    fi

    increment

    tmux capture-pane -p -S - -e | \
        sed '/Would you like to save terminal output? \[y\/N\]:/d' \
        > "$LOG_DIR/tmux.log"

    exit
else
    exit
fi
