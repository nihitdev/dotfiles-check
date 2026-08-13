# dotfiles-check

A tiny terminal environment checker for shells, CLI tools, developer tools, and common dotfiles variables.

No installation.

No dependencies beyond a POSIX-ish shell and standard system utilities.

## Quick Test

Run directly:

```sh
curl -fsSL https://raw.githubusercontent.com/nihitdev/dotfiles-check/main/dotcheck.sh | bash
```

Or inspect the script first:

```sh
curl -fsSL https://raw.githubusercontent.com/nihitdev/dotfiles-check/main/dotcheck.sh
```

## What Does "Current Shell" Mean?

`dotfiles-check` distinguishes between your configured login shell and the shell actually running the checker.

For example:

```text
Login shell: /usr/bin/fish
Running:     fish
```

If you run the zero-install command:

```sh
curl -fsSL https://raw.githubusercontent.com/nihitdev/dotfiles-check/main/dotcheck.sh | bash
```

the script is executed by Bash, so you may see:

```text
Login shell: /usr/bin/fish
Running:     bash
```

That is expected.


## Clone

```sh
git clone https://github.com/nihitdev/dotfiles-check.git
cd dotfiles-check
```

Then:

```sh
./dotcheck.sh
```

## What It Checks

### Shell

Checks for common shells and shell tools:

```text
fish
zsh
bash
starship
zoxide
```

### CLI

Checks for modern terminal tools:

```text
bat
eza
ripgrep
fd
fzf
jq
fastfetch
```

### Development

Checks for common development tools:

```text
git
gh
cargo
rustc
go
node
npm
deno
python
docker
```

### Environment

Checks useful environment variables such as:

```text
SHELL
EDITOR
VISUAL
TERM
COLORTERM
```

## Example

```text
dotfiles-check
────────────────────────────────────────

Shell
  ✓ Fish
  ✓ Zsh
  ✓ Bash
  ✓ Starship
  ✓ zoxide

CLI
  ✓ bat
  ✓ eza
  ✓ ripgrep
  ✓ fd
  ✓ fzf

Development
  ✓ Git
  ✓ GitHub CLI
  ✓ Rust
  ✓ Cargo
  ✓ Go
  ✓ Node.js
  ✗ Docker

────────────────────────────────────────
Result: 16/17 checks passed
```

A missing tool does not mean your setup is broken.

The goal is to show what is available, not tell you what you must install.

## Structure

```text
dotfiles-check/
├── README.md
├── LICENSE
├── dotcheck.sh
└── checks/
    ├── commands.sh
    ├── environment.sh
    └── shell.sh
```

## Philosophy

Your dotfiles should be understandable.

This project intentionally avoids:

- automatic package installation
- modifying shell configuration
- changing system settings
- requiring root
- Giant setup frameworks

It checks.

You decide.

## Related

- [arch-after-install](https://github.com/nihitdev/arch-after-install)
- [shell-snippets](https://github.com/nihitdev/shell-snippets)
- [starship-presets](https://github.com/nihitdev/starship-presets)
- [linux-one-liners](https://github.com/nihitdev/linux-one-liners)

## License

MIT
