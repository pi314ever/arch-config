# Overwrite ls with eza
unalias ls 2>/dev/null
ls() {
    if command -v eza &>/dev/null; then
        DEFAULT_EZA_ARGS="-F --icons --group-directories-first"
        eza $DEFAULT_EZA_ARGS "$@"
    else
        echo "eza not found, using default ls"
        command ls "$@"
    fi
}

# Overwrite cat with bat
unalias cat 2>/dev/null
cat() {
    if command -v bat &>/dev/null; then
        bat "$@"
    else
        echo "bat not found, using default cat"
        command cat "$@"
    fi
}

# Custom cdh to workspace directory, else home
unalias cdh 2>/dev/null
cdh() {
    if [[ -n $ZSH_INIT_CDH_ALIAS ]]; then
        cd "${ZSH_INIT_CDH_ALIAS//[\'\"]*/}"
    elif [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true"]; then
        cd "$(git rev-parse --show-toplevel)"
    else
        cd
    fi
}
