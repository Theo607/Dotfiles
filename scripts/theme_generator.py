#!/usr/bin/env python3
import sys
import os
import re
import subprocess
import colorsys
from PIL import Image

def hex_to_rgb(hex_str):
    hex_str = hex_str.lstrip('#')
    return tuple(int(hex_str[i:i+2], 16) for i in (0, 2, 4))

def rgb_to_hex(rgb):
    return '#{:02x}{:02x}{:02x}'.format(
        max(0, min(255, int(rgb[0]))),
        max(0, min(255, int(rgb[1]))),
        max(0, min(255, int(rgb[2])))
    )

def extract_palette(image_path):
    img = Image.open(image_path).convert('RGB')
    img_small = img.resize((150, 150))
    result = img_small.quantize(colors=32, method=Image.Quantize.FASTOCTREE)
    palette_raw = result.getpalette()[:96]
    
    colors_rgb = []
    for i in range(0, len(palette_raw), 3):
        colors_rgb.append((palette_raw[i], palette_raw[i+1], palette_raw[i+2]))
    
    colors_hsv = []
    for r, g, b in colors_rgb:
        h, s, v = colorsys.rgb_to_hsv(r/255.0, g/255.0, b/255.0)
        colors_hsv.append((h, s, v, (r, g, b)))
    
    avg_r = sum(c[0] for c in colors_rgb) / len(colors_rgb)
    avg_g = sum(c[1] for c in colors_rgb) / len(colors_rgb)
    avg_b = sum(c[2] for c in colors_rgb) / len(colors_rgb)
    dom_h, dom_s, _ = colorsys.rgb_to_hsv(avg_r/255.0, avg_g/255.0, avg_b/255.0)
    
    # Soft obsidian-lavender background (Helix hex_lavender inspired: #181a17 / #16141d)
    # Value 0.13, Saturation 0.20 -> comfortable dark charcoal tint, not pitch black
    bg_r, bg_g, bg_b = colorsys.hsv_to_rgb(dom_h, min(dom_s, 0.22), 0.13)
    bg = rgb_to_hex((bg_r*255, bg_g*255, bg_b*255))
    
    bg_alt_r, bg_alt_g, bg_alt_b = colorsys.hsv_to_rgb(dom_h, min(dom_s, 0.22), 0.19)
    bg_alt = rgb_to_hex((bg_alt_r*255, bg_alt_g*255, bg_alt_b*255))
    
    sel_r, sel_g, sel_b = colorsys.hsv_to_rgb(dom_h, min(dom_s, 0.25), 0.28)
    bg_sel = rgb_to_hex((sel_r*255, sel_g*255, sel_b*255))

    # Foreground: Soft mauve/lavender white (#c8c4d6), non-glare and easy on eyes
    fg_r, fg_g, fg_b = colorsys.hsv_to_rgb(dom_h, 0.08, 0.84)
    fg = rgb_to_hex((fg_r*255, fg_g*255, fg_b*255))
    
    fg_muted_r, fg_muted_g, fg_muted_b = colorsys.hsv_to_rgb(dom_h, 0.18, 0.52)
    fg_muted = rgb_to_hex((fg_muted_r*255, fg_muted_g*255, fg_muted_b*255))

    # Accents: Muted, desaturated, non-neony Hex Lavender tones
    vibrant_candidates = sorted(colors_hsv, key=lambda c: c[1] * c[2], reverse=True)
    primary_hsv = vibrant_candidates[0] if vibrant_candidates else (dom_h, 0.4, 0.8, (140, 130, 200))
    p_h, _, _, _ = primary_hsv
    
    accent_r, accent_g, accent_b = colorsys.hsv_to_rgb(p_h, 0.42, 0.82)
    accent = rgb_to_hex((accent_r*255, accent_g*255, accent_b*255))
    
    p2_h = (p_h + 0.15) % 1.0
    accent2_r, accent2_g, accent2_b = colorsys.hsv_to_rgb(p2_h, 0.38, 0.80)
    accent2 = rgb_to_hex((accent2_r*255, accent2_g*255, accent2_b*255))

    border_r, border_g, border_b = colorsys.hsv_to_rgb(p_h, 0.25, 0.35)
    border = rgb_to_hex((border_r*255, border_g*255, border_b*255))
    
    inact_border_r, inact_border_g, inact_border_b = colorsys.hsv_to_rgb(dom_h, 0.15, 0.22)
    inactive_border = rgb_to_hex((inact_border_r*255, inact_border_g*255, inact_border_b*255))

    def make_color(hue, sat=0.40, val=0.82):
        r, g, b = colorsys.hsv_to_rgb(hue, sat, val)
        return rgb_to_hex((r*255, g*255, b*255))

    c_red = make_color(0.98, 0.48, 0.82)
    c_green = make_color(0.35, 0.38, 0.78)
    c_yellow = make_color(0.12, 0.42, 0.82)
    c_blue = make_color(0.60, 0.38, 0.82)
    c_magenta = make_color(0.78, 0.42, 0.82)  # Hex lavender purple (t7)
    c_cyan = make_color(0.50, 0.38, 0.80)     # Hex steel cyan (t10)

    palette = {
        'bg': bg,
        'bg_alt': bg_alt,
        'bg_sel': bg_sel,
        'fg': fg,
        'fg_muted': fg_muted,
        'accent': accent,
        'accent2': accent2,
        'border': border,
        'inactive_border': inactive_border,
        'c0': bg,
        'c1': c_red,
        'c2': c_green,
        'c3': c_yellow,
        'c4': c_blue,
        'c5': c_magenta,
        'c6': c_cyan,
        'c7': fg,
        'c8': fg_muted,
        'c9': c_red,
        'c10': c_green,
        'c11': c_yellow,
        'c12': c_blue,
        'c13': c_magenta,
        'c14': c_cyan,
        'c15': '#ffffff',
    }
    return palette

