local M = {}

function M.parse_rdbg_sessions()
  local handle = io.popen("rdbg --util=list-socks-verbose 2>&1")
  if not handle then
    vim.notify("Failed to execute rdbg command", vim.log.levels.ERROR)
    return nil
  end

  local result = handle:read("*a")
  handle:close()

  local sessions = {}
  local current_session = nil

  for line in result:gmatch("[^\r\n]+") do
    local socket_path = line:match("^(/[^\n]+)$")
    if socket_path then
      current_session = { socket = socket_path }
    elseif current_session then
      local pid = line:match("PID:%s*(%d+)")
      local process = line:match("%$0:%s*([^,]+)")
      local session_name = line:match("session_name:%s*([^,]+)")

      if pid and process and session_name then
        current_session.pid = pid
        current_session.process = process:gsub("^%s+", ""):gsub("%s+$", "")
        current_session.session_name = session_name:gsub("^%s+", ""):gsub("%s+$", "")
        current_session.display =
          string.format("[%s] %s (PID: %s)", current_session.session_name, current_session.process, current_session.pid)
        table.insert(sessions, current_session)
        current_session = nil
      end
    end
  end

  return sessions
end

-- Map of session names to their DAP ports
local SESSION_PORTS = {
  services = 38698,
  -- Add other services here if you want them to use TCP too
}

-- Quick attach to services Rails server (recommended for services)
function M.attach_to_services_rails()
  local port = 38698

  -- Check if something is listening on the port
  local handle = io.popen("lsof -i :" .. port .. " 2>/dev/null")
  local result = handle and handle:read("*a") or ""
  if handle then
    handle:close()
  end

  if result == "" or not result:match("LISTEN") then
    vim.notify("No debugger found listening on port " .. port, vim.log.levels.WARN)
    vim.notify("Make sure your Rails server is running with RUBY_DEBUG_PORT=" .. port, vim.log.levels.INFO)
    return
  end

  -- Extract PID for display
  local pid = result:match("ruby%s+(%d+)")

  vim.notify(
    string.format("Connecting to Services Rails on port %d (PID: %s)...", port, pid or "unknown"),
    vim.log.levels.INFO
  )

  local dap = require("dap")

  dap.adapters.ruby_services = {
    type = "server",
    host = "127.0.0.1",
    port = port,
  }

  local config = {
    type = "ruby_services",
    request = "attach",
    name = "Attach to Services Rails",
    localfs = true,
  }

  dap.run(config)
end

-- For other services that still use Unix sockets
function M.attach_to_rdbg()
  local sessions = M.parse_rdbg_sessions()

  if not sessions or #sessions == 0 then
    vim.notify("No rdbg sessions found via Unix sockets", vim.log.levels.WARN)
    vim.notify("Use <leader>dS to connect to Services via TCP", vim.log.levels.INFO)
    return
  end

  vim.ui.select(sessions, {
    prompt = "Select rdbg session to attach:",
    format_item = function(item)
      return item.display
    end,
  }, function(selected)
    if not selected then
      return
    end

    -- Determine the port for this session
    local port = SESSION_PORTS[selected.session_name] or 38698

    vim.notify(string.format("Connecting to %s on port %d...", selected.display, port), vim.log.levels.INFO)

    local dap = require("dap")

    -- Create adapter for this session
    dap.adapters["ruby_attach_" .. selected.pid] = {
      type = "server",
      host = "127.0.0.1",
      port = port,
    }

    local config = {
      type = "ruby_attach_" .. selected.pid,
      request = "attach",
      name = "Attach to " .. selected.display,
      localfs = true,
    }

    dap.run(config)
  end)
end

return M
