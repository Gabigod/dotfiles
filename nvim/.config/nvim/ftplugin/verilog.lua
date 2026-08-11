-- Configurações para arquivos Verilog e SystemVerilog
-- Aplicado automaticamente para filetypes: verilog, systemverilog

-- Comentários de linha
vim.opt_local.commentstring = "// %s"

-- Indentação
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

-- Folding baseado em árvore (tree-sitter)
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Ativa verible-verilog-ls automaticamente
-- Já feito via lspconfig em lua/plugins/lsp-hdl.lua
