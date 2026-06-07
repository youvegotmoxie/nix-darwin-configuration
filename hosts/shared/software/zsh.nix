{
  pkgs,
  lib,
  config,
  ...
}: let
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
  options.zshConfig.homeAliases = {
    enable = lib.mkEnableOption "zshConfig.homeAliases";
    default = true;
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
          [
            "docker"
            "git"
            "git-auto-fetch"
            "git-extras"
            "kubectl"
            "macos"
            "vi-mode"
          ]
          ++ (lib.optionals cfg.workAliases.enable
            [
              "aws"
              "gcloud"
              "helm"
              "terraform"
            ]);
      };
      shellAliases =
        {
          lg = "lazygit";
          history = "history -E";
          sudo = "nocorrect sudo";
          tldr = "nocorrect tldr";
          grep = "ugrep --color=auto";
          cat = "bat --paging=never --style=plain";
          tree = "eza --icons --tree --group-directories-first";
          man = "batman";
          nomsh = "nom-shell";
          kubectl = "kubecolor";
          dive = "docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive";
          ytdl = "yt-dlp";
          nix = "nix --option access-tokens github.com=$(gh auth token)";
        }
        // (lib.optionalAttrs cfg.workAliases.enable {
          # Work only aliases
          btcm = "better-commits";
          properties-converter = "python ~/bitbucket/platops/platops-utils/bin/properties-converter.py";
          renovate = "docker run --rm -v $(pwd):/usr/src/app -e LOG_LEVEL=debug renovate/renovate --platform=local --dry-run=lookup --repository-cache=enabled";
        });
      # initContent is injected before shellAliases
      initContent = ''
        source ${config.home.homeDirectory}/.zsh.d/func.sh
        # Do it this way because we can't guarantee sops-nix will have populated this
        # secret symlink since these are added during login
        if [ -f ${config.home.homeDirectory}/.creds.d/gh_token ]; then
          export GH_TOKEN="$(cat ${config.home.homeDirectory}/.creds.d/gh_token)"
        fi
      '';
      sessionVariables = rec {
        "GIT_AUTO_FETCH_INTERVAL" = 300;
        "TERM" = "xterm-256color";
        "SSH_AUTH_SOCK" = "${cfg.ssh.socketPath}";
        # Needed for rustc
        "RUST_SRC_PATH" = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
        # Needed for Zed to prevent routing loops
        "NO_PROXY" = "localhost,127.0.0.1";
        "no_proxy" = NO_PROXY;
      };
    };
    # Setup command-not-found shell integration with nix-locate
    programs.nix-index.enable = true;
  };
}
