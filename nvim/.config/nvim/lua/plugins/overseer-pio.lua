-- Overseer template para PlatformIO (ESP32/ESP8266/Arduino AVR)
-- Salve em: ~/.config/nvim/lua/plugins/overseer-pio.lua
-- Adicione ao lazyvim plugins: { import = "plugins.overseer-pio" }

return {
  "stevearc/overseer.nvim",
  config = function(_, opts)
    local overseer = require("overseer")
    overseer.setup(opts)

    local templates = {
      -- Build do projeto (pio run)
      {
        name = "PIO Build",
        builder = function(params)
          return {
            cmd = { "pio", "run", "-e", params.env },
            components = { "default" },
          }
        end,
        params = {
          env = {
            type = "list",
            choices = { "esp32", "esp8266", "uno", "nano", "d1_mini" },
            default = "esp32",
            desc = "Environment do platformio.ini",
          },
        },
        condition = {
          callback = function()
            return vim.fn.filereadable(vim.fn.getcwd() .. "/platformio.ini") == 1
          end,
        },
      },
      -- Upload (pio run -t upload)
      {
        name = "PIO Upload",
        builder = function(params)
          return {
            cmd = { "pio", "run", "-e", params.env, "-t", "upload" },
            components = { "default" },
          }
        end,
        params = {
          env = {
            type = "list",
            choices = { "esp32", "esp8266", "uno", "nano", "d1_mini" },
            default = "esp32",
            desc = "Environment do platformio.ini",
          },
        },
        condition = {
          callback = function()
            return vim.fn.filereadable(vim.fn.getcwd() .. "/platformio.ini") == 1
          end,
        },
      },
      -- Monitor Serial (pio device monitor)
      {
        name = "PIO Monitor",
        builder = function(params)
          return {
            cmd = { "pio", "device", "monitor", "-e", params.env },
            components = {
              "default",
              { "on_output_quickfix", open = false },
            },
          }
        end,
        params = {
          env = {
            type = "list",
            choices = { "esp32", "esp8266", "uno", "nano", "d1_mini" },
            default = "esp32",
            desc = "Environment do platformio.ini",
          },
        },
        condition = {
          callback = function()
            return vim.fn.filereadable(vim.fn.getcwd() .. "/platformio.ini") == 1
          end,
        },
      },
      -- Clean (pio run -t clean)
      {
        name = "PIO Clean",
        builder = function(params)
          return {
            cmd = { "pio", "run", "-e", params.env, "-t", "clean" },
            components = { "default" },
          }
        end,
        params = {
          env = {
            type = "list",
            choices = { "esp32", "esp8266", "uno", "nano", "d1_mini" },
            default = "esp32",
            desc = "Environment do platformio.ini",
          },
        },
        condition = {
          callback = function()
            return vim.fn.filereadable(vim.fn.getcwd() .. "/platformio.ini") == 1
          end,
        },
      },
      -- Build + Upload (sequencial)
      {
        name = "PIO Build & Upload",
        builder = function(params)
          return {
            cmd = { "pio", "run", "-e", params.env },
            components = {
              { "on_complete_dispose", statuses = { "SUCCESS" } },
              "default",
            },
          }
        end,
        params = {
          env = {
            type = "list",
            choices = { "esp32", "esp8266", "uno", "nano", "d1_mini" },
            default = "esp32",
            desc = "Environment do platformio.ini",
          },
        },
        condition = {
          callback = function()
            return vim.fn.filereadable(vim.fn.getcwd() .. "/platformio.ini") == 1
          end,
        },
      },
      -- CompileDB generation (pio run -t compiledb)
      {
        name = "PIO CompileDB",
        builder = function(params)
          return {
            cmd = { "pio", "run", "-e", params.env, "-t", "compiledb" },
            components = { "default" },
          }
        end,
        params = {
          env = {
            type = "list",
            choices = { "esp32", "esp8266", "uno", "nano", "d1_mini" },
            default = "esp32",
            desc = "Environment do platformio.ini",
          },
        },
        condition = {
          callback = function()
            return vim.fn.filereadable(vim.fn.getcwd() .. "/platformio.ini") == 1
          end,
        },
      },
    }

    -- Adiciona templates ao overseer
    for _, tmpl in ipairs(templates) do
      overseer.register_template(tmpl)
    end

    -- ============================================================
    -- Templates HDL: Verilog / SystemVerilog / VHDL / UVM
    -- Simuladores: Icarus Verilog, Verilator, GHDL, QuestaSim, VCS (UVM)
    -- ============================================================
    overseer.register_template({
      name = "HDL IVerilog Run",
      builder = function(params)
        local file = vim.fn.expand("%:p")
        local out = "/tmp/" .. vim.fn.expand("%:t:r") .. ".vvp"
        local cmd = { "iverilog", "-g2012", "-o", out, file }
        if params.top and params.top ~= "" then
          table.insert(cmd, 1, "-s")
          table.insert(cmd, 2, params.top)
        end
        return { cmd = cmd, components = { "default" } }
      end,
      params = {
        top = { type = "string", default = "", desc = "Top module name (opcional)" },
      },
      condition = { filetype = { "verilog", "systemverilog" } },
    })

    overseer.register_template({
      name = "HDL IVerilog Exec",
      builder = function()
        return {
          cmd = { "vvp", "/tmp/" .. vim.fn.expand("%:t:r") .. ".vvp" },
          components = { "default" },
        }
      end,
      condition = { filetype = { "verilog", "systemverilog" } },
    })

    overseer.register_template({
      name = "HDL Verilator Lint",
      builder = function()
        return {
          cmd = { "verilator", "--lint-only", "-Wall", vim.fn.expand("%:p") },
          components = { "default" },
        }
      end,
      condition = { filetype = { "verilog", "systemverilog" } },
    })

    overseer.register_template({
      name = "HDL GHDL Run",
      builder = function(params)
        local file = vim.fn.expand("%:p")
        local top = (params.top and params.top ~= "") and params.top or vim.fn.expand("%:t:r")
        return {
          cmd = { "bash", "-c", string.format(
            "ghdl -a %s && ghdl -e %s && ghdl -r %s --stop-time=%s",
            vim.fn.shellescape(file), vim.fn.shellescape(top),
            vim.fn.shellescape(top), params.stop_time
          ) },
          components = { "default" },
        }
      end,
      params = {
        top = { type = "string", default = "", desc = "Top entity name (padrão: nome do arquivo)" },
        stop_time = { type = "string", default = "1us", desc = "Stop time (ex: 1us, 100ns)" },
      },
      condition = { filetype = { "vhdl" } },
    })

    overseer.register_template({
      name = "HDL QuestaSim Run",
      builder = function(params)
        local top = (params.top and params.top ~= "") and params.top or vim.fn.expand("%:t:r")
        return {
          cmd = { "vsim", "-c", "-do",
            string.format("vlog %%s; vsim -c %%s; run -all; quit -f", top) },
          components = { "default" },
        }
      end,
      params = { top = { type = "string", default = "", desc = "Top module/entity name" } },
      condition = { callback = function() return vim.fn.executable("vsim") == 1 end },
    })

    overseer.register_template({
      name = "HDL UVM Run (VCS)",
      builder = function()
        return {
          cmd = { "bash", "-c", string.format(
            "vcs -sverilog -ntb_opts uvm +incdir+$UVM_HOME %s && ./simv",
            vim.fn.shellescape(vim.fn.expand("%:p"))
          ) },
          components = { "default" },
        }
      end,
      condition = {
        filetype = { "systemverilog" },
        callback = function() return vim.fn.executable("vcs") == 1 end,
      },
    })
  end,
}