-- Tree-sitter: garante parsers para systemverilog e vhdl instalados.
--
-- IMPORTANTE: o parser "verilog" não existe no nvim-treesitter upstream.
-- O parser "systemverilog" cobre tanto Verilog (.v) quanto SystemVerilog (.sv).
-- Por isso removemos "verilog" da lista e mapeamos o filetype verilog →
-- parser systemverilog via vim.treesitter.language.register().

-- Mapeia filetype "verilog" para o parser "systemverilog" (que cobre ambos)
vim.treesitter.language.register("verilog", "systemverilog")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "systemverilog",
        "vhdl",
      },
    },
  },
}
