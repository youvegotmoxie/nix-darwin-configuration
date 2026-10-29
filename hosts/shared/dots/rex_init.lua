-- Enter resize mode with Cmd+R, arrow keys resize, Escape exits
rex.mode("resize", { exclusive = true })
rex.bind("cmd+r", "client.mode.enter", { name = "resize" })

rex.bind("resize/left", "pane.resize", { direction = "left" })
rex.bind("resize/right", "pane.resize", { direction = "right" })
rex.bind("resize/up", "pane.resize", { direction = "up" })
rex.bind("resize/down", "pane.resize", { direction = "down" })

-- Shift for bigger steps (15% instead of default 5%)
rex.bind("resize/shift+left", "pane.resize", { direction = "left", amount = 15 })
rex.bind("resize/shift+right", "pane.resize", { direction = "right", amount = 15 })
rex.bind("resize/shift+up", "pane.resize", { direction = "up", amount = 15 })
rex.bind("resize/shift+down", "pane.resize", { direction = "down", amount = 15 })

-- Equalize all panes, Enter to exit
rex.bind("resize/=", "pane.balance")
rex.bind("resize/enter", "client.mode.exit")
