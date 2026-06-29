{pkgs, ...}: {
  home = {
    stateVersion = "26.05";
    sessionVariables = rec {
      # Needed for Zed to prevent routing loops
      "NO_PROXY" = "localhost,127.0.0.1";
      "no_proxy" = NO_PROXY;
    };

    packages = with pkgs; [
      alejandra
      bat
      bat-extras.batman
      delta
      fd
      findutils
      gawk
      gh
      jq
      nh
      nix-output-monitor
      p7zip
      prek
      ripgrep
      rustup
      shfmt
      tmux
      tldr
      ugrep
      viddy
      yq
    ];

    file = {
      ".rustup/settings.toml".source = ./dots/rustup_settings.toml;
      ".models.ini".source = ./dots/models.ini;
    };
  };
}
