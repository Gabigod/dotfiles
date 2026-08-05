-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("v", "<leader>yy", '"+y')
vim.keymap.set("n", "<leader>ya", 'gg<S-v>G"+y')
vim.keymap.set("n", "<leader>pp", '"+p')

-- ============================================================
-- PlatformIO + Overseer keymaps (ESP8266/ESP32/Arduino)
-- Prefixo <leader>c = Code/Compile (padrão LazyVim)
-- ============================================================
local map = vim.keymap.set

-- Build (PIO Build)
map("n", "<leader>pb", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "PIO Build" }, function(task)
      if task then overseer.open({ enter = false }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "PIO: Build project" })

-- Upload (PIO Upload)
map("n", "<leader>pu", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "PIO Upload" }, function(task)
      if task then overseer.open({ enter = false }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "PIO: Upload to device" })

-- Monitor Serial (PIO Monitor)
map("n", "<leader>pm", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "PIO Monitor" }, function(task)
      if task then overseer.open({ enter = true }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "PIO: Serial Monitor" })

-- Build + Upload (sequencial)
map("n", "<leader>pU", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "PIO Build & Upload" }, function(task)
      if task then overseer.open({ enter = false }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "PIO: Build & Upload" })

-- Clean
map("n", "<leader>pC", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "PIO Clean" }, function(task)
      if task then overseer.open({ enter = false }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "PIO: Clean build" })

-- Toggle Overseer panel
map("n", "<leader>pt", "<cmd>OverseerToggle<cr>", { desc = "PIO: Toggle task panel" })

-- Gerar compile_commands.json (para clangd LSP)
map("n", "<leader>pG", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "PIO CompileDB" }, function(task)
      if task then overseer.open({ enter = false }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "PIO: Generate compile_commands.json" })

-- ============================================================
-- Compilar/rodar: C/C++, Python, Lua, Rust, Go
-- ============================================================
map("n", "<leader>cc", function()
  vim.cmd("write")
  local file = vim.fn.expand("%")
  local ext = vim.fn.expand("%:e")

  if ext == "cpp" or ext == "c" or ext == "cc" or ext == "cxx" then
    local out = vim.fn.expand("%:r")
    -- Se o out não tem path (arquivo no cwd), prefixa com ./
    if not out:match("/") then
      out = "./" .. out
    end
    vim.cmd("term g++ " .. file .. " -o " .. out .. " -std=c++17 -Wall -Wextra && " .. out)
  elseif ext == "py" then
    vim.cmd("term python3 " .. file)
  elseif ext == "lua" then
    vim.cmd("term lua " .. file)
  elseif ext == "rs" then
    vim.cmd("term cargo run")
  elseif ext == "go" then
    vim.cmd("term go run " .. file)
  elseif ext == "js" then
    vim.cmd("term node " .. file)
  elseif ext == "ts" then
    vim.cmd("term npx tsx " .. file)
  else
    vim.notify("Nenhum runner configurado para ." .. ext, vim.log.levels.WARN)
  end
end, { desc = "Run: compile/execute current file" })
