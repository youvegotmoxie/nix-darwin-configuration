{config, ...}: {
  home.file."${config.home.homeDirectory}/Library/Application Support/com.mitchellh.ghostty/config".text = ''
    # https://ghostty.org/docs/config/reference
    # ghostty +show-config
    clipboard-paste-protection = true
    clipboard-read = allow
    clipboard-write = allow
    confirm-close-surface = false
    cursor-style = block
    cursor-style-blink = false
    font-family = "MesloLGS NF"
    font-size = 12
    link-url = true
    macos-icon = retro
    macos-titlebar-style = tabs
    mouse-hide-while-typing = true
    quit-after-last-window-closed = true
    scrollback-limit = 100_000_000
    shell-integration = detect
    shell-integration-features = no-cursor
    theme = tokyonight
    window-colorspace = display-p3
    window-save-state = always

    # Mimic Tmux keybinds for Ghostty's native multiplexing
    # https://ghostty.org/docs/config/keybind
    # ghostty +list-keybinds
    keybind = ctrl+a>h=goto_split:left
    keybind = ctrl+a>j=goto_split:bottom
    keybind = ctrl+a>k=goto_split:top
    keybind = ctrl+a>l=goto_split:right
    keybind = ctrl+a>-=new_split:down
    keybind = ctrl+a>shift+\=new_split:right
    keybind = ctrl+a>shift+z=toggle_split_zoom
    keybind = ctrl+a>n=next_tab
    keybind = ctrl+a>p=previous_tab
    keybind = ctrl+shift+k=resize_split:up,30
    keybind = ctrl+shift+j=resize_split:down,30
    keybind = ctrl+shift+h=resize_split:left,30
    keybind = ctrl+shift+l=resize_split:right,30
    keybind = ctrl+a>e=equalize_splits
    keybind = global:cmd+grave_accent=toggle_quick_terminal
  '';
}
