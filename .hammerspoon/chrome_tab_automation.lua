-- detect whether or not a tab exists with the url, and if so return a tuple
-- with the window index and tab index
-- url: the url [pattern] to match
-- exact: a *string* with a "true" or "false" value to indicate whether or not
-- the url is expected to *exactly* match. Otherwise it matches any url that
-- *starts* with that pattern.
function ext.app.detectChromeUrl(url, exact)
  return function()
    result = hs.execute('osascript -l JavaScript -e "' .. [[
      var chrome = Application('Google Chrome');
      var wins = chrome.windows;

      // loop tabs to find a web page with a url starting with <url> (or exactly <url> if exact==true)
      function main() {
        for (var i = 0; i < wins.length; i++) {
          var win = wins.at(i);
          var tabs = win.tabs;
          for (var j = 0; j < tabs.length; j++) {
            var tab = tabs.at(j);
            rightTab = false;
            if (]] .. exact ..[[) {
              if (tab.url() == ']] .. url .. [[') {
                rightTab = true;
              }
            } else {
              if (tab.url().indexOf(']] .. url .. [[') > -1) {
                rightTab = true;
              }
            }

            if (rightTab) {
              return [i, j];
            }
          }
        }

        return null;
      }

      main();
    ]] .. '"')
    result = string.gsub(result, '%s+', '')
    if result == 'null' then
      return nil
    end
    return result:match("([^,]+),([^,]+)")
  end
end

-- Same arguments as the above function - this one will activate Chrome and
-- either switch to the matched tab or create a new one with the specified URL
-- if a tab doesn't already exist.
function ext.app.forceLaunchOrOpenUrl(url, exact)

  return function()
    win, tab = ext.app.detectChromeUrl(url, exact)()
    ext.log:i("tab is " .. hs.inspect(tab))
    if tab == nil then
      hs.execute('osascript -l JavaScript -e "' .. [[
        function main() {
          var chrome = Application('Google Chrome');
          chrome.activate();
          var wins = chrome.windows;
          var window = wins.at(0);
          window.tabs.push(new chrome.Tab());
          window.tabs[window.tabs.length - 1].url = ']] .. url .. [[';
          return 'no match, created new tab for ]] .. url .. [[';
        }

        main();
      ]] .. '"');
    else
      hs.execute('osascript -l JavaScript -e "' ..[[
        function main() {
          var chrome = Application('Google Chrome');
          chrome.activate();
          var wins = chrome.windows;
          win = wins.at(]] .. win .. [[);
          win.activeTabIndex = ]] .. tab .. [[ + 1;
        }

        main()
      ]] .. '"')
    end

    if ext.config.always_center_mouse then
      hs.timer.doAfter(0.2, ext.app.centerMouseOnActiveWindow)
    end
  end
end
