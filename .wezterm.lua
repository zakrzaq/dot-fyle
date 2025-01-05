local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local os_name = wezterm.target_triple:match("([^%-]+)")

-- Color scheme (Rose Pine)
local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main
config.colors = theme.colors()
config.window_frame = theme.window_frame()

-- Font configuration
config.font_size = 12

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
