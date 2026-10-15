#!/usr/bin/env bash
# Links the configs in this repo into $HOME.
#   config/<name>   ->  ~/.config/<name>
#   .zshrc, .vimrc  ->  ~/.zshrc, ~/.vimrc
# Existing files/dirs that are not already the right link are moved to <name>.bak-<timestamp>.
# Usage: ./install.sh [-n]   (-n = dry run, only print what would happen)

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
STAMP="$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0
[[ "${1:-}" == "-n" ]] && DRY_RUN=1

run() {
    if (( DRY_RUN )); then
        echo "  [dry-run] $*"
    else
        "$@"
    fi
}

link() {
    local src="$1" dst="$2"

    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        echo "ok      $dst"
        return
    fi

    if [[ -e "$dst" || -L "$dst" ]]; then
        echo "backup  $dst -> $dst.bak-$STAMP"
        run mv "$dst" "$dst.bak-$STAMP"
    fi

    echo "link    $dst -> $src"
    run ln -s "$src" "$dst"
}

run mkdir -p "$CONFIG_DIR"

for src in "$REPO"/config/*; do
    link "$src" "$CONFIG_DIR/$(basename "$src")"
done

for f in .zshrc .vimrc; do
    link "$REPO/$f" "$HOME/$f"
done
