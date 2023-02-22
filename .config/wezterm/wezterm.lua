local wezterm = require 'wezterm'
return {
  color_scheme = 'Dracula',
  enable_scroll_bar = false,
  font = wezterm.font 'FiraCode Nerd Font',
  font_size = 16,
  harfbuzz_features = { 'ss02', 'ss06', 'ss07', 'ss08', 'zero' },
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = 'RESIZE',
  window_frame = {
    font = wezterm.font { family = 'FiraCode Nerd Font', weight = 'Bold'},
    font_size = 18,
  },
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
