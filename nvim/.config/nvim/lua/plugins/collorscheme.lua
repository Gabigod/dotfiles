return {
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      -- custom options here
    },
    config = function(_, opts)
      require("tokyodark").setup(opts) -- calling setup is optional
      vim.cmd([[colorscheme tokyodark]])
    end,
  },
  -- {
  --   "AlphaTechnolog/pywal.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     local pywal = require("pywal")
  --     pywal.setup()
  --     -- Define o pywal como o esquema de cores padrão
  --     vim.cmd("colorscheme pywal")
  --     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  --     vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  --     vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
  --     vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  --   end,
  -- },
  --
  -- {
  --   -- Mecanismo para o Neovim atualizar as cores em tempo real
  --   -- toda vez que você rodar o script 'themectl'
  --   "nvim-lua/plenary.nvim", -- Dependência comum, você provavelmente já tem
  --   config = function()
  --     local wal_cache = vim.fn.expand("~/.cache/wal/colors")
  --
  --     -- Autocomando que detecta quando o Neovim ganha foco (FocusGained)
  --     -- ou quando você entra em um arquivo (BufEnter)
  --     vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  --       pattern = "*",
  --       callback = function()
  --         -- Se o arquivo de cache do Pywal mudou, recarrega o colorscheme
  --         if vim.fn.filereadable(wal_cache) == 1 then
  --           require("pywal").setup()
  --           vim.cmd("colorscheme pywal")
  --         end
  --       end,
  --     })
  --   end,
  -- },
}
