-- LSP: Verilog, SystemVerilog, VHDL
--
-- Servidores:
--   verible-verilog-ls  (Mason)    — Verilog + SystemVerilog
--   vhdl_ls             (cargo)    — VHDL (cargo install vhdl_ls)
--   svlangserver        (opcional) — SystemVerilog avançado (UVM)
--
-- LazyVim moderno usa vim.lsp.config() + vim.lsp.enable().
-- Basta declarar opts.servers.<name> = {...}; o LazyVim encaminha.
-- Para root_dir, usamos a funcao sincrona (retorna path) com fallback
-- para o diretorio do arquivo — estilo compativel com Neovim 0.11+.

local function hdl_root(fname)
  local root = vim.fs.dirname(fname)
  -- Sobe para raiz .git se houver
  local git = vim.fs.find({ ".git" }, { upward = true, path = root, type = "directory" })
  if git and git[1] then
    return vim.fs.dirname(git[1])
  end
  -- Procura marcadores HDL em ancestrais
  local markers = vim.fs.find(
    { "vhdl_ls.toml", "verible.filelist", "fusesoc_build.fusesoc.info" },
    { upward = true, path = root, limit = 3 }
  )
  if markers and markers[1] then
    return vim.fs.dirname(markers[1])
  end
  return root
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Verible: Verilog + SystemVerilog unificado
        verible = {
          cmd = { vim.fn.stdpath("data") .. "/mason/bin/verible-verilog-ls" },
          filetypes = { "verilog", "systemverilog" },
          root_dir = function(buf, on_dir)
            local fname = vim.api.nvim_buf_get_name(buf)
            if on_dir then
              on_dir(hdl_root(fname))
            else
              return hdl_root(fname)
            end
          end,
          settings = {},
        },
        -- VHDL Language Server (vhdl_ls) — instalar via: cargo install vhdl_ls
        vhdl_ls = {
          cmd = { "vhdl_ls" },
          filetypes = { "vhdl" },
          root_dir = function(buf, on_dir)
            local fname = vim.api.nvim_buf_get_name(buf)
            if on_dir then
              on_dir(hdl_root(fname))
            else
              return hdl_root(fname)
            end
          end,
          settings = {},
          -- não instalar via mason; forçar enable manual abaixo
          mason = false,
        },
      },
    },
  },
}
