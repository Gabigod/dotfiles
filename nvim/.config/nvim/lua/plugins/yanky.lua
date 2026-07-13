return {
  {
    "gbprod/yanky.nvim",
    keys = {
      -- Desativa o mapeamento original do LazyVim
      { "<leader>p", false },
      -- Define o novo mapeamento
      {
        "<leader>ph",
        function()
          -- Lógica nativa para respeitar o picker padrão que você estiver usando
          if LazyVim.pick.picker.name == "telescope" then
            require("telescope").extensions.yank_history.yank_history({})
          elseif LazyVim.pick.picker.name == "snacks" then
            Snacks.picker.yanky()
          else
            vim.cmd([[YankyRingHistory]])
          end
        end,
        mode = { "n", "x" },
        desc = "Open Yank History",
      },
    },
  },
}
