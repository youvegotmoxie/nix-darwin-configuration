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
        toast.delivery = "herdr";
      };
      keys = {
        prefix = "ctrl+a";
        resize_pane_left = "ctrl+shift+h";
        resize_pane_down = "ctrl+shift+j";
        resize_pane_up = "ctrl+shift+k";
        resize_pane_right = "ctrl+shift+l";
      };
    };
  };
}
