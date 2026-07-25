#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define color codes for pretty output
GREEN='\030[0;32m'
BLUE='\030[0;34m'
YELLOW='\030[1;33m'
RED='\030[0;31m'
NC='\030[0m' # No Color

# Determine script and repository directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_DIR="$SCRIPT_DIR"

echo -e "${BLUE}===========================================${NC}"
echo -e "${BLUE}        Theo's Dotfiles Installer          ${NC}"
echo -e "${BLUE}===========================================${NC}\n"

# Helper function to create symlinks safely
create_symlink() {
    local src="$1"
    local target="$2"

    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ] && [ "$(readlink -f "$target")" = "$(readlink -f "$src")" ]; then
            echo -e "${GREEN}[OK]${NC} Symlink already exists: $target -> $src"
            return
        fi
        
        # Backup existing file/directory
        local backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
        echo -e "${YELLOW}[BACKUP]${NC} Target $target already exists. Backing up to $backup"
        mv "$target" "$backup"
    fi

    # Ensure parent directory exists
    mkdir -p "$(dirname "$target")"
    ln -s "$src" "$target"
    echo -e "${GREEN}[LINKED]${NC} $target -> $src"
}

# Ensure essential local directories exist
echo -e "${BLUE}Creating required directories...${NC}"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"

# Symlink .config items
echo -e "\n${BLUE}Symlinking config files (~/.config)...${NC}"
CONFIG_DIR="$DOTFILES_DIR/.config"

if [ -d "$CONFIG_DIR" ]; then
    for item in "$CONFIG_DIR"/* "$CONFIG_DIR"/.*; do
        # Ignore '.' and '..'
        basename_item="$(basename "$item")"
        if [ "$basename_item" = "." ] || [ "$basename_item" = ".." ]; then
            continue
        fi

        if [ -e "$item" ]; then
            create_symlink "$item" "$HOME/.config/$basename_item"
        fi
    done
fi

# Symlink custom helper scripts into ~/.local/bin
echo -e "\n${BLUE}Symlinking helper scripts (~/.local/bin)...${NC}"

if [ -f "$DOTFILES_DIR/dots_help.py" ]; then
    chmod +x "$DOTFILES_DIR/dots_help.py"
    create_symlink "$DOTFILES_DIR/dots_help.py" "$HOME/.local/bin/dots-help"
fi

if [ -f "$DOTFILES_DIR/check_tokens.py" ]; then
    chmod +x "$DOTFILES_DIR/check_tokens.py"
    create_symlink "$DOTFILES_DIR/check_tokens.py" "$HOME/.local/bin/tokens"
fi

if [ -f "$DOTFILES_DIR/scripts/theme_generator.py" ]; then
    chmod +x "$DOTFILES_DIR/scripts/theme_generator.py"
    create_symlink "$DOTFILES_DIR/scripts/theme_generator.py" "$HOME/.local/bin/walltheme"
fi

# Append or setup bashrc sourcing
echo -e "\n${BLUE}Setting up shell configuration (~/.bashrc)...${NC}"
BASHRC_TARGET="$HOME/.bashrc"
BASHRC_SOURCE="$DOTFILES_DIR/.bashrc"

BASHRC_LINE="[ -f \"$BASHRC_SOURCE\" ] && source \"$BASHRC_SOURCE\""

if [ -f "$BASHRC_TARGET" ]; then
    if grep -Fq "$BASHRC_SOURCE" "$BASHRC_TARGET"; then
        echo -e "${GREEN}[OK]${NC} ~/.bashrc already sources $BASHRC_SOURCE"
    else
        echo -e "${YELLOW}[UPDATE]${NC} Adding source line to ~/.bashrc"
        echo -e "\n# Theo's Dotfiles configuration" >> "$BASHRC_TARGET"
        echo "$BASHRC_LINE" >> "$BASHRC_TARGET"
    fi
else
    echo -e "${YELLOW}[CREATE]${NC} Creating ~/.bashrc with dotfiles source line"
    echo "# Theo's Dotfiles configuration" > "$BASHRC_TARGET"
    echo "$BASHRC_LINE" >> "$BASHRC_TARGET"
fi

echo -e "\n${GREEN}===========================================${NC}"
echo -e "${GREEN}      Installation complete! 🎉            ${NC}"
echo -e "${GREEN}===========================================${NC}"
echo -e "Restart your shell or run: ${BLUE}source ~/.bashrc${NC}\n"
