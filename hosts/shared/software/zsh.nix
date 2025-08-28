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
  options.zshConfig.bw = {
    socketPath = lib.mkOption {
      type = lib.types.str;
      description = "Path to Bitwarden SSH agent socket";
      default = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
    };
  };
  config = {
    programs.zsh = {
      enable = true;
      history = {
        expireDuplicatesFirst = true;
        findNoDups = true;
        ignoreAllDups = true;
        size = 100000;
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "docker"
          "git-extras"
          "macos"
          "terraform"
          "kubectl"
          "helm"
          "gcloud"
          "aws"
        ];
      };
      enableCompletion = true;
      shellAliases = {
        "lg" = "lazygit";
        "ls" = "eza";
        "rm" = "rm -v";
        "mv" = "mv -v";
        "cp" = "cp -v";
        "ln" = "ln -v";
        "history" = "history -E";
        "mkdir" = "mkdir -v";
        "sudo" = "nocorrect sudo";
        "tldr" = "nocorrect tldr";

        # Legacy network stuff (kept for reference)
        # "switch0-top" = "ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -l mike 192.168.10.248 -p22 -c aes256-cbc";
        # "switch0-bottom" = "ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -l mike 192.168.10.249 -p22 -c aes256-cbc";
        # "router1-bottom" = "ssh 192.168.1.250 -lmike -p22 -c aes256-cbc";

        "gpm" = "git pull origin master";
        "ll" = "eza -lahg --git-repos-no-status --git";
        "grep" = "ugrep --color=auto";
        "properties-converter" = "python ~/bitbucket/platops/platops-utils/bin/properties-converter.py";
        "cat" = "bat --paging=never --style=plain";
        "kubectl" = "kubecolor";
        "k" = "kubectl";
        "kgp" = "kubectl get pods";
        "dive" = "docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive";
        "btcm" = "better-commits";
        "sed" = "gsed";
      };
      initContent = lib.mkOrder 1500 ''
        source ${config.home.homeDirectory}/.zsh.d/func.zsh
        # eval "$(ssh-agent -s)"
        # Workaround for Atuin
        source "${zsh-helix-mode}/zsh-helix-mode.plugin.zsh"
        bindkey -M hxins '^r' atuin-up-search-vicmd
        bindkey -M hxnor '^r' atuin-up-search-vicmd
      '';
      sessionVariables = {
        "TERM" = "xterm-256color";
        "SSH_AUTH_SOCK" = "${cfg.bw.socketPath}";
      };
    };
  };
}
