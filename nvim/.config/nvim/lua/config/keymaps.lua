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
-- HDL: Verilog / SystemVerilog / VHDL (Overseer templates)
-- Prefixo <leader>h = HDL
-- ============================================================

-- Icarus Verilog: compilar testbench
map("n", "<leader>hi", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "HDL IVerilog Run" }, function(task)
      if task then overseer.open({ enter = false }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "HDL: IVerilog compile" })

-- Icarus Verilog: executar .vvp
map("n", "<leader>hI", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "HDL IVerilog Exec" }, function(task)
      if task then overseer.open({ enter = true }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "HDL: IVerilog run vvp" })

-- Verilator: lint
map("n", "<leader>hl", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "HDL Verilator Lint" }, function(task)
      if task then overseer.open({ enter = false }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "HDL: Verilator lint" })

-- GHDL: rodar VHDL
map("n", "<leader>hg", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "HDL GHDL Run" }, function(task)
      if task then overseer.open({ enter = true }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "HDL: GHDL simulate" })

-- QuestaSim/ModelSim
map("n", "<leader>hq", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "HDL QuestaSim Run" }, function(task)
      if task then overseer.open({ enter = true }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "HDL: QuestaSim run" })

-- UVM (VCS)
map("n", "<leader>hu", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "HDL UVM Run (VCS)" }, function(task)
      if task then overseer.open({ enter = true }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "HDL: UVM run (VCS)" })

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
  elseif ext == "v" or ext == "sv" or ext == "svh" then
    -- SystemVerilog/Verilog: compila com iverilog e simula com vvp
    local out = "sim.out"
    vim.cmd("term iverilog -g2012 -o " .. out .. " " .. file .. " && vvp " .. out)
  elseif ext == "vhd" or ext == "vhdl" then
    -- VHDL: analisa e simula com ghdl (se disponível)
    if vim.fn.executable("ghdl") == 1 then
      local entity = vim.fn.expand("%:t:r")
      vim.cmd("term ghdl -a --std=08 " .. file .. " && ghdl -e --std=08 " .. entity .. " && ghdl -r --std=08 " .. entity .. " --stop-time=1000ns")
    else
      vim.notify("GHDL não instalado. Instale: yay -S ghdl-llvm-git", vim.log.levels.WARN)
    end
  else
    vim.notify("Nenhum runner configurado para ." .. ext, vim.log.levels.WARN)
  end
end, { desc = "Run: compile/execute current file" })

-- ============================================================
-- HDL: keymaps para simulação Verilog/SystemVerilog/VHDL
-- Prefixo <leader>h = HDL
-- ============================================================

-- Icarus: compilar + simular arquivo atual
map("n", "<leader>hs", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "HDL Icarus Compile & Simulate" }, function(task)
      if task then overseer.open({ enter = false }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "HDL: Icarus compile & simulate" })

-- Icarus: apenas compilar
map("n", "<leader>hc", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "HDL Icarus Compile" }, function(task)
      if task then overseer.open({ enter = false }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "HDL: Icarus compile" })

-- Verilator: lint do arquivo atual
map("n", "<leader>hl", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "HDL Verilator Lint" }, function(task)
      if task then overseer.open({ enter = false }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "HDL: Verilator lint" })

-- Verilator: simular ( precisa de top + testbench )
map("n", "<leader>hv", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "HDL Verilator Simulate" }, function(task)
      if task then overseer.open({ enter = false }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "HDL: Verilator simulate" })

-- GHDL: analisar + simular VHDL (se disponvel)
map("n", "<leader>hg", function()
  local ok, overseer = pcall(require, "overseer")
  if ok then
    overseer.run_template({ name = "HDL GHDL Simulate" }, function(task)
      if task then overseer.open({ enter = false }) end
    end)
  else
    vim.notify("Overseer não carregado", vim.log.levels.WARN)
  end
end, { desc = "HDL: GHDL simulate (VHDL)" })

-- Formatar com Verible
map("n", "<leader>hf", function()
  vim.cmd("Format")
end, { desc = "HDL: Format with Verible" })
