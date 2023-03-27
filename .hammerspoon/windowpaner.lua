-- Be sure to define ext.utils.windowpaner_config in your init file before
-- requiring this file!!

local filters = {}

function ext.utils.windowpaner_poll()
  local displays = hs.screen.allScreens()

  if #displays < 2 then
    if #filters > 0 then
      hs.fnutils.each(filters, function(wf)
        wf:unsubscribe(hs.window.filter.hasWindow)
      end)
    end
  else
    ext.utils.build_windowpaner_filters()
  end
end

function ext.utils.clear_windowpaner_filters()
  if #filters == 0 then
    return
  end

  hs.fnutils.each(filters, function(wf)
    wf:unsubscribe(hs.window.filter.hasWindow)
  end)

  filters = {}
end

function ext.utils.build_windowpaner_filters()
  hs.fnutils.each(ext.utils.windowpaner_config, function(entry)
    local appName = entry.app
    local wf = hs.window.filter.new{appName}
    wf:subscribe(hs.window.filter.hasWindow, function(window)
      ext.utils.windowpaner_relocate(window, entry.screen, entry.fullScreen)
    end)
    table.insert(filters, wf)

    -- Now do a quick check to capture any existing windows
    app = hs.application.get(appName)
    if app then
      hs.fnutils.each(app:allWindows(), function(window)
        ext.utils.windowpaner_relocate(window, entry.screen, entry.fullScreen)
      end)
    end
  end)
end

function ext.utils.windowpaner_relocate(window, screen, fullScreen)
  local displays = hs.screen.allScreens()
  window:moveToScreen(displays[screen], false, true)
  if fullScreen then
    window:setFullScreen(true)
  end
end

ext.utils.windowpaner_poll()

hs.screen.watcher.new(function()
  ext.utils.windowpaner_poll()
end)
