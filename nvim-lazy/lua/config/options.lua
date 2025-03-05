-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local options = {
  -- ... other options ...

  clipboard = {
    name = "unnamedplus", -- or "unnamed" if you prefer primary selection
    copy = {
      ["+"] = function()
        if vim.fn.executable("xclip") == 1 then
          vim.fn.system("xclip -in -selection clipboard")
        end
      end,
      ["*"] = function()
        if vim.fn.executable("xclip") == 1 then
          vim.fn.system("xclip -in -selection primary")
        end
      end,
    },
    paste = {
      ["+"] = function()
        if vim.fn.executable("xclip") == 1 then
          return vim.fn.system("xclip -out -selection clipboard")
        else
          return "" -- Return empty string if xclip is not available
        end
      end,
      ["*"] = function()
        if vim.fn.executable("xclip") == 1 then
          return vim.fn.system("xclip -out -selection primary")
        else
          return "" -- Return empty string if xclip is not available
        end
      end,
    },
  },

  -- ... other options ...
}

return options
