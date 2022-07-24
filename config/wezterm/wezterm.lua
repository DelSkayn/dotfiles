local wezterm = require "wezterm";

colors = {
    foreground = "#c0caf5",
    background = "#24283b",
    cursor_bg = "#c0caf5",
    cursor_border = "#c0caf5",
    cursor_fg = "#24283b",
    selection_bg = "#364A82",
    selection_fg = "#c0caf5",

    ansi = {"#1D202F", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6"},
    brights = {"#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5"},

    scrollbar_thumb = "#24283b",
    tab_bar = {
        background = "#181b2a",
        active_tab = {
            bg_color = "#292e42",
            fg_color = "#c0caf5",
        },
        inactive_tab = {
            fg_color = "#737aa2",
            bg_color = "#181b2a",
        }
    },
}

return {
    use_fancy_tab_bar=false,
    colors = colors,
    font_size = 11,
    font = wezterm.font_with_fallback({
        {family = "Terminus",italic=false},
        "TerminessTTF Nerd Font",
        "Font Awesome 6 Brands",
        "Font Awesome 6 Free",
        "Noto Sans Symbols",
    }),
    font_rules = {
        {
            italic=true,
            font = wezterm.font("TerminessTTF Nerd Font",{italic=true})
        }
    },
    window_padding={left=0,right=0,top=0,bottom=0}
}
