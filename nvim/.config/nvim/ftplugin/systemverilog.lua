-- Configurações para arquivos SystemVerilog
-- Herda de verilog mas garante extensões SV

vim.opt_local.commentstring = "// %s"
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
