-- requiring plugin
local installed, lln = pcall(require, "lualine")
if not installed then
  vim.notify("Plugin 'lualine' is not installed")
  return
end

lln.setup({
  options = {
    icons_enabled = false,
    theme = "nord",
    component_separators = "|",
    section_separators = "",
  },
  sections = {
    lualine_x = {
      "encoding",
      "fileformat",
      "filetype",
    },
  },
})
