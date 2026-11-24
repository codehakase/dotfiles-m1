-- Migrated tmux shortcuts. Keep Rex defaults for all other keys.
-- ctrl+a is a sequence prefix; press it twice to send it to the terminal.
rex.bind("ctrl+a>ctrl+a", "pane.send_key", { key = "ctrl+a" })

rex.bind("shift+down", "client.tab.new")
rex.bind("shift+left", "client.tab.previous")
rex.bind("shift+right", "client.tab.next")
rex.bind("ctrl+a>c", "client.tab.new")
rex.bind("ctrl+a>shift+s", "session.switch")
rex.bind("ctrl+a>space", "client.tab.next")
rex.bind("ctrl+a>backspace", "client.tab.previous")
rex.bind("ctrl+a>v", "pane.split", { direction = "right" })
rex.bind("ctrl+a>s", "pane.split", { direction = "down" })
rex.bind("ctrl+a>h", "pane.focus", { direction = "left" })
rex.bind("ctrl+a>j", "pane.focus", { direction = "down" })
rex.bind("ctrl+a>k", "pane.focus", { direction = "up" })
rex.bind("ctrl+a>l", "pane.focus", { direction = "right" })
rex.bind("alt+h", "session.previous")
rex.bind("alt+l", "session.next")
