{config, ...}: {
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
  zshConfig.ssh.socketPath = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";

  home = {
    stateVersion = "25.05";

    file = {
      ".zsh.d/func.zsh".source = ./dots/func.zsh;
      ".vimrc".source = ../../../../shared/dots/dot_vimrc;

      "${config.home.homeDirectory}/Library/Application Support/com.mitchellh.ghostty/config".text = ''
        macos-titlebar-style = tabs
        theme = tokyonight
        font-family = "MesloLGS NF"
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
    };
  };

  # Using Helix as the default $EDITOR
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.git = {
    enable = true;
    lfs.enable = false;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
