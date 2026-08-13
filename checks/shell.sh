#!/usr/bin/env bash

check_current_shell() {
    echo "Current Shell"

    printf "  %-14s %s\n" "Login shell:" "${SHELL:-unknown}"

    if [ -n "${BASH_VERSION:-}" ]; then
        printf "  %-14s %s\n" "Running:" "bash"
    elif [ -n "${ZSH_VERSION:-}" ]; then
        printf "  %-14s %s\n" "Running:" "zsh"
    elif [ -n "${FISH_VERSION:-}" ]; then
        printf "  %-14s %s\n" "Running:" "fish"
    else
        current_shell="$(ps -p $$ -o comm= 2>/dev/null | tr -d ' ')"
        printf "  %-14s %s\n" "Running:" "${current_shell:-unknown}"
    fi
}
