-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.options")
require("config.keymaps")
--
-- Força o fundo a ficar transparente
local transparent_groups = {
  "Normal",
  "NormalNC",
  "Comment",
  "Constant",
  "Special",
  "Identifier",
  "Statement",
  "PreProc",
  "Type",
  "Underlined",
  "Todo",
  "String",
  "Function",
  "Conditional",
  "Repeat",
  "Operator",
  "Structure",
  "LineNr",
  "NonText",
  "SignColumn",
  "CursorLine",
  "CursorLineNr",
  "StatusLine",
  "StatusLineNC",
  "EndOfBuffer",
}

for _, group in ipairs(transparent_groups) do
  vim.cmd(string.format("hi %s ctermbg=NONE guibg=NONE", group))
end

-- Ativa o corretor em português automaticamente para Markdown e Textos
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "pt"
  end,
})
