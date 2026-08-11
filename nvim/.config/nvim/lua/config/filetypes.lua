-- Mapeamentos de filetype para HDL (VHDL, Verilog, SystemVerilog)
-- Garante que extensões comuns sejam reconhecidas pelo Neovim.
vim.filetype.add({
  extension = {
    -- Verilog / SystemVerilog
    v = "verilog",
    V = "verilog",
    vg = "verilog",
    sv = "systemverilog",
    SV = "systemverilog",
    svh = "systemverilog",
    SVH = "systemverilog",
    vhd = "vhdl",
    vhdl = "vhdl",
    vho = "vhdl",
    -- SystemVerilog assert/UVM
    svt = "systemverilog",
    -- Verilog testbench (uso comum)
    vt = "verilog",
  },
  filename = {
    -- Arquivos sem extensão comuns em projetos HDL
    -- (normalmente não aplicável, mas útil para cobertura)
  },
})

-- Diagnosis: log para debug
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "verilog", "systemverilog", "vhdl" },
--   callback = function(args)
--     vim.notify(string.format("[HDL.ft] filetype=%s buf=%d", vim.bo[args.buf].filetype, args.buf), vim.log.levels.DEBUG)
--   end,
-- })
