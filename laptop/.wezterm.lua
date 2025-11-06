local wezterm = require "wezterm"
local cfg = wezterm.config_builder()

-- Miscellaneous
cfg.adjust_window_size_when_changing_font_size = false
cfg.allow_square_glyphs_to_overflow_width = "Never"
cfg.allow_win32_input_mode = false
cfg.anti_alias_custom_block_glyphs = false
cfg.audible_bell = "Disabled"
cfg.font_size = 9
cfg.scrollback_lines = 2137
cfg.selection_word_boundary = " \t\n{}[]()'\"`.,;:"

-- Unicode select menu
cfg.char_select_bg_color = "#282c34"
cfg.char_select_fg_color = "#eff1f5"
cfg.char_select_font_size = 13
cfg.warn_about_missing_glyphs = false

-- Colors
cfg.color_scheme = "Pro"
cfg.colors = {
	cursor_bg = "#fff",
	cursor_fg = "#000",
	cursor_border = "#999"
}

-- Tab bar
cfg.hide_tab_bar_if_only_one_tab = true
cfg.show_close_tab_button_in_tabs = false
cfg.show_new_tab_button_in_tab_bar = false
cfg.show_tab_index_in_tab_bar = false
wezterm.on(
	'format-tab-title',
	function(tab, tabs, panes, config, hover, max_width)
		title = tab.active_pane.title
		part_to_remove = "mosder@archtop:"
		return string.gsub(title, part_to_remove, "")
	end
)


-- Window
cfg.window_background_opacity = 0.9
cfg.window_frame = {
	-- Would love to set alpha of both of these to 0.9, but it incorrectly applies
	-- to the area above the tabs themselves, so it's 1 for now
	active_titlebar_bg = "rgba(40,44,52,1)",
	inactive_titlebar_bg = "rgba(40,44,52,1)",
	font_size = 11
}
cfg.window_padding = {
  left = 5,
  right = 5,
  top = 2,
  bottom = 2,
}

-- Key bindings
local act = wezterm.action
cfg.disable_default_key_bindings = true
cfg.keys = {
	-- Delete last word (Remap ALT+Backspace to CTRL+Backspace)
	{
		mods = 'CTRL',
		key = 'Backspace',
		action = act.SendKey { mods = 'ALT', key = 'Backspace' }
	},
	-- Copy mode
	{
		mods = 'CTRL|SHIFT',
		key = 'X',
		action = act.ActivateCopyMode
	},
	-- Change tabs - relative
	{
		mods = 'CTRL',
		key = 'Tab',
		action = act.ActivateTabRelative(1)
	},
	{
		mods = 'CTRL|SHIFT',
		key = 'Tab',
		action = act.ActivateTabRelative(-1)
	},
	-- Unicode menu
	{
		mods = 'CTRL',
		key = 'u',
		action = act.CharSelect
	},
	-- Close current tab
	{
		mods = 'CTRL',
		key = 'w',
		action = act.CloseCurrentTab { confirm = true }
	},
	{
		mods = 'CTRL',
		key = 'q',
		action = act.CloseCurrentTab { confirm = true }
	},
	-- Copy selection to clipboard
	{
		mods = 'CTRL|SHIFT',
		key = 'c',
		action = act.CopyTo "Clipboard"
	},
	-- Decrease font size
	{
		mods = 'CTRL',
		key = '-',
		action = act.DecreaseFontSize
	},
	-- Increase font size
	{
		mods = 'CTRL',
		key = '=',
		action = act.IncreaseFontSize
	},
	-- Move tabs - relative
	{
		mods = 'CTRL|SHIFT',
		key = 'LeftArrow',
		action = act.MoveTabRelative(-1)
	},
	{
		mods = 'CTRL|SHIFT',
		key = 'RightArrow',
		action = act.MoveTabRelative(1)
	},
	-- Pase from clipboard
	{
		mods = 'CTRL|SHIFT',
		key = 'v',
		action = act.PasteFrom 'Clipboard'
	},
	{
		mods = 'SHIFT',
		key = 'Insert',
		action = act.PasteFrom 'Clipboard'
	},
	-- Reset font size
	{
		mods = 'CTRL',
		key = 'p',
		action = act.ResetFontSize
	},
	-- Reset terminal
	{
		mods = 'CTRL',
		key = 'r',
		action = act.ResetTerminal
	},
}

return cfg
