{
  pkgs,
  config,
  ...
}: let
in {
  imports = [
    # Per host modules
    ./software
  ];

  # Configure git persona
  gitConfig.person = {
    name = "MikeB";
    email = "youvegotmoxie@gmail.com";
  };

  # Configure SSH agent socket
  zshConfig.bw.socketPath = "${config.home.homeDirectory}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";

  home = {
    stateVersion = "25.05";

    file = {
      ".zsh.d/func.zsh".source = ./dots/func.zsh;

      "${config.home.homeDirectory}/Library/Application Support/com.mitchellh.ghostty/config".text = ''
        macos-titlebar-style = tabs
        theme = tokyonight
        font-family = "MesloLGS NF"
        cursor-style-blink = false
        cursor-style =
        scrollback-limit = 100_000_000
        shell-integration = detect
        clipboard-read = allow
        clipboard-write = allow
        clipboard-paste-protection = false
        mouse-hide-while-typing = true
        confirm-close-surface = false
        quit-after-last-window-closed = true
        window-colorspace = display-p3
        keybind = global:cmd+grave_accent=toggle_quick_terminal
      '';
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
  };
}
