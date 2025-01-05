local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Color scheme (Rose Pine)
local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main
config.color_scheme = "Rose Pine"
config.colors = theme.colors()
config.window_frame = theme.window_frame()

-- Font configuration
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 11

-- Window padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Tab bar settings
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

-- Default shell configuration
local default_prog = {}
local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- PowerShell
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})

	-- Git Bash
	local git_bash_path = "C:\\Program Files\\Git\\bin\\bash.exe"
	table.insert(launch_menu, {
		label = "Git Bash",
		args = { git_bash_path, "--login", "-i" },
	})

	-- WSL
	table.insert(launch_menu, {
		label = "WSL",
		args = { "wsl.exe", "~" },
	})

	-- Set PowerShell as default
	default_prog = { "powershell.exe", "-NoLogo" }
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

	-- Navigate panes using Alt + Arrow keys
	{
		key = "LeftArrow",
		mods = "ALT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "ALT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "ALT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "ALT",
		action = act.ActivatePaneDirection("Down"),
	},

	-- Navigate panes using Alt + HJKL (vim style)
	{
		key = "h",
		mods = "ALT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "ALT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "ALT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "ALT",
		action = act.ActivatePaneDirection("Down"),
	},
}


return config
