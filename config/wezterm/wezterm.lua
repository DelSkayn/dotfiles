local wezterm = require("wezterm")

night_colors = {
    foreground = "#c0caf5",
    background = "#24283b",
    cursor_bg = "#c0caf5",
    cursor_border = "#c0caf5",
    cursor_fg = "#24283b",
    selection_bg = "#364A82",
    selection_fg = "#c0caf5",

    ansi = { "#1D202F", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6" },
    brights = { "#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5" },

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
        },
    },
}

day_colors = {
    foreground = "#3760bf",
    background = "#e1e2e7",
    cursor_bg = "#3760bf",
    cursor_border = "#3760bf",
    cursor_fg = "#e1e2e7",
    selection_bg = "#b6bfe2",
    selection_fg = "#3760bf",

    ansi = { "#e9e9ed", "#f52a65", "#587539", "#8c6c3e", "#2e7de9", "#9854f1", "#007197", "#6172b0" },
    brights = { "#a1a6c5", "#f52a65", "#587539", "#8c6c3e", "#2e7de9", "#9854f1", "#007197", "#3760bf" },

    tab_bar = {
        inactive_tab_edge = "#e9e9ec",
        background = "#80869e",
        active_tab = {
            fg_color = "#2e7de9",
            bg_color = "#e1e2e7",
        },
        inactive_tab = {
            bg_color = "#e9e9ec",
            fg_color = "#8990b3",
        },
        inactive_tab_hover = {
            bg_color = "#e9e9ec",
            fg_color = "#2e7de9",
        },
        new_tab_hover = {
            fg_color = "#e9e9ec",
            bg_color = "#2e7de9",
        },
        new_tab = {
            fg_color = "#2e7de9",
            bg_color = "#b6bfe2",
        },
    },
}

return {
    dpi = 192,
    enable_wayland = false,
    use_fancy_tab_bar = false,
    colors = night_colors,
    font_size = 11,
    font = wezterm.font_with_fallback({
        { family = "Terminus", italic = false },
        "Terminess Nerd Font",
        "Font Awesome 6 Brands",
        "Font Awesome 6 Free",
        "Noto Sans Symbols",
    }),
    font_rules = {
        {
            italic = true,
            font = wezterm.font("Terminess Nerd Font", { italic = true }),
        },
    },
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
    keys = {
        -- paste from the clipboard
        { key = "V", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
        { key = "l", mods = "ALT",  action = wezterm.action.ShowLauncher },
    },
}
