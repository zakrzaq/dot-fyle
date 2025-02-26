local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Color scheme (Rose Pine)
-- local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main
-- config.colors = theme.colors()
-- config.window_frame = theme.window_frame()

config.colors = {
	foreground = "#ECEFF4",   -- Light snow color for the text
	background = "#2E3440",   -- Deep, cool Nordic night color for the background
	cursor_bg = "#88C0D0",    -- Light blue cursor for visibility
	cursor_border = "#88C0D0", -- Same as cursor_bg
	cursor_fg = "#2E3440",    -- Cursor text color (blends with background)
	selection_bg = "#4C566A", -- Nordic slate grey for selected text
	selection_fg = "#ECEFF4", -- Snowy white for selected text

	-- Nordic palette for ANSI colors
	ansi = {
		"#3B4252", -- Darker grey for black
		"#BF616A", -- Red inspired by Nordic rowan berries
		"#A3BE8C", -- Soft green of mossy landscapes
		"#EBCB8B", -- Warm amber from the sun at low angles
		"#81A1C1", -- Arctic blue sky
		"#B48EAD", -- Soft purple, reminiscent of Northern twilight
		"#88C0D0", -- Crisp blue ice for cyan
		"#ECEFF4", -- Snow white for white
	},
	brights = {
		"#4C566A", -- Slightly lighter grey for bright black
		"#BF616A", -- Bright rowan red for bright red
		"#A3BE8C", -- Same green for bright green
		"#EBCB8B", -- Bright warm amber
		"#81A1C1", -- Bright arctic blue
		"#B48EAD", -- Twilight purple, bright variant
		"#8FBCBB", -- Glacier cyan for bright cyan
		"#ECEFF4", -- Bright snow white
	},
}

-- Font configuration
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 12

-- Window padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.window_frame = {
	active_titlebar_bg = "#3B4252",  -- Nordic slate grey for active window title bar
	inactive_titlebar_bg = "#2E3440", -- Slightly darker for inactive windows
	active_titlebar_fg = "#ECEFF4",  -- Snow white text on the title bar
	inactive_titlebar_fg = "#D8DEE9", -- Dimmed white for inactive title bar text
	button_fg = "#D8DEE9",           -- Slightly dimmed buttons (minimize, close)
	button_bg = "#3B4252",           -- Button background matches title bar
	button_hover_fg = "#ECEFF4",     -- Hovered button turns snow white
	button_hover_bg = "#4C566A",     -- Hovered button background becomes lighter grey
}

-- Tab bar settings
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.enable_tab_bar = false

-- Default shell configuration
local default_prog = {}
local launch_menu = {}

local function is_windows()
	return wezterm.target_triple:find("windows") ~= nil
end

if is_windows() then
	local git_bash_path = "C:\\Program Files\\Git\\bin\\bash.exe"

	launch_menu = {
		{
			label = "Windows PowerShell",
			args = { "powershell.exe", "-NoLogo" },
		},
		{
			label = "Git Bash",
			args = { git_bash_path, "--login", "-i" },
		},
		{
			label = "WSL",
			args = { "wsl.exe" },
		},
	}
	default_prog = { "powershell.exe", "-NoLogo" }
else
	launch_menu = {
		{
			label = "Zsh Shell",
			args = { "zsh" },
		},
	}
	default_prog = { "zsh" }
end

config.default_prog = default_prog
config.launch_menu = launch_menu

-- Window appearance
config.window_background_opacity = 1.0
config.window_decorations = "TITLE | RESIZE"
config.enable_scroll_bar = false

-- Cursor settings
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 800

-- Key bindings
config.keys = {
	-- Split panes
	{
		key = "\\",
		mods = "ALT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "ALT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "h",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Down"),
	},

	-- Navigate panes using arrow keys with CTRL + ALT
	{
		key = "LeftArrow",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Down"),
	},
}

return config
