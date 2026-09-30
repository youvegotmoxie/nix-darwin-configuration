{
  inputs,
  system,
  ...
}: {
  programs.herdr = {
    enable = true;
    # Use the upstream Herdr flake since nixpkgs lags behind
    package = inputs.herdr.packages.${system}.herdr;
    settings = {
      onboarding = false;
      theme = {
        name = "tokyo-night";
        auto_switch = false;
      };
      ui = {
        status_indicators = "symbols";
        sound.enabled = false;
        toast = {
          delivery = "herdr";
          clipboard.position = "bottom-right";
        };
        tab_bar_right = [
          {type = "hostname";}
          {type = "datetime";}
        ];
        tab_bar_right_separator = " | ";
        sidebar_collapsed_mode = "hidden";
        pane_scrollbars = false;
        window_title = "{terminal_title}";
      };
      keys = {
        prefix = "ctrl+a";
        resize_pane_left = "ctrl+shift+h";
        resize_pane_down = "ctrl+shift+j";
        resize_pane_up = "ctrl+shift+k";
        resize_pane_right = "ctrl+shift+l";
        next_workspace = "prefix+space";
        previous_workspace = "prefix+shift+space";
        split_vertical = "prefix+|";
        clear_pane = "cmd+k";
      };
    };
  };
}
