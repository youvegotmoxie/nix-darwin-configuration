{
  config,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        forwardAgent = true;
        controlMaster = "auto";
        controlPath = "${config.home.homeDirectory}/.ssh/S.%r@%h:%p";
        controlPersist = "6h";
        extraOptions = {
          PKCS11Provider = "${pkgs.yubico-piv-tool}/lib/libykcs11.dylib";
        };
      };
      "rpi4-timemachine" = {
        hostname = "192.168.148.217";
        user = "mike";
        port = 22;
      };
      "rpi4-standalone" = {
        hostname = "192.168.148.244";
        user = "ubuntu";
        port = 22;
      };
      "work-laptop" = {
        hostname = "192.168.148.132";
        user = "michaelbeasley";
        port = 22;
        identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519_worklaptop_sk";
      };
    };
  };
}
