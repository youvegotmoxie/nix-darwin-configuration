{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    historyLimit = 10000;
    keyMode = "vi";
    baseIndex = 1;
    clock24 = true;
    plugins = [
      pkgs.tmuxPlugins.better-mouse-mode
      pkgs.tmuxPlugins.tokyo-night-tmux
    ];
    shortcut = "a";
    mouse = true;
    extraConfig = ''
      # Reload Tmux config
      bind r \
        source-file ${config.home.homeDirectory}/.config/tmux/tmux.conf\; \
        display-message "Configuration reloaded..."

      # Enable $TERM title setting
      set -g set-titles on
      set -g set-titles-string "#(whoami)@#h"

      # Copy to system clipboard
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"

      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

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

      # Use 24 clock
      set -g @tokyo-night-tmux_time_format 24H

      # Reduce padding between icons and text
      set -g @tokyo-night-tmux_window_tidy_icons 0

      # Show pwd in status bar and use relative paths
      set -g @tokyo-night-tmux_show_path 1
      set -g @tokyo-night-tmux_path_format relative

      # Placeholder so I remember these are options
      set -g @tokyo-night-tmux_show_netspeed 0
      set -g @tokyo-night-tmux_netspeed_showip 0
      set -g @tokyo-night-tmux_show_battery_widget 0
      set -g @tokyo-night-tmux_show_hostname 1
    '';
  };
}
