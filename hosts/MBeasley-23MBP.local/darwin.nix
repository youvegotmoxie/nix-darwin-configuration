{pkgs, ...}: {
  imports = [../shared/darwin.nix];

  # System packages
  environment.systemPackages = with pkgs; [
    python314
    python314Packages.pip
  ];

  # Use Homebrew for things not working with nixpkgs on macOS
  homebrew = {
    brews = [
      "argocd"
      "helm-ls"
    ];
    casks = [
      "aptakube"
    ];
  };
}
