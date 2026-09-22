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
    };
  };
}
