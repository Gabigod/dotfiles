-- Configurações para arquivos VHDL

-- Comentários de linha com --
vim.opt_local.commentstring = "-- %s"

-- Indentação
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

-- Folding baseado em árvore
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
