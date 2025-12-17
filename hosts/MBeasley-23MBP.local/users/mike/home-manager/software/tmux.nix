{
  config,
  pkgs,
  ...
}: let
  # Package this manually since mkTmuxPlugin keeps changing script names
  tmux-lazy-restore =
    pkgs.stdenv.mkDerivation rec
    {
      pname = "tmux-lazy-restore";
      version = "v0.1.2";
      src = pkgs.fetchFromGitHub {
        owner = "bcampolo";
        repo = pname;
        rev = "d578fddb3bd9f9aca07f1053670e48ec8c6ea2bf";
        sha256 = "sha256-LLXGXJzIB2I0NMbWTh2DtLTAyC+JMzNM//SbKtFd9nM=";
      };
      installPhase = ''
        runHook preInstall
        install -d 0755 scripts $out/bin/scripts
        install -m 0755 scripts/tmux-session-manager.sh $out/bin/scripts
        install -m 0755 scripts/spinner.sh $out/bin/scripts
        install -m 0755 tmux-lazy-restore.tmux $out/bin/tmux-lazy-restore.tmux
        runHook postInstall
      '';
    };
in {
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    historyLimit = 50000;
    keyMode = "vi";
    clock24 = true;
    baseIndex = 1;
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = [
      pkgs.tmuxPlugins.better-mouse-mode
      pkgs.tmuxPlugins.tokyo-night-tmux
      # pkgs.tmuxPlugins.vim-tmux-navigator
    ];
    shortcut = "a";
    mouse = true;
    extraConfig = ''
      # Reload Tmux config
      bind R \
        source-file ${config.home.homeDirectory}/.config/tmux/tmux.conf\; \
        display-message "Configuration reloaded..."

      # Set path to tmux-lazy-restore in nix store
      run-shell ${tmux-lazy-restore}/bin/tmux-lazy-restore.tmux

      # Remove ESC key delay
      set -g escape-time 0

      # Increase tmux messages display duration from 750ms to 4s
      set -g display-time 2000

      # Refresh 'status-left' and 'status-right' more often, from every 15s to 5s
      set -g status-interval 5

      # Focus events enabled for terminals that support them
      set -g focus-events on

      # Enable $TERM title setting
      set -g set-titles on
      set -g set-titles-string "#(whoami)@#h"

      # Copy to system clipboard and prefix-Y to enter copy mode
      bind-key -r Y copy-mode
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"

      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Toogle maximize pane
      bind -r Z resize-pane -Z

      # Resize panes using HJKL -/+10%
      bind -r K resize-pane -U 10
      bind -r J resize-pane -D 10
      bind -r H resize-pane -L 10
      bind -r L resize-pane -R 10

      # Switch panes using hjkl
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      unbind Up
      unbind Down
      unbind Left
      unbind Right
      unbind C-Up
      unbind C-Down
      unbind C-Left
      unbind C-Right
      unbind ]
      unbind [

      # Auto-renumber all windows when one closed
      set -g renumber-windows on

      # Use 24 hour clock
      set -g @tokyo-night-tmux_time_format 24H

      # Reduce padding between icons and text
      set -g @tokyo-night-tmux_window_tidy_icons 0

      # Show pwd in status bar and use relative paths
      set -g @tokyo-night-tmux_show_path 1
      set -g @tokyo-night-tmux_path_format relative
    '';
  };
}
