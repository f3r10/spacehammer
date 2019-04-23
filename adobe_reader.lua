local windows = require "windows"
local keybindings = require "keybindings"

local adobeReaderAppHotKeys = {}

-- j/k for scrolling up and down
for k, dir in pairs({j = -3, k = 3}) do
  local function scrollFn()
	windows.setMouseCursorAtApp("Acrobat Reader")
	hs.eventtap.scrollWheel({0, dir}, {})
  end
  table.insert(adobeReaderAppHotKeys, hs.hotkey.new("", k, scrollFn, nil, scrollFn))
end

for k, dir in pairs({n = "down", p = "up"}) do
  local function scrollPage()
	hs.eventtap.keyStroke({"shift"}, dir)
  end
  table.insert(adobeReaderAppHotKeys, hs.hotkey.new("", k, scrollPage, nil, scrollPage))
end

for k, dir in pairs({o = "Previous", i = "Next"}) do
  local function previousOrNextPage()
	local app = hs.window.focusedWindow():application()
	app:selectMenuItem({"Go", dir .. " Item"})
  end
  table.insert(adobeReaderAppHotKeys, hs.hotkey.new({"ctrl"}, k, previousOrNextPage, nil, previousOrNextPage))
end

-- enable/disable hotkeys
keybindings.appSpecific["Acrobat Reader"] = {
  activated = function()
	for _,k in pairs(adobeReaderAppHotKeys) do
	  keybindings.activateAppKey("Acrobat Reader", k)
	end
  end,
  deactivated = function() keybindings.deactivateAppKeys("Acrobat Reader") end,
}
