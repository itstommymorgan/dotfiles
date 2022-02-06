# What Does My Hammerspoon Do?

What doesn't it do, really?

[Hammerspoon](https://www.hammerspoon.org/) is an automation tool for MacOS. It
provides APIs and libraries to interact with the operating system in interesting
ways through the Lua scripting language.

You can do **a lot** of things with Hammerspoon, and I don't think I've even
really scratched the surface. But here's what I do with it now:

## Spoons and other "borrowed" code

Spoons are kind of like plugins for Hammerspoon - libraries that can easily be
imported.

### ControlEscape.spoon

This spoon allows the `Ctrl` key to be treated like `Esc` if it's hit in
isolation. Given that I have my `Caps Lock` key bound to `Ctrl`, this makes for
a much handier escape option in Vim (and in general).

### RecursiveBinder.spoon

This spoon allows for creating recursive keybindings quickly and easily, and
drives most of my keybinding setup.

### ReloadConfiguration.spoon

This spoon automatically reloads the Hammerspoon configuration when it changes,
which is handy when I'm doing edits.

### Shade.spoon

This spoon creates a transparent "shade" across the screen that artificially
lowers the brightness. Nice when I need to check my computer at night or in any
other dark environment.

### amphetamine.lua

While this isn't a spoon, it is a library that I stole from somewhere on the
internet. This creates a "caffeine" icon in the menubar that allows me to
disable the computer from sleeping.

### slowq.lua

Another borrowed library, this forces `Cmd-Q` to delay for a while before
closing the current application. With `Q` being right next to `W`, I often
accidentally hit `Q` when I really just wanted to close a tab or window - this
saves me from killing the whole application unless I really intend to.

## Customizations

Here are a few things I built custom for my needs:

### Meeting Watchers

See `meeting_checks.lua` for the full code. Basically this is a set of helper
functions, filters, and timed checks that can detect whenever I'm in a video
call. This powers some of my keyboard shortcuts (like the one I have to switch
to the current video call) and also communicates with my Home Assistant server,
so I use this detection to trigger a few things like Do Not Disturb on my Mac
as well as turning on an "on air" light in the hallway outside my office and
turning a lamp on at my desk so that my lighting is a little better. It
supports both Zoom meetings as well as Google Meets - although the Meet support
is a little hacky, since all I can do is check for the presence of a
`meet.google.com` tab every couple of seconds. But it works.

### 'Launch or Focus' applications

See `launch_or_focus.lua` for details. While I originally lifted a lot of this
code from someone else, I've adapted it a fair bit to make it work for my
use-cases. Basically this enables me to call an Application by name and have it
either focus (if it's currently running) or launch (if it's not). I also support
"toggling" applications in a smart way, this is used in keyboard shortcuts so
that I can use a single keyboard command to switch to an application and then
switch back from it. This is useful for stuff that I want to use in transit,
like Roam or Spotify.

## Chrome Tab Automation

See `chrome_tab_automation.lua`. Much like the 'Launch or Focus' utilities, this
file provides utility functions for interacting with Chrome tabs - namely it has
some kind of hacky ways to interact with Chrome to detect whether or not a tab
for a given URL exists, and it provides a similar "launch or Focus" method for
switching to URLs.

## Keybinder

This is basically a big wrapper around `hs.hotkey.bind` and
`RecursiveBinder.spoon` to abstract away a lot of common functionality - like
the above mentioned 'Launch or Focus' and 'Chrome Tab Automation' tools - to
allow me to communicate my keybindings in a clear way. The code is available in
`keybinder.lua` but you can see the keybindings themselves where keybinder is
called in `init.lua`.

## My Grid

See `my_grid.lua`. This is again _largely_ stolen, but it sets up a simple 2x2
window grid that I can use to move windows around if I need to. I don't find
this to be a huge part of my workflow currently but it's there if I need it.

## Other things

Again, most of this is visible in `init.lua`. Here are a few other things I have
configured (all in keybindings, of course):

### Alfred integration

A few keybindings that use Alfred's applescript integration to drive some easier
commands.

### Minor OSX niceties

A few keybindings for doing things like toggling the Do Not Disturb
functionality, closing all open notifications from the notification center.
