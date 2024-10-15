-- Custom display order, if necessary
-- local screenOrder = { 1, 2, 3, 4 }

local screenOrder = {}
for i = 1, #hs.screen.allScreens() do
    screenOrder[i] = i
end

-- Indicate screes with same order with screenOrder
local screens = {}
for i = 1, #screenOrder do
    local screen = hs.screen.allScreens()[screenOrder[i]]
    -- hs.console.printStyledtext(screen)
    if screen then
        screens[i] = screen
    end
end

-- Get screen order defined in screenOrder
function getScreenOrder(s)
    for i = 1, #screens do
        if screens[i] == s then
            return i
        end
    end
    return nil
end

-- Window management like SizeUp
-- maximize current window
hs.hotkey.bind({ 'ctrl', 'alt', 'cmd' }, "m", function()
    local focusedWindow = hs.window.focusedWindow()
    if focusedWindow then
        focusedWindow:maximize()
    end
end)
-- center sized current window
hs.hotkey.bind({ 'ctrl', 'alt', 'cmd' }, "c", function()
    local focusedWindow = hs.window.focusedWindow()
    if focusedWindow then
        local screen = focusedWindow:screen()
        local max = screen:frame()
        focusedWindow:setSize(max.w / 2, max.h / 2)
        focusedWindow:centerOnScreen()
    end
end)
-- move current window to previous screen
hs.hotkey.bind({ 'ctrl', 'alt' }, "left", function()
    local focusedWindow = hs.window.focusedWindow()
    if focusedWindow then
        local screen = focusedWindow:screen()
        local order = getScreenOrder(screen)
        if order then
            local nextScreen = screens[(order - 2) % #screens + 1]
            focusedWindow:moveToScreen(nextScreen, false, true)
        end
    end
end)
-- move current window to next screen
hs.hotkey.bind({ 'ctrl', 'alt' }, "right", function()
    local focusedWindow = hs.window.focusedWindow()
    if focusedWindow then
        local screen = focusedWindow:screen()
        local order = getScreenOrder(screen)
        if order then
            local nextScreen = screens[order % #screens + 1]
            focusedWindow:moveToScreen(nextScreen, false, true)
        end
    end
end)
