return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>o", group = "orgmode", icon = { icon = "󰦗 ", color = "green" } },
      },
    },
  },
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      require("orgmode").setup({
        org_agenda_files = { "~/org/**/*", "~/orgfiles/**/*" },
        org_default_notes_file = "~/org/refile.org",
      })
    end,
  },
}
