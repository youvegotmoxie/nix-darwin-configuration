{mainUser, pkgs, ...}: {
  imports = [../shared/darwin.nix];

  environment.systemPackages = [pkgs.agent-browser pkgs.himalaya];

  # Allow SSH from work and personal laptop
  users.users.${mainUser}.openssh.authorizedKeys.keys = [
    "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBNKNWVZe8zRvZ8VNfsDr+KQfDYvi/+ssXo6hIHLFsxwVYya+BcyFZ6TBXARrLONhkKbq4nkEA2CRatJ5bL8WG2H8dnl/WbsV+LQ5NRZz20f0MIKhOkZa6uoZE6gGWEVIxA== cardno:35_285_426"
    "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBCC3+lHWSgBAOLx2HgQLDW81dCkgAj4Jvp5bRMOl3ZlHZXbmXZwA8JYPMWiZEzOZlNXkS8UlaiC6vaq8JtPeFNziuLgQ5Ntl2AX4fk+/VpnsouQ7tvPt5wwFdiTcT811Ng== cardno:31_399_365"
  ];
  # Use Homebrew for these to avoid a bunch of compiling
  homebrew = {
    taps = [
      "steipete/tap"
    ];
    brews = [
      "ffmpeg"
      "steipete/tap/imsg"
      "steipete/tap/remindctl"
      "yt-dlp"
    ];
  };
}
