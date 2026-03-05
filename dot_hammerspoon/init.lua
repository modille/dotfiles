local mods = { 'cmd', 'ctrl' }
local ignored = { ['Wispr Flow'] = true } -- steals focus when far away for some reason

local function candidates()
  return hs.fnutils.filter(hs.window.visibleWindows(), function(w)
    return not ignored[w:application():name()]
  end)
end

hs.hotkey.bind(mods, 'w', function()
  hs.window.focusedWindow():focusWindowNorth(candidates())
end)
hs.hotkey.bind(mods, 'a', function()
  hs.window.focusedWindow():focusWindowWest(candidates())
end)
hs.hotkey.bind(mods, 's', function()
  hs.window.focusedWindow():focusWindowSouth(candidates())
end)
hs.hotkey.bind(mods, 'd', function()
  hs.window.focusedWindow():focusWindowEast(candidates())
end)