def update_waybar(palette, dotfiles_dir):
    waybar_colors_path = os.path.join(dotfiles_dir, '.config', 'waybar', 'colors.css')
    css_content = f"""/* Generated dynamically from wallpaper */
@define-color bg {palette['bg']};
@define-color bg_alpha rgba({hex_to_rgb(palette['bg'])[0]}, {hex_to_rgb(palette['bg'])[1]}, {hex_to_rgb(palette['bg'])[2]}, 0.88);
@define-color bg_alt {palette['bg_alt']};
@define-color fg {palette['fg']};
@define-color fg_muted {palette['fg_muted']};
@define-color accent {palette['accent']};
@define-color accent_alpha rgba({hex_to_rgb(palette['accent'])[0]}, {hex_to_rgb(palette['accent'])[1]}, {hex_to_rgb(palette['accent'])[2]}, 0.35);
@define-color border {palette['border']};
@define-color red {palette['c1']};
@define-color green {palette['c2']};
@define-color yellow {palette['c3']};
@define-color blue {palette['c4']};
@define-color magenta {palette['c5']};
@define-color cyan {palette['c6']};
"""
    with open(waybar_colors_path, 'w') as f:
        f.write(css_content)

def update_rofi(palette, dotfiles_dir):
    rofi_colors_path = os.path.join(dotfiles_dir, '.config', 'rofi', 'colors.rasi')
    rasi_content = f"""/* Generated dynamically from wallpaper */
* {{
    bg: {palette['bg']};
    bg-alt: {palette['bg_alt']};
    fg: {palette['fg']};
    accent: {palette['accent']};
    border-col: {palette['border']};
}}
"""
    with open(rofi_colors_path, 'w') as f:
        f.write(rasi_content)

def update_ghostty(palette, dotfiles_dir):
    ghostty_theme_path = os.path.join(dotfiles_dir, '.config', 'ghostty', 'themes', 'dynamic')
    ghostty_content = f"""palette = 0={palette['c0']}
palette = 1={palette['c1']}
palette = 2={palette['c2']}
palette = 3={palette['c3']}
palette = 4={palette['c4']}
palette = 5={palette['c5']}
palette = 6={palette['c6']}
palette = 7={palette['c7']}
palette = 8={palette['c8']}
palette = 9={palette['c9']}
palette = 10={palette['c10']}
palette = 11={palette['c11']}
palette = 12={palette['c12']}
palette = 13={palette['c13']}
palette = 14={palette['c14']}
palette = 15={palette['c15']}

background = {palette['bg'].lstrip('#')}
foreground = {palette['fg'].lstrip('#')}
cursor-color = {palette['accent'].lstrip('#')}
cursor-text = {palette['bg'].lstrip('#')}
selection-background = {palette['bg_sel'].lstrip('#')}
selection-foreground = {palette['fg'].lstrip('#')}
"""
    with open(ghostty_theme_path, 'w') as f:
        f.write(ghostty_content)
        
    ghostty_cfg_path = os.path.join(dotfiles_dir, '.config', 'ghostty', 'config.ghostty')
    if os.path.exists(ghostty_cfg_path):
        os.utime(ghostty_cfg_path, None)

