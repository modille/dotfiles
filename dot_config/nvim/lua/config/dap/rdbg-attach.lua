local M = {}

-- Parse rdbg sessions from Unix sockets
function M.parse_rdbg_sessions()
  local handle = io.popen("rdbg --util=list-socks-verbose 2>/dev/null")
  if not handle then
    return {}
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
      local session_name = line:match("session_name:%s*([^%s,]+)")

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

-- Quick attach to services Rails server (socket-based)
function M.attach_to_services_rails()
  local sessions = M.parse_rdbg_sessions()

  -- Find the services Rails session (bin/rails process with session_name "services")
  local rails_session = nil
  for _, session in ipairs(sessions) do
    if session.session_name == "services" and session.process:match("bin/rails") then
      rails_session = session
      break
    end
  end

  if not rails_session then
    vim.notify("No Services Rails debugger session found", vim.log.levels.WARN)
    vim.notify("Make sure your Rails server is running with debug enabled", vim.log.levels.INFO)
    return
  end

  vim.notify(string.format("Connecting to %s via socket...", rails_session.display), vim.log.levels.INFO)

  local dap = require("dap")

  -- Create socket-based adapter
  dap.adapters.ruby_services = {
    type = "pipe",
    pipe = rails_session.socket,
  }

  local config = {
    type = "ruby_services",
    request = "attach",
    name = "Attach to Services Rails",
    localfs = true,
  }

  dap.run(config)
end

-- Generic attach with session picker (socket-based)
function M.attach_to_rdbg()
  local sessions = M.parse_rdbg_sessions()

  if not sessions or #sessions == 0 then
    vim.notify("No rdbg sessions found", vim.log.levels.WARN)
    vim.notify("Make sure your Rails server or Sidekiq is running with debug enabled", vim.log.levels.INFO)
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

    vim.notify(string.format("Connecting to %s via socket...", selected.display), vim.log.levels.INFO)

    local dap = require("dap")

    -- Create socket-based adapter for this session
    dap.adapters["ruby_attach_" .. selected.pid] = {
      type = "pipe",
      pipe = selected.socket,
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
