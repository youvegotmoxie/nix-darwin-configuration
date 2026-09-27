{
  mainUser,
  pkgs,
  ...
}: {
  imports = [../shared/darwin.nix];

  # Increase GPU memory for oMLX
  extras.gpuMemory = "45056";

  # Allow SSH from personal laptop
  users.users.${mainUser}.openssh.authorizedKeys.keys = [
    "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBCC3+lHWSgBAOLx2HgQLDW81dCkgAj4Jvp5bRMOl3ZlHZXbmXZwA8JYPMWiZEzOZlNXkS8UlaiC6vaq8JtPeFNziuLgQ5Ntl2AX4fk+/VpnsouQ7tvPt5wwFdiTcT811Ng== cardno:31_399_365"
  ];

  # Only need uv on the work and personal laptops
  environment.systemPackages = [pkgs.uv];

  # Use Homebrew for things not working with nixpkgs on macOS
  homebrew = {
    taps = [
      "anomalyco/tap"
    ];
    brews = [
      "anomalyco/tap/opencode"
      "argocd"
      "helm-ls"
    ];
    casks = [
      "aptakube"
      "obsidian"
    ];
    masApps = {
      "AWS Extend Switch Roles" = 1592710340;
    };
  };
}
