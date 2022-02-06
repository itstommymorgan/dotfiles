ext.utils.notes_reminder = hs.timer.doEvery(300, function()
  hs.alert.show("Are you taking notes?")
end)
