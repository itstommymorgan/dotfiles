-- Set up the logger

-- extensions, available in hammerspoon console
ext = {
  frame    = {},
  win      = {},
  app      = {},
  utils    = {},
  cache    = {},
  log = hs.logger.new('myconfig', 'info'),
  hyper = { "cmd", "alt", "ctrl", "shift" },
  watchers = {}
}

if hs.fs.attributes("~/.config/hammerspoon.json") == nil then
  hs.execute("cp ~/.hammerspoon/hammerspoon.json.defaults ~/.config/hammerspoon.json")
end

ext.config = hs.json.read("~/.config/hammerspoon.json")

-- Reload config automatically
hs.loadSpoon("ReloadConfiguration"):start()

-- toggle microphone mute
hs.loadSpoon("MicMute"):bindHotkeys({ toggle = {ext.hyper, "space"}})

-- caffeinate
require "amphetamine"

-- force *hold* of Cmd-Q to close apps
require "slowq"

-- Use Control as ESC if pressed in isolation
hs.loadSpoon('ControlEscape'):start()

-- Use a "Shade" to toggle screen brightness
hs.loadSpoon('Shade')

-- my custom function for launching/focusing a specific app
require "launch_or_focus"

-- my custom functions for manipulating chrome tabs
require "chrome_tab_automation"

-- window grid
require "my_grid"

if ext.config.meeting_checks then
  require "meeting_checks"
end

ext.utils.windowpaner_config = {
  { app = "Lunatask", screen = 2, fullScreen = true },
  { app = "Mimestream", screen = 2, fullScreen = true },
  { app = "Obsidian", screen = 2, fullScreen = true },
  { app = "Slack", screen = 2, fullScreen = true },
  { app = "Spotify", screen = 2, fullScreen = true },
  { app = "Vimcal", screen = 2, fullScreen = true },
}
require "windowpaner"

require "keybinder"

ext.utils.keybinder({
  { key = "1", comment = "Screen 1",
    fun = function()
      local displays = hs.screen.allScreens()
      local win = hs.window.focusedWindow()
      win:moveToScreen(displays[1], false, true)
    end
  },
  { key = "2", comment = "Screen 2",
    fun = function()
      local displays = hs.screen.allScreens()
      local win = hs.window.focusedWindow()
      win:moveToScreen(displays[2], false, true)
    end
  },
  { key = "a", comment = "Alfred...",
    map = {
      { key = "1", comment = "1password bookmark...",
        fun = function()
          hs.execute('osascript -e \'tell application "Alfred 4" to search "1p "\'')
        end
      },
      { key = "b", comment = "Bookmark Search...",
        fun = function()
          hs.execute('osascript -e \'tell application "Alfred 4" to search "bm "\'')
        end
      },
      { key = "c", comment = "Clipboard History",
        fun = function()
         hs.eventtap.keyStroke({"option", "command"}, "c")
       end
     },
    }
  },
  { key = "g", comment = "Go...",
    map = {
      { key = "a", comment = "mArvin",
        app = "Marvin"
      },
      { key = "b", comment = "Browser",
        app = "Google Chrome"
      },
      { key = "c", comment = "Calendar",
        app = "Vimcal"
      },
      { key = "i", comment = "IM-ish",
        map = {
          { key = "m", comment = "Messages",
            toggle = "Messages"
          },
          { key = "s", comment = "Signal",
            toggle = "Signal"
          },
          { key = "w", comment = "WhatsApp",
            toggle = "WhatsApp"
          }
        }
      },
      { key = "m", comment = "Mail",
        app = "Mimestream"
      },
      { key = "n", comment = "Notion",
        app = "Notion"
      },
      { key = "o", comment = "Obsidian",
        toggle = "Obsidian"
      },
      { key = "s", comment = "Slack",
        app = "slack"
      },
      { key = "u", comment = "mUsic",
        toggle = "Spotify"
      },
      { key = "t", comment = "Terminal",
        app = "Wezterm"
      },
      { key = "v", comment = "Video call",
        fun = ext.utils.jump_to_meeting
      }
    }
  },
  { key = "h", comment = "Hammerspoon",
    map = {
      { key = "c", comment = "Console",
        fun = function()
          hs.toggleConsole()
        end
      },
      { key = "e", comment = "Edit config",
        fun = function()
          hs.open(hs.configdir .. "/init.lua")
        end
      },
    }
  },
  { key = "m", comment = "Center Mouse",
    fun = ext.app.centerMouseOnActiveWindow
  },
  { key = "t", comment = "Toggle...",
    map = {
      { key = "c", comment = "Caffeinate",
        fun = function()
          caffeineClicked()
        end
      },
      { key = "d", comment = "Do Not Disturb",
        fun = function()
          hs.eventtap.keyStroke({"option", "shift"}, "d")
        end
      },
      { key = "n", comment = "close Notifications",
        fun = function()
          hs.execute("osascript -e '" ..
          [[my closeNotifications()
            on closeNotifications()
              tell application "System Events" to tell process "Notification Center"
                set theWindows to every window
                repeat with i from 1 to number of items in theWindows
                  set this_item to item i of theWindows
                  try
                    click button 1 of this_item
                  on error
                    my closeNotifications()
                  end try
                end repeat
              end tell
            end closeNotifications]] .. "'")
        end
      },
      { key = "s", comment = "Shade",
        fun = function()
          spoon.Shade:toggleShade()
        end
      }
    }
  },
  {
    key = "w", comment = "Window...",
    map = {
      { key = "h", comment = "Left",
        fun = function()
          my_grid.moveWindowToPosition(my_grid.screenPositions.left)
        end
      },
      { key = "j", comment = "Bottom",
        fun = function()
          my_grid.moveWindowToPosition(my_grid.screenPositions.bottom)
        end
      },
      { key = "k", comment = "Top",
        fun = function()
          my_grid.moveWindowToPosition(my_grid.screenPositions.top)
        end
      },
      { key = "l", comment = "Right",
        fun = function()
          my_grid.moveWindowToPosition(my_grid.screenPositions.right)
        end
      },
    }
  }
})
