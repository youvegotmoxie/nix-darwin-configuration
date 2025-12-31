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
          "brew"
          "git"
          "git-auto-fetch"
          "git-extras"
          "macos"
          "vi-mode"
        ];
      };
      enableCompletion = true;
      # TODO: Move this into its own file and import here
      shellAliases = {
        lg = "lazygit";
        ls = "eza";
        rm = "rm -v";
        mv = "mv -v";
        cp = "cp -v";
        ln = "ln -v";
        history = "history -E";
        mkdir = "mkdir -v";
        sudo = "nocorrect sudo";
        tldr = "nocorrect tldr";
        ll = "eza -lahg --git-repos-no-status --git";
        grep = "ugrep --color=auto";
        cat = "bat --paging=never --style=plain";
        btcm = "better-commits";
        tree = "eza --icons --tree --group-directories-first";
        man = "batman";
        nomsh = "nom-shell";
      };
      initContent = lib.mkOrder 1500 ''
        export GIT_AUTO_FETCH_INTERVAL=300
        source ${config.home.homeDirectory}/.zsh.d/func.zsh
        # # eval "$(ssh-agent -s)"
        # # Workaround for Atuin
        # source "${zsh-helix-mode}/zsh-helix-mode.plugin.zsh"
        # bindkey -M hxins '^r' atuin-up-search-vicmd
        # bindkey -M hxnor '^r' atuin-up-search-vicmd
      '';
      sessionVariables = {
        "TERM" = "xterm-256color";
        # "SSH_AUTH_SOCK" = "${cfg.bw.socketPath}";
      };
    };
  };
}
