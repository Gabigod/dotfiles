-- Linting para HDL
--
-- Nota: Verible LSP já provê diagnósticos em tempo real para Verilog/SystemVerilog.
-- vhdl_ls também provê diagnósticos para VHDL.
-- Por isso Não configuramos nvim-lint para HDL — usamos o template Overseer
-- "HDL Verilator Lint" para lint sob demanda com mais regras (-Wall).
--
-- Este arquivo existe apenas para estender nvim-lint no futuro, se necessário.

return {
  "mfussenegger/nvim-lint",
  opts = {
    -- Adicione linters HDL aqui se quiser diagnósticos extras em tempo real
    -- (atualmente desativado para evitar duplicação com LSP Verible/vhdl_ls)
    linters_by_ft = {},
  },
}
