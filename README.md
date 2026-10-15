# my-configs

## Deps

### Sway (Wayland)
- sway
- waybar
- swaylock
- swayidle
- mako

### Common
- kitty
- rofi
- ranger
- neofetch
- zsh
- vim
- light, pactl, playerctl
- Fonts: Font Awesome, Symbols Nerd Font

## Installation
```sh
git clone <repo-url> ~/my-configs
cd ~/my-configs
./install.sh -n   # dry run: shows what would be linked
./install.sh
```

`install.sh` symlinks every folder in `config/` to `~/.config/` and `.zshrc`/`.vimrc` to `~/`.
Existing files are moved to `<name>.bak-<timestamp>`.

Because the configs are symlinks, `git pull` updates them directly.
Only re-run `./install.sh` when a new folder is added to `config/`.
