-- We're gonna go recursive at some point
hs.loadSpoon("RecursiveBinder")
local singleKey = spoon.RecursiveBinder.singleKey

function ext.utils.app_function(appName)
  return function()
    ext.app.forceLaunchOrFocus(appName)
  end
end

function ext.utils.toggle_function(appName)
  return function()
    ext.app.toggleLaunchOrFocus(appName)
  end
end

function ext.utils.browser_function(url)
  exact = "true"
  wildcard = "*"
  if url:sub(-1) == wildcard then
    url = url:sub(1, -2)
    exact = "false"
  end

  return ext.app.forceLaunchOrOpenUrl(url, exact)
end

function ext.utils.build_map(map)
  local binding = {}
  hs.fnutils.each(map, function(entry)
    local key = entry.key
    local value = nil
    if entry.app ~= nil then
      value = ext.utils.app_function(entry.app)
    elseif entry.toggle ~= nil then
      value = ext.utils.toggle_function(entry.toggle)
    elseif entry.url ~= nil then
      value = ext.utils.browser_function(entry.url)
    elseif entry.fun ~= nil then
      value = entry.fun
    elseif entry.map ~= nil then
      value = ext.utils.build_map(entry.map)
    end

    binding[singleKey(key, entry.comment)] = value
  end)

  ext.tmp_binding = binding
  return binding
end

function ext.utils.jump_to_meeting()
  if ext.utils.meetings.in_zoom_meeting then
    ext.app.forceLaunchOrFocus("zoom.us")()
  elseif ext.utils.meetings.in_google_meet then
    ext.app.forceLaunchOrOpenUrl("meet.google.com", "false")()
  else
    ext.log:i("video call shortcut called but no call in progress.")
  end
end

-- given a map of keybindings, bind all of them to <hyper>-key
-- supports switching to apps, switching to urls, and also custom functions and
-- recursive bindings.
function ext.utils.keybinder(keybindings)
  ext.utils.keybindings = keybindings
  hs.fnutils.each(keybindings, function(keybinding)
    binding_fun = nil
    if keybinding.app ~= nil then
      binding_fun = ext.utils.app_function(keybinding.app)
    elseif keybinding.toggle ~= nil then
      binding_fun = ext.utils.toggle_function(keybinding.toggle)
    elseif keybinding.url ~= nil then
      binding_fun = ext.utils.browser_function(keybinding.url)
    elseif keybinding.fun ~= nil then
      binding_fun = keybinding.fun
    elseif keybinding.map ~= nil then
      binding_fun = spoon.RecursiveBinder.recursiveBind(ext.utils.build_map(keybinding.map))
    end

    if binding_fun == nil then
      ext.log:i("No valid binding found for key ✧" .. keybinding.key .. ".")
    else
      hs.hotkey.bind(ext.hyper, keybinding.key, keybinding.comment, binding_fun)
    end
  end)
end
