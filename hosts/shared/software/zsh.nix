{
  pkgs,
  lib,
  config,
  ...
}: let
  # Add custom plugin for helix zsh bindings
  # https://github.com/Multirious/zsh-helix-mode
  zsh-helix-mode = pkgs.fetchFromGitHub {
    owner = "Multirious";
    repo = "zsh-helix-mode";
    rev = "2b4a40aa8956d345d8554f0c3ebbdc2fee619b9a";
    sha256 = "sha256-0/5B4SRHNo06ya0qNGy15yyOE6iZv7t4CLlO2Aody7g=";
  };
  cfg = config.zshConfig;
in {
  options.zshConfig.ssh = {
    socketPath = lib.mkOption {
      type = lib.types.str;
      description = "Path to SSH agent socket";
      default = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
    };
  };
  options.zshConfig.workAliases = {
    enable = lib.mkEnableOption "zshConfig.workAliases";
    default = false;
  };
  config = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      history = {
        expireDuplicatesFirst = true;
        saveNoDups = true;
        findNoDups = true;
        ignoreAllDups = true;
        size = 100000;
      };
      oh-my-zsh = {
        enable = true;
        plugins =
          if cfg.workAliases.enable
          then [
            "aws"
            "docker"
            "git"
            "git-auto-fetch"
            "git-extras"
            "gcloud"
            "kubectl"
            "helm"
            "macos"
            "terraform"
            "vi-mode"
          ]
          else [
            "docker"
            "git"
            "git-auto-fetch"
            "git-extras"
            "kubectl"
            "helm"
            "macos"
            "vi-mode"
          ];
      };
      # TODO: Move this into its own file and import here
      shellAliases =
        if cfg.workAliases.enable
        then {
          lg = "lazygit";
          rm = "rm -v";
          mv = "mv -v";
          cp = "cp -v";
          ln = "ln -v";
          history = "history -E";
          mkdir = "mkdir -v";
          sudo = "nocorrect sudo";
          tldr = "nocorrect tldr";
          passtui = "passepartui";
          # Legacy network stuff (kept for reference)
          # "switch0-top" = "ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -l mike 192.168.10.248 -p22 -c aes256-cbc";
          # "switch0-bottom" = "ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -l mike 192.168.10.249 -p22 -c aes256-cbc";
          # "router1-bottom" = "ssh 192.168.1.250 -lmike -p22 -c aes256-cbc";
          properties-converter = "python ~/bitbucket/platops/platops-utils/bin/properties-converter.py";
          kubectl = "kubecolor";
          k = "kubectl";
          kgp = "kubectl get pods";
          dive = "docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive";
          grep = "ugrep --color=auto";
          cat = "bat --paging=never --style=plain";
          btcm = "better-commits";
          tree = "eza --icons --tree --group-directories-first";
          man = "batman";
          nomsh = "nom-shell";
        }
        else {
          lg = "lazygit";
          rm = "rm -v";
          mv = "mv -v";
          cp = "cp -v";
          ln = "ln -v";
          history = "history -E";
          mkdir = "mkdir -v";
          sudo = "nocorrect sudo";
          tldr = "nocorrect tldr";
          grep = "ugrep --color=auto";
          cat = "bat --paging=never --style=plain";
          tree = "eza --icons --tree --group-directories-first";
          man = "batman";
          nomsh = "nom-shell";
          passtui = "passepartui";
          kubectl = "kubecolor";
          k = "kubectl";
          kgp = "kubectl get pods";
          dive = "docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive";
        };
      initContent = lib.mkOrder 1500 ''
        source ${config.home.homeDirectory}/.zsh.d/func.zsh
        ## Workaround for Atuin
        # source "${zsh-helix-mode}/zsh-helix-mode.plugin.zsh"
        # bindkey -M hxins '^r' atuin-up-search-vicmd
        # bindkey -M hxnor '^r' atuin-up-search-vicmd
      '';
      sessionVariables = {
        "GIT_AUTO_FETCH_INTERVAL" = 300;
        "TERM" = "xterm-256color";
        "SSH_AUTH_SOCK" = "${cfg.ssh.socketPath}";
      };
    };
  };
}
