{
  mainUser,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../hosts/shared/configuration.nix
  ];

  boot.kernelParams = [
    "amdgpu.gttsize=126976"
    "amd_iommu=off"
    "ttm.pages_limit=32505856"
  ];

  services.fwupd.enable = true;

  environment.systemPackages = with pkgs; [fwupd];

  # Allow SSH from work, personal laptop and iPhone
  users.users.${mainUser}.openssh.authorizedKeys.keys = [
    "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBNKNWVZe8zRvZ8VNfsDr+KQfDYvi/+ssXo6hIHLFsxwVYya+BcyFZ6TBXARrLONhkKbq4nkEA2CRatJ5bL8WG2H8dnl/WbsV+LQ5NRZz20f0MIKhOkZa6uoZE6gGWEVIxA== cardno:35_285_426"
    "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBCC3+lHWSgBAOLx2HgQLDW81dCkgAj4Jvp5bRMOl3ZlHZXbmXZwA8JYPMWiZEzOZlNXkS8UlaiC6vaq8JtPeFNziuLgQ5Ntl2AX4fk+/VpnsouQ7tvPt5wwFdiTcT811Ng== cardno:31_399_365"
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEYIXq13etALqDfIy65S1UWM5uZf9mIMmxV1zP5l1b5uYco4Q+WdkuvlpY1BrmC4m3SQ7NLTP87dtPBZgdWv0qg= rex@iPhone"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFmaOAZ3pmnarfX315CnWGxpLVhoQpoENZHo2uIoKYQO mike@llama-server"
  ];
}
