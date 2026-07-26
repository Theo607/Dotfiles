#!/usr/bin/env python3
"""
Dotfiles Cheatsheet & Interactive Help
Displays all custom shell aliases, helper functions, and desktop keybindings.
"""

import sys
import os
import subprocess
import argparse

# ANSI Styling
BOLD = "\033[1m"
RESET = "\033[0m"
CYAN = "\033[36m"
GREEN = "\033[32m"
YELLOW = "\033[33m"
MAGENTA = "\033[35m"
BLUE = "\033[34m"
DIM = "\033[2m"

CHEATSHEET = [
    {
        "category": "🐚 Modern CLI Tools & Replacements",
        "color": GREEN,
        "items": [
            ("ls", "eza --icons", "List files with icons & directory grouping"),
            ("l", "eza -lh --git", "Detailed list with file sizes & git status"),
            ("la", "eza -lha --git", "List all hidden files and permissions"),
            ("tree", "eza --tree", "Tree view of files and directories"),
            ("cat", "bat", "View file with syntax highlighting & line numbers"),
            ("find", "fd", "Fast, user-friendly file finder"),
            ("top", "btop", "Resource monitor with graph UI"),
            ("ff", "fastfetch", "Display system hardware & software summary"),
            ("lg", "lazygit", "Terminal UI for Git workflows"),
            ("blue", "bluetuith", "Bluetooth device manager TUI"),
            ("wifi", "nmtui", "Network & Wi-Fi manager TUI"),
        ]
    },
    {
        "category": "🔍 Interactive Shell Functions",
        "color": CYAN,
        "items": [
            ("nvf", "fzf + bat + nvim", "Fuzzy search files with live preview & open in Neovim"),
            ("nvr", "rg + fzf + nvim", "Ripgrep search code strings & open at exact line number"),
            ("y", "yazi cwd wrapper", "Launch Yazi file manager & auto-cd to directory on exit"),
            ("zi", "zoxide query -i", "Interactive directory jump using fuzzy search history"),
            ("zj", "zellij a -c", "Attach or create a persistent Zellij multiplexer session"),
            ("walltheme", "theme_generator.py", "Extract palette from image & apply dynamic colors across apps"),
            ("ush", "source ~/.bashrc", "Reload bash configuration instantly"),
        ]
    },
    {
        "category": "🪟 Niri Window Manager Keybindings",
        "color": MAGENTA,
        "items": [
            ("Mod + T", "Ghostty", "Open terminal emulator"),
            ("Mod + Shift + T", "Floating Terminal", "Toggle floating scratchpad terminal (preserves context)"),
            ("Mod + D", "Rofi", "Application launcher"),
            ("Mod + W", "Wallpaper Picker", "Select wallpaper & generate dynamic theme"),
            ("Mod + V", "Cliphist + Rofi", "Open persistent clipboard history menu"),
            ("Mod + Shift + P", "Powermenu", "Shutdown / Reboot / Lock screen menu"),
            ("Mod + Shift + S", "Screenshot", "Interactive area screenshot tool (Satty)"),
            ("Mod + L", "Swaylock", "Lock screen immediately"),
            ("Mod + Q", "Close Window", "Close focused window"),
            ("Mod + Tab", "Overview", "Toggle workspace overview grid"),
            ("Mod + C", "Center Column", "Center current window column"),
            ("Mod + 1..9", "Workspaces", "Switch to workspace 1 through 9"),
            ("Mod + Shift + 1..9", "Move Window", "Move current window to workspace 1..9"),
        ]
    },
    {
        "category": "🤖 AI & Antigravity Helpers",
        "color": YELLOW,
        "items": [
            ("tokens", "check_tokens.py", "Check total token consumption & estimated GCP billing"),
            ("dots-help", "dots_help.py", "Show this interactive dotfiles cheatsheet"),
        ]
    },
    {
        "category": "🐙 Git Quick Shortcuts",
        "color": BLUE,
        "items": [
            ("ga", "git add", "Stage files for commit"),
            ("gcm", 'git commit -m ""', "Commit with message"),
            ("gp", "git push", "Push commits to remote"),
            ("gpo", "git push origin", "Push to origin remote"),
        ]
    }
]

def format_row(cmd, val, desc, color):
    return f"  {BOLD}{color}{cmd:<18}{RESET} {DIM}→{RESET} {val:<24} {DIM}# {desc}{RESET}"

def print_all(query=None):
    print(f"\n{BOLD}{CYAN}==================================================================={RESET}")
    print(f"{BOLD}{CYAN}                 Dotfiles & System Cheatsheet                      {RESET}")
    print(f"{BOLD}{CYAN}==================================================================={RESET}\n")

    found_any = False
    for group in CHEATSHEET:
        cat_name = group["category"]
        color = group["color"]
        items = group["items"]

        if query:
            filtered_items = [
                i for i in items
                if query.lower() in cat_name.lower()
                or query.lower() in i[0].lower()
                or query.lower() in i[1].lower()
                or query.lower() in i[2].lower()
            ]
        else:
            filtered_items = items

        if not filtered_items:
            continue

        found_any = True
        print(f"{BOLD}{color}{cat_name}{RESET}")
        print(f"{DIM}{'-' * 67}{RESET}")
        for cmd, val, desc in filtered_items:
            print(format_row(cmd, val, desc, color))
        print()

    if query and not found_any:
        print(f"{YELLOW}No match found for '{query}'. Try running 'dots-help' without arguments.{RESET}\n")

def run_fzf():
    lines = []
    for group in CHEATSHEET:
        cat = group["category"]
        for cmd, val, desc in group["items"]:
            lines.append(f"{cat:<35} | {cmd:<16} | {val:<22} | {desc}")
    
    input_str = "\n".join(lines)
    try:
        proc = subprocess.run(
            ["fzf", "--header=Dotfiles Cheatsheet (Press ESC to exit)", "--delimiter=|", "--preview-window=down:30%"],
            input=input_str, text=True, capture_output=True
        )
        if proc.stdout.strip():
            print(f"\n{BOLD}Selected:{RESET} {proc.stdout.strip()}")
    except FileNotFoundError:
        print_all()

def main():
    parser = argparse.ArgumentParser(description="Dotfiles & System Cheatsheet Help")
    parser.add_argument("query", nargs="?", default=None, help="Filter search term (e.g., 'git', 'niri', 'nvf')")
    parser.add_argument("-i", "--fzf", action="store_true", help="Launch in interactive fzf filter mode")
    args = parser.parse_args()

    if args.fzf:
        run_fzf()
    else:
        print_all(args.query)

if __name__ == "__main__":
    main()
