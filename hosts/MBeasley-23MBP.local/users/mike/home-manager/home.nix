{
  pkgs,
  config,
  ...
}: let
  backupRepo = "MBeasley-23MBP.local";
  backupBasePath = "/opt/storage/backups/remote/${backupRepo}";
  backupPath = "${backupBasePath}";
  backupServer = "192.168.148.112";
  resticRemoteUser = "mike";
in {
  imports = [
    # shared modules in root of hosts dir
    ../../../../shared/software
    ../../../../shared/conf/sops
    # Per host modules
    ./software
  ];

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
    bw.socketPath = "${config.home.homeDirectory}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
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
      ".tmux.conf".source = ../../../../shared/dots/dot_tmux.conf;
      "shell.nix".source = ../../../../shared/dots/shell.nix;
      ".vimrc".source = ../../../../shared/dots/dot_vimrc;
      ".zsh.d/func.zsh".source = ./dots/func.zsh;
      ".restic/exclude.lst".source = ./conf/exclude.lst;

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

  # Using Helix
  programs.neovim = {
    enable = false;
    defaultEditor = false;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  launchd = {
    agents = {
      restic-backup = {
        enable = true;
        config = {
          ProgramArguments = [
            "${pkgs.restic}/bin/restic"
            "backup"
            "-p"
            "${config.home.homeDirectory}/.creds.d/restic"
            "-r"
            "sftp:${resticRemoteUser}@${backupServer}:${backupPath}"
            "--exclude-file"
            "${config.home.homeDirectory}/.restic/exclude.lst"
            "--cleanup-cache"
            "--read-concurrency"
            "6"
            "--tag"
            "automated"
            "${config.home.homeDirectory}"
          ];
          serviceConfig.RunAtLoad = false;
          serviceConfig.KeepAlive = false;
          persistent = true;
          EnvironmentVariables = {
            "SSH_AUTH_SOCK" = "${config.home.homeDirectory}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
          };
          StandardOutPath = "${config.home.homeDirectory}/.restic.log";
          StandardErrorPath = "${config.home.homeDirectory}/.restic.log";
          serviceConfig.StartCalendarInterval = [
            {
              Hour = 07;
              Minute = 30;
            }
          ];
        };
      };
      restic-cleanup = {
        enable = true;
        config = {
          ProgramArguments = [
            "${pkgs.restic}/bin/restic"
            "forget"
            "-p"
            "${config.home.homeDirectory}/.creds.d/restic"
            "-r"
            "sftp:${resticRemoteUser}@${backupServer}:${backupPath}"
            "--keep-daily"
            "2"
            "--keep-weekly"
            "1"
            "--keep-monthly"
            "1"
            "--prune"
          ];
          serviceConfig.RunAtLoad = false;
          serviceConfig.KeepAlive = false;
          persistent = true;
          EnvironmentVariables = {
            "SSH_AUTH_SOCK" = "${config.home.homeDirectory}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
          };
          StandardOutPath = "${config.home.homeDirectory}/.restic.log";
          StandardErrorPath = "${config.home.homeDirectory}/.restic.log";
          serviceConfig.StartCalendarInterval = [
            {
              Hour = 09;
              Minute = 30;
            }
          ];
        };
      };
    };
  };
}