def update_neovim(palette, dotfiles_dir):
    nvim_dynamic_path = os.path.join(dotfiles_dir, '.config', 'nvim', 'colors', 'dynamic.lua')
    lua_content = f"""-- Dynamically generated colorscheme inspired by Hex Lavender
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "dynamic"
vim.o.background = "dark"

local palette = {{
  bg = "{palette['bg']}",
  bg_dark = "{palette['bg_alt']}",
  bg_highlight = "{palette['bg_alt']}",
  bg_selection = "{palette['bg_sel']}",
  
  fg = "{palette['fg']}",
  fg_dark = "{palette['fg_muted']}",
  fg_gutter = "{palette['fg_muted']}",
  comment = "{palette['fg_muted']}",

  accent = "{palette['accent']}",
  accent2 = "{palette['accent2']}",
  red = "{palette['c1']}",
  green = "{palette['c2']}",
  yellow = "{palette['c3']}",
  blue = "{palette['c4']}",
  magenta = "{palette['c5']}",
  cyan = "{palette['c6']}",
  white = "{palette['c15']}",
}}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Core Editor UI
hl("Normal", {{ fg = palette.fg, bg = palette.bg }})
hl("NormalFloat", {{ fg = palette.fg, bg = palette.bg_dark }})
hl("FloatBorder", {{ fg = palette.accent, bg = palette.bg_dark }})
hl("ColorColumn", {{ bg = palette.bg_highlight }})
hl("Cursor", {{ fg = palette.bg, bg = palette.accent }})
hl("CursorLine", {{ bg = palette.bg_highlight }})
hl("CursorColumn", {{ bg = palette.bg_highlight }})
hl("Directory", {{ fg = palette.blue, bold = true }})
hl("ErrorMsg", {{ fg = palette.red, bold = true }})
hl("WarningMsg", {{ fg = palette.yellow }})
hl("WinSeparator", {{ fg = palette.bg_selection, bg = "NONE" }})
hl("VertSplit", {{ fg = palette.bg_selection, bg = "NONE" }})
hl("LineNr", {{ fg = palette.fg_gutter }})
hl("CursorLineNr", {{ fg = palette.accent, bold = true }})
hl("MatchParen", {{ fg = palette.white, bg = palette.bg_selection, bold = true }})
hl("Pmenu", {{ fg = palette.fg, bg = palette.bg_dark }})
hl("PmenuSel", {{ fg = palette.white, bg = palette.bg_selection, bold = true }})
hl("PmenuSbar", {{ bg = palette.bg_highlight }})
hl("PmenuThumb", {{ bg = palette.accent }})
hl("StatusLine", {{ fg = palette.fg, bg = palette.bg_dark }})
hl("StatusLineNC", {{ fg = palette.comment, bg = palette.bg_dark }})
hl("TabLine", {{ fg = palette.comment, bg = palette.bg_dark }})
hl("TabLineSel", {{ fg = palette.fg, bg = palette.bg_highlight, bold = true }})
hl("Visual", {{ bg = palette.bg_selection }})
hl("Search", {{ fg = palette.bg, bg = palette.accent, bold = true }})
hl("IncSearch", {{ fg = palette.bg, bg = palette.magenta, bold = true }})

-- Balanced Syntax Highlighting (Hex Lavender Style)
hl("Comment", {{ fg = palette.comment, italic = true }})
hl("Constant", {{ fg = palette.magenta }})
hl("String", {{ fg = palette.green, italic = true }})
hl("Character", {{ fg = palette.green }})
hl("Number", {{ fg = palette.yellow }})
hl("Boolean", {{ fg = palette.accent, bold = true }})
hl("Float", {{ fg = palette.yellow }})
hl("Identifier", {{ fg = palette.fg }})
hl("Function", {{ fg = palette.cyan }})
hl("Statement", {{ fg = palette.blue }})
hl("Conditional", {{ fg = palette.blue }})
hl("Repeat", {{ fg = palette.blue }})
hl("Label", {{ fg = palette.cyan }})
hl("Operator", {{ fg = palette.accent2 }})
hl("Keyword", {{ fg = palette.magenta, italic = true }})
hl("Exception", {{ fg = palette.red }})
hl("PreProc", {{ fg = palette.accent2 }})
hl("Include", {{ fg = palette.accent }})
hl("Define", {{ fg = palette.accent2 }})
hl("Macro", {{ fg = palette.accent2 }})
hl("Type", {{ fg = palette.accent, bold = true }})
hl("StorageClass", {{ fg = palette.accent }})
hl("Structure", {{ fg = palette.accent }})
hl("Typedef", {{ fg = palette.accent }})
hl("Special", {{ fg = palette.magenta }})
hl("SpecialChar", {{ fg = palette.magenta }})
hl("Delimiter", {{ fg = palette.fg_dark }})
hl("SpecialComment", {{ fg = palette.accent, bold = true }})
hl("Error", {{ fg = palette.red, bold = true }})
hl("Todo", {{ fg = palette.bg, bg = palette.accent, bold = true }})

-- Diagnostics
hl("DiagnosticError", {{ fg = palette.red }})
hl("DiagnosticWarn", {{ fg = palette.yellow }})
hl("DiagnosticInfo", {{ fg = palette.blue }})
hl("DiagnosticHint", {{ fg = palette.cyan }})
hl("DiagnosticUnderlineError", {{ undercurl = true, sp = palette.red }})
hl("DiagnosticUnderlineWarn", {{ undercurl = true, sp = palette.yellow }})
hl("DiagnosticUnderlineInfo", {{ undercurl = true, sp = palette.blue }})
hl("DiagnosticUnderlineHint", {{ undercurl = true, sp = palette.cyan }})

-- TreeSitter Links
hl("@comment", {{ link = "Comment" }})
hl("@keyword", {{ link = "Keyword" }})
hl("@function", {{ link = "Function" }})
hl("@function.builtin", {{ fg = palette.cyan, italic = true }})
hl("@variable", {{ fg = palette.fg }})
hl("@variable.builtin", {{ fg = palette.accent, italic = true }})
hl("@variable.parameter", {{ fg = palette.fg_dark, italic = true }})
hl("@property", {{ fg = palette.fg_dark }})
hl("@type", {{ link = "Type" }})
hl("@type.builtin", {{ fg = palette.accent, italic = true }})
hl("@string", {{ link = "String" }})
hl("@number", {{ link = "Number" }})
hl("@boolean", {{ link = "Boolean" }})
hl("@operator", {{ link = "Operator" }})
hl("@punctuation.delimiter", {{ fg = palette.fg_dark }})
hl("@punctuation.bracket", {{ fg = palette.fg }})

-- GitSigns
hl("GitSignsAdd", {{ fg = palette.green }})
hl("GitSignsChange", {{ fg = palette.yellow }})
hl("GitSignsDelete", {{ fg = palette.red }})

-- Telescope
hl("TelescopeBorder", {{ fg = palette.accent, bg = palette.bg_dark }})
hl("TelescopePromptBorder", {{ fg = palette.accent, bg = palette.bg_highlight }})
hl("TelescopePromptNormal", {{ fg = palette.fg, bg = palette.bg_highlight }})
hl("TelescopePromptTitle", {{ fg = palette.bg, bg = palette.accent, bold = true }})
hl("TelescopePreviewTitle", {{ fg = palette.bg, bg = palette.green, bold = true }})
hl("TelescopeResultsTitle", {{ fg = palette.bg, bg = palette.blue, bold = true }})
hl("TelescopeSelection", {{ bg = palette.bg_selection, fg = palette.white }})

-- WhichKey
hl("WhichKey", {{ fg = palette.accent, bold = true }})
hl("WhichKeyGroup", {{ fg = palette.blue }})
hl("WhichKeyDesc", {{ fg = palette.fg }})

-- Refresh lualine dynamically if running inside Neovim
pcall(function()
  require("lualine").setup({{ options = {{ theme = "auto" }} }})
end)
"""
    os.makedirs(os.path.dirname(nvim_dynamic_path), exist_ok=True)
    with open(nvim_dynamic_path, 'w') as f:
        f.write(lua_content)

