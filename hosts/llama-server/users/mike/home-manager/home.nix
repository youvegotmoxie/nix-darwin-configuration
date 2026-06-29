{pkgs, ...}: {
  home = {
    stateVersion = "26.05";
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
      nodejs_26
      p7zip
      prek
      ripgrep
      rustup
      screen
      shfmt
      tldr
      ugrep
      viddy
      yq
    ];
  };
}
