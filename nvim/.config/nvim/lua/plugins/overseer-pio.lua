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
  end,
}