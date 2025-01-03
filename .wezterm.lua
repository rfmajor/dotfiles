local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- config.color_scheme = 'Bright Lights'
-- config.color_scheme = 'Ciapre'
config.color_scheme = 'Elementary'
-- config.color_scheme = 'Framer'
--config.color_scheme = 'JetBrains Darcula'
config.harfbuzz_features = { 'calt=0' }
config.enable_tab_bar = false

config.background = {
    {
        source = {
            File = os.getenv("HOME") .. '/dotfiles/img/animals.png',
        },
        width = "100%",
        hsb = { brightness = 0.1 },
    }
}

return config
