{
  mainUser,
  lib,
  ...
}: {
  imports = [../shared/darwin.nix];

  # https://nixos.org/manual/nixpkgs/unstable/release-notes#x86_64-darwin-26.05
  nixpkgs.config.allowDeprecatedx86_64Darwin = true;

  # Allow SSH from work and personal laptops
  users.users.${mainUser}.openssh.authorizedKeys.keys = [
    "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBNKNWVZe8zRvZ8VNfsDr+KQfDYvi/+ssXo6hIHLFsxwVYya+BcyFZ6TBXARrLONhkKbq4nkEA2CRatJ5bL8WG2H8dnl/WbsV+LQ5NRZz20f0MIKhOkZa6uoZE6gGWEVIxA== cardno:35_285_426"
    "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBCC3+lHWSgBAOLx2HgQLDW81dCkgAj4Jvp5bRMOl3ZlHZXbmXZwA8JYPMWiZEzOZlNXkS8UlaiC6vaq8JtPeFNziuLgQ5Ntl2AX4fk+/VpnsouQ7tvPt5wwFdiTcT811Ng== cardno:31_399_365"
  ];
  # Use Homebrew for these to avoid a bunch of compiling
  homebrew = {
    casks = lib.mkForce [
      "ghostty"
      "orbstack"
      "thaw"
      "timemachinestatus"
    ];
    masApps = lib.mkForce {};
  };
}