def update_starship(palette, dotfiles_dir):
    starship_path = os.path.join(dotfiles_dir, '.config', 'starship.toml')
    starship_content = f"""# Generated dynamically from wallpaper
"$schema" = 'https://starship.rs/config-schema.json'

format = \"\"\"
[](color_lavender)\\
$os\\
$username\\
[](bg:color_mauve fg:color_lavender)\\
$directory\\
[](fg:color_mauve bg:color_blue)\\
$git_branch\\
$git_status\\
[](fg:color_blue bg:color_bg3)\\
$c\\
$cpp\\
$rust\\
$golang\\
$nodejs\\
$php\\
$java\\
$kotlin\\
$haskell\\
$python\\
[](fg:color_bg3 bg:color_bg1)\\
$docker_context\\
$conda\\
$pixi\\
$time\\
[ ](fg:color_bg1)\\
$line_break$character\"\"\"

palette = 'dynamic'

[palettes.dynamic]
color_bg0 = '{palette['bg']}'
color_bg1 = '{palette['bg_alt']}'
color_bg3 = '{palette['bg_sel']}'
color_fg0 = '{palette['fg']}'
color_lavender = '{palette['accent']}'
color_mauve = '{palette['accent2']}'
color_blue = '{palette['c4']}'
color_teal = '{palette['c6']}'
color_green = '{palette['c2']}'
color_peach = '{palette['c3']}'
color_yellow = '{palette['c3']}'
color_red = '{palette['c1']}'

[os]
disabled = false
style = "bg:color_lavender fg:color_bg0"

[os.symbols]
Windows = "󰍲"
Ubuntu = "󰕈"
SUSE = ""
Raspbian = "󰐿"
Mint = "󰣭"
Macos = "󰀵"
Manjaro = ""
Linux = "󰌽"
Gentoo = "󰣨"
Fedora = "󰣛"
Alpine = ""
Amazon = ""
Android = ""
AOSC = ""
Arch = "󰣇"
Artix = "󰣇"
EndeavourOS = ""
CentOS = ""
Debian = "󰣚"
Redhat = "󱄛"
RedHatEnterprise = "󱄛"
Pop = ""

[username]
show_always = true
style_user = "bg:color_lavender fg:color_bg0"
style_root = "bg:color_lavender fg:color_bg0"
format = '[ $user ]($style)'

[directory]
style = "fg:color_bg0 bg:color_mauve"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[directory.substitutions]
"Documents" = "󰈙 "
"Downloads" = " "
"Music" = "󰝚 "
"Pictures" = " "
"Developer" = "󰲋 "

[git_branch]
symbol = ""
style = "bg:color_blue"
format = '[[ $symbol $branch ](fg:color_bg0 bg:color_blue)]($style)'

[git_status]
style = "bg:color_blue"
format = '[[($all_status$ahead_behind )](fg:color_bg0 bg:color_blue)]($style)'

[nodejs]
symbol = ""
style = "bg:color_bg3"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_bg3)]($style)'

[c]
symbol = " "
style = "bg:color_bg3"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_bg3)]($style)'

[cpp]
symbol = " "
style = "bg:color_bg3"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_bg3)]($style)'

[rust]
symbol = ""
style = "bg:color_bg3"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_bg3)]($style)'

[golang]
symbol = ""
style = "bg:color_bg3"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_bg3)]($style)'

[php]
symbol = ""
style = "bg:color_bg3"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_bg3)]($style)'

[java]
symbol = ""
style = "bg:color_bg3"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_bg3)]($style)'

[kotlin]
symbol = ""
style = "bg:color_bg3"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_bg3)]($style)'

[haskell]
symbol = ""
style = "bg:color_bg3"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_bg3)]($style)'

[python]
symbol = ""
style = "bg:color_bg3"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_bg3)]($style)'

[docker_context]
symbol = ""
style = "bg:color_bg1"
format = '[[ $symbol( $context) ](fg:color_fg0 bg:color_bg1)]($style)'

[conda]
style = "bg:color_bg1"
format = '[[ $symbol( $environment) ](fg:color_fg0 bg:color_bg1)]($style)'

[pixi]
style = "bg:color_bg1"
format = '[[ $symbol( $version)( $environment) ](fg:color_fg0 bg:color_bg1)]($style)'

[time]
disabled = false
time_format = "%R"
style = "bg:color_bg1"
format = '[[  $time ](fg:color_fg0 bg:color_bg1)]($style)'

[line_break]
disabled = false

[character]
disabled = false
success_symbol = '[](bold fg:color_green)'
error_symbol = '[](bold fg:color_red)'
vimcmd_symbol = '[](bold fg:color_green)'
vimcmd_replace_one_symbol = '[](bold fg:color_mauve)'
vimcmd_replace_symbol = '[](bold fg:color_mauve)'
vimcmd_visual_symbol = '[](bold fg:color_yellow)'
"""
    with open(starship_path, 'w') as f:
        f.write(starship_content)

