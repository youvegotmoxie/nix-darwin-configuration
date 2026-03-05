{...}: {
  imports = [../shared/darwin.nix];

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
