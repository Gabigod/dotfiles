return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "mason-org/mason.nvim",
  },
  keys = {
    { "<F5>", function() require("dap").continue() end, desc = "DAP: Continue/Start" },
    { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle Breakpoint" },
    { "<F10>", function() require("dap").step_over() end, desc = "DAP: Step Over" },
    { "<F11>", function() require("dap").step_into() end, desc = "DAP: Step Into" },
    { "<F12>", function() require("dap").step_out() end, desc = "DAP: Step Out" },
    { "<leader>du", function() require("dapui").toggle() end, desc = "DAP: Toggle UI" },
    { "<leader>dr", function() require("dap").repl.open() end, desc = "DAP: Open REPL" },
    { "<leader>db", function() require("dap").list_breakpoints() end, desc = "DAP: List Breakpoints" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- UI setup
    dapui.setup()
    require("nvim-dap-virtual-text").setup()

    -- Auto open/close UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Signs for breakpoints
    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticOk", linehl = "CursorLine", numhl = "" })
  end,
}