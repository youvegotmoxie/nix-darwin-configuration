{config, ...}: {
  imports = [
    # shared modules in root of hosts dir
    ../../../../shared/software
    # Per host modules
    ./software
  ];

  # Configure git persona
  gitConfig = {
    person = {
      gpgKey = "BB91DF43EC4CAE86";
    };
  };

  # Configure SSH agent socket and add work shell aliases
  zshConfig = {
    ssh.socketPath = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";
    workAliases.enable = true;
  };

  home = {
    stateVersion = "25.05";
    sessionPath = [
      "$HOME/.krew"
    ];

    file = {
      # Disabled since I'm using tmux from nixpkgs
      # ".tmux.conf".source = ../../../../shared/dots/dot_tmux.conf;
      "shell.nix".source = ../../../../shared/dots/shell.nix;
      ".vimrc".source = ../../../../shared/dots/dot_vimrc;
      ".zsh.d/func.zsh".source = ../../../../shared/dots/func.zsh;
      ".restic/exclude.lst".source = ./conf/exclude.lst;

      "${config.home.homeDirectory}/Library/Application Support/com.mitchellh.ghostty/config".text = ''
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
    };
  };
}
