local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- config.color_scheme = 'Bright Lights'
-- config.color_scheme = 'Ciapre'
config.color_scheme = 'Elementary'
-- config.color_scheme = 'Framer'
---config.color_scheme = 'JetBrains Darcula'

config.background = {
    {
        source = {
            File = os.getenv("HOME") + '/dotfiles/wallpaper.png',
        },
        width = "100%",
        hsb = dimmer,
    }
}

return config
