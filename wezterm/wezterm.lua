-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- Create local var to hold the configuration
local config = wezterm.config_builder()

-- Config WSL
config.default_domain = 'WSL:Ubuntu-22.04'

-- Disable tabs
config.enable_tab_bar = false

-- Set scrollback size
config.scrollback_lines = 5000

-- Set key bindings
config.keys = {
  {
    key = 'F11',
    action = wezterm.action.ToggleFullScreen,
  },
}

-- Set mouse bindings
config.mouse_bindings = {
  -- Right mouse button paste
  {
    event = { Down = { streak = 1, button = 'Right' } },
    moods = 'NONE',
    action = wezterm.action.PasteFrom 'PrimarySelection',
  },
  -- Force scrolling to send sroll event (not arrowUp/arrowDown in some cases)
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'NONE',
    action = wezterm.action.ScrollByCurrentEventWheelDelta,
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'NONE',
    action = wezterm.action.ScrollByCurrentEventWheelDelta,
  },
}

-- Set window padding
config.window_padding = {
  left = 5,
  right = 5,
  top = 0,
  bottom = 0,
}

-- Set color scheme
config.color_scheme = 'OneDark (base16)'

-- Disable font shaping / font ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- Return the configuration to wezterm
return config
