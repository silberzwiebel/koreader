-- don't enable the plugin, it doesn't work yet
if true then
    return { disabled = true, }
end

local InfoMessage = require("ui/widget/infomessage")  -- luacheck:ignore
local UIManager = require("ui/uimanager")
local WidgetContainer = require("ui/widget/container/widgetcontainer")
local _ = require("gettext")
local Device = require("device")
local logger = require("logger")

local NoTouch = WidgetContainer:new{
    name = 'notouch',
    is_doc_only = false,
    event_handlers = nil
}

function NoTouch:init()
    self.ui.menu:registerToMainMenu(self)
    self.event_handlers = {
        --~ __default__ = function(input_event)
            --~ self:sendEvent(input_event)
        --~ end,
        TOGGLE = self.toggleTouch()
			}
end

function NoTouch:addToMainMenu(menu_items)
    menu_items.no_touch = {
        text = _("disable touch"),
        callback = function() self:toggleTouch() end,
    }
end

function NoTouch:toggleTouch()
	if not Device.screen_saver_mode then
		Device.screen_saver_mode = true
		UIManager:show(InfoMessage:new{text = _("touch is disabled"),})
		logger.dbg("NoTouch: device is not in screen saver mode; sending device to suspend mode")
		UIManager:suspend()
	else
		Device.screen_saver_mode = false
		UIManager:show(InfoMessage:new{text = _("touch is enabled"),})
		logger.dbg("NoTouch: device is in screen saver mode, resume device")
		UIManager:resume()
	end
end

--         if not G_reader_settings:readSetting("ignore_power_sleepcover") then
					--~ self.event_handlers["SleepCoverClosed"] = function()
							--~ Device.is_cover_closed = true
							--~ self:suspend()
					--~ end

					--~ event_map = {
            --~ [59] = "SleepCover",
            --~ [90] = "LightButton",
            --~ [102] = "Home",
            --~ [116] = "Power",
        --~ },


return NoTouch
