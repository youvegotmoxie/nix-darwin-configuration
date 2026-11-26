---@diagnostic disable: undefined-global
-- https://www.superlogical.com/rex/docs/customize/keyboard-shortcuts
-- Tmux-style binds, ctrl+a leader (re-implements Ghostty keybinds from ghostty_config)
rex.mode("tmux", { exclusive = true })
rex.bind("ctrl+a", "client.mode.enter", { name = "tmux", once = true })

-- Focus panes
rex.bind("tmux/h", "pane.focus", { direction = "left" })
rex.bind("tmux/j", "pane.focus", { direction = "down" })
rex.bind("tmux/k", "pane.focus", { direction = "up" })
rex.bind("tmux/l", "pane.focus", { direction = "right" })

-- Move panes
rex.bind("tmux/ctrl+l", "pane.move", { direction = "right" })
rex.bind("tmux/ctrl+h", "pane.move", { direction = "left" })
rex.bind("tmux/ctrl+j", "pane.move", { direction = "down" })
rex.bind("tmux/ctrl+k", "pane.move", { direction = "up" })

-- Splits
rex.bind("tmux/-", "pane.split", { direction = "down" })
rex.bind("tmux/shift+\\", "pane.split", { direction = "right" })
rex.bind("tmux/x", "pane.close")

-- Zoom and equalize
rex.bind("tmux/z", "pane.zoom")
rex.bind("tmux/e", "pane.balance")

-- Resize by 10 cells
rex.bind("tmux/shift+h", "pane.resize", { direction = "left", amount = 10 })
rex.bind("tmux/shift+j", "pane.resize", { direction = "down", amount = 10 })
rex.bind("tmux/shift+k", "pane.resize", { direction = "up", amount = 10 })
rex.bind("tmux/shift+l", "pane.resize", { direction = "right", amount = 10 })

-- Tabs
rex.bind("tmux/n", "client.tab.next")
rex.bind("tmux/p", "client.tab.previous")
rex.bind("tmux/c", "client.tab.new")
rex.bind("tmux/shift+x", "client.tab.close")

-- Sessions
rex.bind("tmux/shift+c", "session.new")
rex.bind("tmux/space", "session.next")
rex.bind("tmux/shift+space", "session.previous")

-- Send a literal ctrl+a
rex.bind("tmux/ctrl+a", "pane.send_key", { key = "ctrl+a" })

-- Shortcuts recorded in Rex
rex.bind("cmd+p", "client.palette.toggle")
