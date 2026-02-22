{ config, ... }:
{
  imports = [
    # shared modules in root of hosts dir
    ../../../../shared/software
    # Per host modules
    ./software
  ];

  # Configure gpg-agent
  gpgConfig = {
    pubKey = "26693209BA633C80";
    sshKeys = [ "FA2DB0DD531C864082BD10F5C936E7BFD93BA80A" ];
  };
  # Configure git persona
  gitConfig = {
    person = {
      name = "Michael Beasley";
      email = "youvegotmoxie@gmail.com";
      gpgKey = "A6B4C8E1BAEA348F";
    };
  };

  # Configure SSH agent socket
  zshConfig = {
    ssh.socketPath = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";
    workAliases.enable = false;
  };

  home = {
    stateVersion = "25.05";

    file = {
      ".zsh.d/func.zsh".source = ../../../../shared/dots/func.zsh;
      ".vimrc".source = ../../../../shared/dots/dot_vimrc;

      "${config.home.homeDirectory}/Library/Application Support/com.mitchellh.ghostty/config".text = ''
        macos-titlebar-style = tabs
        theme = tokyonight
        font-family = "MesloLGS NF"
        cursor-style-blink = false
        font-size = 13
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
