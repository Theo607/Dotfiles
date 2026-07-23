# Theo's Dotfiles

A sleek, modern, dynamic Wayland desktop environment powered by **Niri** (scrollable tiling compositor) with a real-time, wallpaper-driven theme engine.

![Niri Wayland Desktop](https://img.shields.org/badge/Wayland-Niri-purple?style=flat-square)
![Terminal](https://img.shields.org/badge/Terminal-Ghostty-black?style=flat-square)
![Multiplexer](https://img.shields.org/badge/Multiplexer-Zellij-orange?style=flat-square)
![Editor](https://img.shields.org/badge/Editor-Neovim-green?style=flat-square)

---

## Overview & Highlights

- **Scrollable Tiling Compositor**: Smooth, modern Wayland experience powered by **Niri**.
- **Dynamic Real-Time Theming**: Press `Mod + W` to pick any wallpaper. An automated Python theme generator extracts the dominant palette and updates colors across **all desktop components instantly** without restarting sessions:
  -  **Swaybg**: Sets the background wallpaper.
  -  **Waybar**: Updates CSS color variables (`colors.css`) and reloads instantly.
  -  **Rofi**: Dynamically updates launcher styles, clipboard menu, and power menu.
  -  **Ghostty**: Updates terminal color theme configuration on the fly.
  -  **Zellij**: Hot-reloads terminal multiplexer colors live in active sessions.
  -  **Neovim**: Updates color scheme configuration in `init.lua` / `colors.lua`.
  -  **Starship**: Dynamically sets prompt color accents.
  -  **Niri**: Updates window focus ring and active border colors.
  -  **Mako**: Updates notification popups with matching accent borders.
- **Modern CLI Stack**: `eza`, `bat`, `fd`, `btop`, `fastfetch`, `lazygit`, `bluetuith`, `nmtui`, `zoxide`, and `yazi`.
- **Interactive Cheatsheet**: Run `dots-help` in any terminal (or `dots-help -i` for interactive `fzf` search) to view all aliases, keybindings, and system shortcuts.

---

## Desktop Keybindings (Niri)

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `Mod + T` | Terminal | Launch **Ghostty** terminal emulator |
| `Mod + Shift + T` | Scratchpad | Open floating scratchpad Ghostty terminal |
| `Mod + D` | Launcher | Launch **Rofi** application menu |
| `Mod + W` | Wallpaper Picker | Select wallpaper & auto-generate dynamic theme |
| `Mod + V` | Clipboard History | Open **Cliphist** clipboard history menu |
| `Mod + Shift + P` | Power Menu | Shutdown / Reboot / Lock screen menu |
| `Mod + Shift + S` | Screenshot | Interactive screen selection screenshot (**Satty**) |
| `Mod + L` | Lock Screen | Lock session immediately (**Swaylock**) |
| `Mod + Q` | Close Window | Close focused window |
| `Mod + Tab` | Workspace Overview | Toggle workspace grid overview |
| `Mod + C` | Center Column | Center current window column |
| `Mod + 1..9` | Switch Workspace | Switch to workspace 1 through 9 |
| `Mod + Shift + 1..9` | Move Window | Move current window to workspace 1..9 |

---

##  Dynamic Theme Engine (`walltheme`)

The heart of this configuration is `scripts/theme_generator.py` triggered by `walltheme <image_path>` or through the Rofi Wallpaper Picker (`Mod + W`).

### How It Works
1. **Palette Extraction**: Quantizes colors from the selected wallpaper into primary background, foreground, accents, and 16-color ANSI terminal palettes.
2. **Template Interpolation**: Re-writes config files across the system with matching color variables.
3. **Live Signal Propagation**: Sends IPC / SIGUSR signals and updates watched config files so running applications (Waybar, Zellij, Niri, Ghostty, Mako) update their visual appearance in real time.

---

##  Shell & CLI Enhancements

This repository replaces legacy shell utilities with modern Rust/C++ alternatives:

- `ls` / `la` / `tree` → **`eza`** with icons and git integration
- `cat` → **`bat`** with syntax highlighting and line numbers
- `find` → **`fd`** fast file finder
- `top` → **`btop`** graphical resource monitor
- `cd` → **`zoxide`** (`z` / `zi`) directory jumping
- File Manager → **`yazi`** (`y`) with directory syncing on exit
- Terminal Multiplexer → **`zellij`** (`zj`)
- Git TUI → **`lazygit`** (`lg`)
- Bluetooth TUI → **`bluetuith`** (`blue`)
- Wi-Fi TUI → **`nmtui`** (`wifi`)

---

##  System Utilities

- **`dots-help`** (`dots_help.py`): Interactive CLI cheatsheet. Run `dots-help` or `dots-help -i` to filter shortcuts interactively with `fzf`.
- **`tokens`** (`check_tokens.py`): AI token consumption and GCP estimated usage monitor.

---

##  Repository Structure

```
Dotfiles/
├── .bashrc                 # Custom aliases, env vars, and shell functions
├── .config/
│   ├── ghostty/           # Ghostty terminal emulator configuration
│   ├── mako/              # Mako notification daemon config
│   ├── niri/              # Niri Wayland compositor config (config.kdl)
│   ├── nvim/              # Neovim (LazyVim) setup
│   ├── rofi/              # Rofi launchers, wallpaper picker, clipboard, powermenu
│   ├── starship.toml      # Starship prompt configuration
│   ├── waybar/            # Waybar bar layout, styles, weather & Wi-Fi scripts
│   ├── yazi/              # Yazi file manager configuration
│   └── zellij/            # Zellij terminal multiplexer config & dynamic theme
├── scripts/
│   └── theme_generator.py # Python wallpaper palette extractor & theme generator
├── Wallpapers/             # Curated wallpaper gallery
├── dots_help.py            # Interactive cheatsheet CLI
└── check_tokens.py         # AI usage & token tracking utility
```

---

##  Setup & Symlinking

Configs are symlinked into `~/.config/`:

```bash
ln -s ~/Dotfiles/.config/niri ~/.config/niri
ln -s ~/Dotfiles/.config/waybar ~/.config/waybar
ln -s ~/Dotfiles/.config/rofi ~/.config/rofi
ln -s ~/Dotfiles/.config/ghostty ~/.config/ghostty
ln -s ~/Dotfiles/.config/zellij ~/.config/zellij
ln -s ~/Dotfiles/.config/mako ~/.config/mako
ln -s ~/Dotfiles/.config/nvim ~/.config/nvim
ln -s ~/Dotfiles/.config/yazi ~/.config/yazi
ln -s ~/Dotfiles/.config/starship.toml ~/.config/starship.toml
```
