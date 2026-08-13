#!/usr/bin/env bash

check_environment() {
    echo "Environment"

    printf "  %-10s %s\n" "SHELL" "${SHELL:-not set}"
    printf "  %-10s %s\n" "EDITOR" "${EDITOR:-not set}"
    printf "  %-10s %s\n" "VISUAL" "${VISUAL:-not set}"
    printf "  %-10s %s\n" "TERM" "${TERM:-not set}"
    printf "  %-10s %s\n" "COLORTERM" "${COLORTERM:-not set}"
}
