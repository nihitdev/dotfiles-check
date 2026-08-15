#!/usr/bin/env bash

set -Eeuo pipefail

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
test_root=$(mktemp -d)
trap 'find "$test_root" -depth -delete' EXIT
export HOME="$test_root/home"
mock_bin="$test_root/bin"
mkdir -p "$HOME" "$mock_bin"

fail() {
    printf 'FAIL: %s\n' "$*" >&2
    exit 1
}

for command_name in bash git rg; do
    printf '#!/usr/bin/env bash\nexit 0\n' >"$mock_bin/$command_name"
    chmod +x "$mock_bin/$command_name"
done

output=$(PATH="$mock_bin" SHELL=/usr/bin/fish EDITOR=nvim TERM=xterm-256color \
    /usr/bin/bash "$repo_root/dotcheck.sh")
[[ $output == *'Bash               installed'* ]] || fail 'installed Bash was not detected'
[[ $output == *'Git                installed'* ]] || fail 'installed Git was not detected'
[[ $output == *'ripgrep            installed'* ]] || fail 'installed ripgrep was not detected'
[[ $output == *'Login shell:   /usr/bin/fish'* ]] || fail 'login shell was not reported'
[[ $output == *'Running:       bash'* ]] || fail 'running shell was not reported'
[[ $output == *'Result: 3/22 command checks passed'* ]] || fail 'summary was incorrect'

output=$(PATH="$mock_bin" /usr/bin/bash "$repo_root/dotcheck.sh" --missing-only)
[[ $output != *'Bash               installed'* ]] || fail '--missing-only showed installed commands'
[[ $output == *'Fish               missing'* ]] || fail '--missing-only omitted missing commands'
[[ $output == *'Result: 3/22 command checks passed'* ]] || fail '--missing-only changed summary'

output=$(PATH="$mock_bin" /usr/bin/bash "$repo_root/dotcheck.sh" --help)
[[ $output == *'Usage: ./dotcheck.sh [OPTION]'* ]] || fail '--help omitted usage'

if PATH="$mock_bin" /usr/bin/bash "$repo_root/dotcheck.sh" --unknown \
    >"$test_root/unknown.out" 2>"$test_root/unknown.err"; then
    fail 'unknown option succeeded'
fi
grep -Fq 'unknown option: --unknown' "$test_root/unknown.err" ||
    fail 'unknown-option error was unclear'

printf 'dotfiles-check tests passed.\n'
