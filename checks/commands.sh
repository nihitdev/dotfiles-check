#!/usr/bin/env bash

# Reusable command detection helpers.

check_command() {
    local command_name="$1"
    local display_name="${2:-$1}"

    if command -v "$command_name" >/dev/null 2>&1; then
        printf "  ✓  %-18s installed\n" "$display_name"
        return 0
    else
        printf "  ✗  %-18s missing\n" "$display_name"
        return 1
    fi
}

check_shell_tools() {
    echo "Shell"

    check_command fish "Fish"
    check_command zsh "Zsh"
    check_command bash "Bash"
    check_command starship "Starship"
    check_command zoxide "zoxide"
}

check_cli_tools() {
    echo "CLI"

    check_command bat "bat"
    check_command eza "eza"
    check_command rg "ripgrep"
    check_command fd "fd"
    check_command fzf "fzf"
    check_command jq "jq"
    check_command fastfetch "Fastfetch"
}

check_development_tools() {
    echo "Development"

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
}
