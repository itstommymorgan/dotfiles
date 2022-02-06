-- Detect if I'm in a meeting, fire an mqtt command if so to update
-- homeassistant
ext.utils.meetings = {}
ext.utils.meetings.in_google_meet = false
ext.utils.meetings.in_zoom_meeting = false
ext.utils.meetings.mosquitto_url = "mosquitto.morgan.house"
ext.utils.meetings.mosquitto_topic = "home-assistant/zoom/in-meeting"
ext.utils.meetings.mosquitto_cmd = "/usr/local/bin/mosquitto_pub -h " .. ext.utils.meetings.mosquitto_url .. " -t " .. ext.utils.meetings.mosquitto_topic

function ext.utils.meetings.safe_dnd_on()
  out = hs.execute("plutil -convert xml1 -o - ~/Library/Preferences/ByHost/com.apple.notificationcenterui.*.plist | grep false")
  if string.find(out, "false") then
    hs.eventtap.keyStroke({"option", "shift"}, "d")
  end
end

function ext.utils.meetings.safe_dnd_off()
  out = hs.execute("plutil -convert xml1 -o - ~/Library/Preferences/ByHost/com.apple.notificationcenterui.*.plist | grep false")
  if string.find(out, "false") == nil then
    hs.eventtap.keyStroke({"option", "shift"}, "d")
  end
end

function ext.utils.meetings.notify(msg)
  cmd_string = ext.utils.meetings.mosquitto_cmd .. " -m \"" .. msg .. "\""
  hs.execute(cmd_string)
end

function ext.utils.meetings.in_meeting()
  ext.utils.meetings.notify("ON")
  ext.utils.meetings.safe_dnd_on()
  hs.execute('osascript -e \'tell application "Spotify" to pause\'')
end

function ext.utils.meetings.out_of_meeting()
  if not (ext.utils.in_google_meet or ext.utils.in_zoom_meeting) then
    ext.utils.meetings.notify("OFF")
    ext.utils.meetings.safe_dnd_off()
  end
end

wf_zoom_meeting = hs.window.filter.new('Zoom')
wf_zoom_meeting:setAppFilter('zoom.us', { allowTitles ='Zoom Meeting' })
wf_zoom_meeting:subscribe(hs.window.filter.hasWindow, function()
  ext.utils.meetings.in_zoom_meeting = true
  ext.utils.meetings.in_meeting()
end)

wf_zoom_meeting:subscribe(hs.window.filter.hasNoWindows, function()
  ext.utils.meetings.in_zoom_meeting = false
  ext.utils.meetings.out_of_meeting()
end)

ext.utils.meetings.chrome_watcher = hs.timer.doEvery(2, function()
  ret = ext.app.detectChromeUrl("meet.google.com", "false")()
  if ext.utils.meetings.in_google_meet == true then
    if ret == nil then
      ext.utils.meetings.in_google_meet = false
      ext.utils.meetings.out_of_meeting()
    end
  else
    if ret ~= nil then
      ext.utils.meetings.in_google_meet = true
      ext.utils.meetings.in_meeting()
    end
  end
end)
