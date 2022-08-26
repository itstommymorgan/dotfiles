-- Detect if I'm in a meeting, fire an mqtt command if so to update
-- homeassistant
ext.utils.meetings = {}
ext.utils.meetings.in_zoom_meeting = false
ext.utils.meetings.mosquitto_url = "mosquitto.morgan.house"
ext.utils.meetings.mosquitto_topic = "home-assistant/zoom/in-meeting"
ext.utils.meetings.mosquitto_cmd = "/usr/local/bin/mosquitto_pub -h " .. ext.utils.meetings.mosquitto_url .. " -t " .. ext.utils.meetings.mosquitto_topic

function ext.utils.meetings.safe_dnd_on()
  local out = hs.execute("plutil -convert xml1 -o - ~/Library/Preferences/ByHost/com.apple.notificationcenterui.*.plist | grep false")
  if string.find(out, "false") then
    hs.eventtap.keyStroke({"option", "shift"}, "d")
  end
end

function ext.utils.meetings.safe_dnd_off()
  local out = hs.execute("plutil -convert xml1 -o - ~/Library/Preferences/ByHost/com.apple.notificationcenterui.*.plist | grep false")
  if string.find(out, "false") == nil then
    hs.eventtap.keyStroke({"option", "shift"}, "d")
  end
end

function ext.utils.meetings.notify(msg)
  local cmd_string = ext.utils.meetings.mosquitto_cmd .. " -m \"" .. msg .. "\""
  hs.execute(cmd_string)
end

function ext.utils.meetings.in_meeting()
  ext.utils.meetings.notify("ON")
  ext.utils.meetings.safe_dnd_on()
  hs.execute('osascript -e \'tell application "Spotify" to pause\'')
end

function ext.utils.meetings.out_of_meeting()
  ext.utils.meetings.notify("OFF")
  ext.utils.meetings.safe_dnd_off()
end

local wf_zoom_meeting = hs.window.filter.new('Zoom')
wf_zoom_meeting:setAppFilter('zoom.us', { allowTitles ='Zoom Meeting' })
wf_zoom_meeting:subscribe(hs.window.filter.hasWindow, function()
  ext.utils.meetings.in_zoom_meeting = true
  ext.utils.meetings.in_meeting()
end)

wf_zoom_meeting:subscribe(hs.window.filter.hasNoWindows, function()
  ext.utils.meetings.in_zoom_meeting = false
  ext.utils.meetings.out_of_meeting()
end)
