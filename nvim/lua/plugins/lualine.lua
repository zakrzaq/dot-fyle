-- requiring plugin
local installed, lln = pcall(require, "lualine")
if not installed then
	vim.notify("Plugin 'lualine' is not installed")
	return
end

lln.setup({
	options = {
		icons_enabled = false,
		theme = "nordic",
		component_separators = "|",
		section_separators = "",
	},
	sections = {
		lualine_x = {
			function()
				local ok, pomo = pcall(require, "pomo")
				if not ok then
					return ""
				end

				local timer = pomo.get_first_to_finish()
				if timer == nil then
					return ""
				end

				return "󰄉 " .. tostring(timer)
			end,
			"encoding",
			"fileformat",
			"filetype",
		},
	},
})