def update_niri(palette, dotfiles_dir):
    niri_cfg_path = os.path.join(dotfiles_dir, '.config', 'niri', 'config.kdl')
    if os.path.exists(niri_cfg_path):
        with open(niri_cfg_path, 'r') as f:
            content = f.read()
            
        glow_color = f"{palette['accent']}aa"
        
        content = re.sub(r'border\s*\{[^}]*\}', '''border {
        width 1
        active-color "transparent"
        inactive-color "transparent"
    }''', content, flags=re.DOTALL)

        content = re.sub(r'focus-ring\s*\{[^}]*\}', f'''focus-ring {{
        width 3
        active-color "{glow_color}"
        inactive-color "transparent"
    }}''', content, flags=re.DOTALL)
        
        with open(niri_cfg_path, 'w') as f:
            f.write(content)

def update_zellij(palette, dotfiles_dir):
    home_zellij_dir = os.path.expanduser('~/.config/zellij')
    dotfiles_zellij_dir = os.path.join(dotfiles_dir, '.config', 'zellij')
    
    if not os.path.exists(home_zellij_dir):
        try:
            os.symlink(dotfiles_zellij_dir, home_zellij_dir)
        except Exception:
            pass

    kdl_theme_block = f"""themes {{
    dynamic {{
        fg "{palette['fg']}"
        bg "{palette['bg']}"
        black "{palette['c0']}"
        red "{palette['c1']}"
        green "{palette['c2']}"
        yellow "{palette['c3']}"
        blue "{palette['c4']}"
        magenta "{palette['c5']}"
        cyan "{palette['c6']}"
        white "{palette['c15']}"
        orange "{palette['accent']}"
    }}
}}"""

    zellij_themes_dir = os.path.join(dotfiles_zellij_dir, 'themes')
    os.makedirs(zellij_themes_dir, exist_ok=True)
    zellij_theme_path = os.path.join(zellij_themes_dir, 'dynamic.kdl')
    with open(zellij_theme_path, 'w') as f:
        f.write(kdl_theme_block + "\n")

    zellij_cfg_path = os.path.join(dotfiles_zellij_dir, 'config.kdl')
    if os.path.exists(zellij_cfg_path):
        with open(zellij_cfg_path, 'r') as f:
            content = f.read()

        if re.search(r'^\s*theme\s+"[^"]+"', content, re.MULTILINE):
            content = re.sub(r'^\s*theme\s+"[^"]+"', 'theme "dynamic"', content, flags=re.MULTILINE)
        else:
            content = 'theme "dynamic"\n' + content

        if re.search(r'themes\s*\{.*?\}\s*\}', content, re.DOTALL):
            content = re.sub(r'themes\s*\{.*?\}\s*\}', kdl_theme_block, content, flags=re.DOTALL)
        else:
            content = content.rstrip() + "\n\n" + kdl_theme_block + "\n"

        with open(zellij_cfg_path, 'w') as f:
            f.write(content)

        os.utime(zellij_cfg_path, None)


