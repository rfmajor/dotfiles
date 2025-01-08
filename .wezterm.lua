local wezterm = require 'wezterm'
local config = wezterm.config_builder()

default_color_scheme = 'Bright Lights'
color_schemes = {'Bright Lights', 'Framer', 'Catppuccin Macchiato', 'Catppuccin Mocha', 'Chalk', 'Chalkboard', 'Chester'}
current_scheme_idx = 1
config.color_scheme = default_color_scheme
config.colors = {}
config.colors.cursor_bg = 'white'
config.colors.cursor_fg = 'black'

config.harfbuzz_features = { 'calt=0' }
config.enable_tab_bar = false
config.background = {
    {
        source = {
            File = os.getenv("HOME") .. '/dotfiles/img/dark_side_of_the_moon.png',
        },
        width = "100%",
        hsb = { brightness = 0.1 },
    }
}
function change_colors(window, pane, start, inc)
    local overrides = window:get_config_overrides() or {}
    current_scheme_idx = current_scheme_idx + inc
    if current_scheme_idx > #color_schemes or current_scheme_idx < 1 then
        current_scheme_idx = start
    end

    if color_schemes[current_scheme_idx] == default_color_scheme then
        overrides.color_scheme = nil
        wezterm.log_info("Changing color scheme to " .. default_color_scheme .. " (default)")
    else
        overrides.color_scheme = color_schemes[current_scheme_idx]
        wezterm.log_info("Changing color scheme to " .. color_schemes[current_scheme_idx])
    end

    window:set_config_overrides(overrides)
end
wezterm.on('next-colorscheme', function (window, pane)
    change_colors(window, pane, 1, 1)
end)
wezterm.on('previous-colorscheme', function (window, pane)
    change_colors(window, pane, #color_schemes, -1)
end)
config.keys = {
    {
        key = 'P',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.EmitEvent 'next-colorscheme',
    },
    {
        key = 'Q',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.EmitEvent 'previous-colorscheme',
    },
    {
        key = 'M',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ShowDebugOverlay
    },
}
return config
