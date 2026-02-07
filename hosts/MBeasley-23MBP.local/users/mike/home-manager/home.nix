{config, ...}: {
  imports = [
    # shared modules in root of hosts dir
    ../../../../shared/software
    ../../../../shared/conf/sops
    # Per host modules
    ./software
  ];

  # Configure git persona
  gitConfig = {
    person = {
      gpgKey = "BB91DF43EC4CAE86";
    };
  };

  # Populate ~/.creds.d
  sopsSecrets = {
    zsh = {
      home = {
        enable = true;
      };
      work = {
        enable = true;
      };
    };
  };

  # Configure SSH agent socket and add work shell aliases
  zshConfig = {
    ssh.socketPath = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";
    workAliases.enable = true;
  };

  sops = {
    age = {
      keyFile = "${config.home.homeDirectory}/Library/Application Support/sops/age/keys.txt";
      sshKeyPaths = ["${config.home.homeDirectory}/.ssh/sops_ed25519"];
    };
    # Relative to home.nix config file
    defaultSopsFile = ./secrets/secrets.yaml;
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

      ".sops.yaml".text = ''
        keys:
          - &michaelbeasley age1w2szqkpqpurah7sc88xx0z3j2m068w6gryh6qh2vvpd5s9rd8uusppwsjr
        creation_rules:
          - path_regex: secrets/[^/]+\.(yaml|json|env|ini)$
            key_groups:
              - pgp:
                age:
                - *michaelbeasley
      '';
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