def update_mako(palette, dotfiles_dir):
    mako_dir = os.path.join(dotfiles_dir, '.config', 'mako')
    os.makedirs(mako_dir, exist_ok=True)
    mako_cfg_path = os.path.join(mako_dir, 'config')
    
    bg_alpha = f"{palette['bg']}ee"
    fg = palette['fg']
    fg_muted = palette['fg_muted']
    accent = palette['accent']
    border = palette['border']
    red = palette['c1']
    
    mako_content = f"""# Generated dynamically from wallpaper
font=JetBrainsMono Nerd Font 10
width=360
height=140
margin=16
padding=14,16
border-size=2
border-radius=12
icons=1
max-icon-size=48
icon-location=left
markup=1
actions=1
history=1
text-alignment=left
default-timeout=5000
ignore-timeout=0
layer=overlay
anchor=top-right

background-color={bg_alpha}
text-color={fg}
border-color={accent}
progress-color=over {accent}

[urgency=low]
background-color={bg_alpha}
text-color={fg_muted}
border-color={border}
default-timeout=3000

[urgency=normal]
background-color={bg_alpha}
text-color={fg}
border-color={accent}
default-timeout=5000

[urgency=high]
background-color={bg_alpha}
text-color=#ffffff
border-color={red}
default-timeout=0
"""
    with open(mako_cfg_path, 'w') as f:
        f.write(mako_content)

    home_mako_dir = os.path.expanduser('~/.config/mako')
    if not os.path.exists(home_mako_dir):
        try:
            os.symlink(mako_dir, home_mako_dir)
        except Exception:
            pass

