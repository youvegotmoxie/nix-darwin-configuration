{config, ...}: {
  home.file."${config.home.homeDirectory}/Library/Application Support/com.mitchellh.ghostty/config".text = ''
    macos-titlebar-style = tabs
    theme = tokyonight
    font-family = "MesloLGS NF"
    font-size = 13
    cursor-style-blink = false
    cursor-style =
    link-url = true
    scrollback-limit = 100_000_000
    shell-integration = detect
    clipboard-read = allow
    clipboard-write = allow
    clipboard-paste-protection = true
    mouse-hide-while-typing = true
    confirm-close-surface = false
    quit-after-last-window-closed = true
    window-colorspace = display-p3
    keybind = global:cmd+grave_accent=toggle_quick_terminal
  '';
}
