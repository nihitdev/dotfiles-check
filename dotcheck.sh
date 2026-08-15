#!/usr/bin/env bash

set -Eeuo pipefail

TOTAL=0
PASSED=0
MISSING_ONLY=false

usage() {
    printf '%s\n' \
        'Usage: ./dotcheck.sh [OPTION]' \
        '' \
        'Inspect common shell, CLI, development, and environment settings.' \
        '' \
        'Options:' \
        '  --missing-only  Show only commands that are not installed' \
        '  -h, --help      Show this help'
}

if (($# > 1)); then
    printf 'dotcheck: expected at most one option\n' >&2
    usage >&2
    exit 2
fi

if (($# == 1)); then
    case "$1" in
        --missing-only) MISSING_ONLY=true ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            printf 'dotcheck: unknown option: %s\n' "$1" >&2
            usage >&2
            exit 2
            ;;
    esac
fi

check_command() {
    local command_name="$1"
    local display_name="${2:-$1}"

    TOTAL=$((TOTAL + 1))

    if command -v "$command_name" >/dev/null 2>&1; then
        PASSED=$((PASSED + 1))
        if [[ $MISSING_ONLY == false ]]; then
            printf "  ✓  %-18s installed\n" "$display_name"
        fi
    else
        printf "  ✗  %-18s missing\n" "$display_name"
    fi
}

section() {
    echo
    printf '%s\n' "$1"
}

echo
echo "dotfiles-check"
echo "────────────────────────────────────────"

section "Shell"

check_command fish "Fish"
check_command zsh "Zsh"
check_command bash "Bash"
check_command starship "Starship"
check_command zoxide "zoxide"

section "Current Shell"
printf "  %-14s %s\n" "Login shell:" "${SHELL:-unknown}"
printf "  %-14s %s\n" "Running:" "bash"

section "CLI"

check_command bat "bat"
check_command eza "eza"
check_command rg "ripgrep"
check_command fd "fd"
check_command fzf "fzf"
check_command jq "jq"
check_command fastfetch "Fastfetch"

section "Development"

check_command git "Git"
check_command gh "GitHub CLI"
check_command rustc "Rust"
check_command cargo "Cargo"
check_command go "Go"
check_command node "Node.js"
check_command npm "npm"
check_command deno "Deno"
check_command python "Python"
check_command docker "Docker"

section "Environment"

printf "  %-10s %s\n" "SHELL" "${SHELL:-not set}"
printf "  %-10s %s\n" "EDITOR" "${EDITOR:-not set}"
printf "  %-10s %s\n" "VISUAL" "${VISUAL:-not set}"
printf "  %-10s %s\n" "TERM" "${TERM:-not set}"
printf "  %-10s %s\n" "COLORTERM" "${COLORTERM:-not set}"

echo
echo "────────────────────────────────────────"
printf 'Result: %d/%d command checks passed\n' "$PASSED" "$TOTAL"
echo
echo "Missing does not mean required."
echo "Install only what fits your setup."
echo