def set_swaybg(image_path, dotfiles_dir):
    subprocess.run(["pkill", "-x", "swaybg"], stderr=subprocess.DEVNULL)
    subprocess.Popen(["swaybg", "-i", image_path, "-m", "fill"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    
    niri_cfg_path = os.path.join(dotfiles_dir, '.config', 'niri', 'config.kdl')
    if os.path.exists(niri_cfg_path):
        with open(niri_cfg_path, 'r') as f:
            content = f.read()
        content = re.sub(r'spawn-at-startup\s+"swaybg".*', f'spawn-at-startup "swaybg" "-i" "{image_path}"', content)
        with open(niri_cfg_path, 'w') as f:
            f.write(content)

def reload_apps():
    subprocess.run(["pkill", "-SIGUSR2", "waybar"], stderr=subprocess.DEVNULL)
    subprocess.run(["makoctl", "reload"], stderr=subprocess.DEVNULL)
    subprocess.run(["niri", "msg", "action", "load-config-file"], stderr=subprocess.DEVNULL)

def main():
    dotfiles_dir = os.path.expanduser('~/Dotfiles')
    
    if len(sys.argv) > 1:
        wallpaper_path = os.path.abspath(sys.argv[1])
    else:
        wallpaper_path = os.path.join(dotfiles_dir, 'Wallpapers', 'wallhaven6.jpg')

    if not os.path.exists(wallpaper_path):
        print(f"Error: Wallpaper file {wallpaper_path} not found.")
        sys.exit(1)

    print(f"Extracting palette from {wallpaper_path}...")
    palette = extract_palette(wallpaper_path)

    print(f"Applying colors to Waybar, Rofi, Ghostty, Neovim, Starship, Niri, Zellij, and Mako...")
    update_waybar(palette, dotfiles_dir)
    update_rofi(palette, dotfiles_dir)
    update_ghostty(palette, dotfiles_dir)
    update_neovim(palette, dotfiles_dir)
    update_starship(palette, dotfiles_dir)
    update_niri(palette, dotfiles_dir)
    update_zellij(palette, dotfiles_dir)
    update_mako(palette, dotfiles_dir)
    
    print(f"Setting background wallpaper with swaybg...")
    set_swaybg(wallpaper_path, dotfiles_dir)
    
    print(f"Reloading desktop environments...")
    reload_apps()
    
    print("Done! Wallpaper and dynamic colors applied successfully.")

if __name__ == '__main__':
    main()



