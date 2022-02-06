function ext.utils.windowpaner(map)
  local displays = hs.screen.allScreens()
  hs.fnutils.each(map, function(entry)
    local appName = entry.app
    local screen = entry.screen
    local fullScreen = entry.fullScreen

    local wf = hs.window.filter.new{appName}
    wf:subscribe(hs.window.filter.windowCreated, function(window)
      window:moveToScreen(displays[screen], false, true)
      if fullScreen then
        window:setFullScreen(true)
      end
    end)
  end)
end
