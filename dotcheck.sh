#!/usr/bin/env bash

set -u

TOTAL=0
PASSED=0

check_command() {
    local command_name="$1"
    local display_name="${2:-$1}"

    TOTAL=$((TOTAL + 1))

    if command -v "$command_name" >/dev/null 2>&1; then
        printf "  ✓  %-18s installed\n" "$display_name"
        PASSED=$((PASSED + 1))
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
