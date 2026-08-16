{mainUser, pkgs, ...}: {
  imports = [../shared/darwin.nix];

  # Only need uv on the work and personal laptops
  environment.systemPackages = [pkgs.uv];

  # Increase GPU memory for oMLX
  extras.gpuMemory = "20480";

  # Allow SSH from work laptop
  users.users.${mainUser}.openssh.authorizedKeys.keys = [
    "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBNKNWVZe8zRvZ8VNfsDr+KQfDYvi/+ssXo6hIHLFsxwVYya+BcyFZ6TBXARrLONhkKbq4nkEA2CRatJ5bL8WG2H8dnl/WbsV+LQ5NRZz20f0MIKhOkZa6uoZE6gGWEVIxA== cardno:35_285_426"
  ];
  # Use Homebrew for these to avoid a bunch of compiling
  homebrew = {
    brews = [
      "ffmpeg"
      "yt-dlp"
    ];
  };
}
