-- Enter resize mode with Cmd+R, vim keys resize, Escape exits
rex.mode("resize", { exclusive = true })
rex.bind("cmd+r", "client.mode.enter", { name = "resize" })

rex.bind("resize/h", "pane.resize", { direction = "left" })
rex.bind("resize/l", "pane.resize", { direction = "right" })
rex.bind("resize/k", "pane.resize", { direction = "up" })
rex.bind("resize/j", "pane.resize", { direction = "down" })

-- Equalize all panes, Enter to exit
rex.bind("resize/=", "pane.balance")
rex.bind("resize/enter", "client.mode.exit")
