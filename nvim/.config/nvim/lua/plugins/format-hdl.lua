-- Formatação HDL: verible-verilog-format para Verilog/SystemVerilog.
-- Para VHDL, vhdl_ls não formata; alternativa externa é `vhdl-formatter` (Node.js),
-- mas raramente disponível. Mantemos apenas verible aqui.

return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      verilog = { "verible_format" },
      systemverilog = { "verible_format" },
    },
    formatters = {
      verible_format = {
        command = vim.fn.stdpath("data") .. "/mason/bin/verible-verilog-format",
        args = { "-" },
        stdin = true,
      },
    },
  },
}
