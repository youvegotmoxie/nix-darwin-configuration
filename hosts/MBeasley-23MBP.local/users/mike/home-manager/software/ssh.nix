{
  config,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = ["${config.home.homeDirectory}/.orbstack/ssh/config"];
    matchBlocks = {
      "*" = {
        forwardAgent = true;
        controlMaster = "auto";
        controlPath = "${config.home.homeDirectory}/.ssh/S.%r@%h:%p";
        controlPersist = "2h";
        extraOptions = {
          StreamLocalBindUnlink = "yes";
        };
      };
      "rpi4-timemachine" = {
        hostname = "192.168.148.217";
        user = "mike";
        port = 22;
        extraOptions = {
          PKCS11Provider = "${pkgs.yubico-piv-tool}/lib/libykcs11.dylib";
        };
      };
      "rpi4-standalone" = {
        hostname = "192.168.148.244";
        user = "ubuntu";
        port = 22;
        extraOptions = {
          PKCS11Provider = "${pkgs.yubico-piv-tool}/lib/libykcs11.dylib";
        };
      };
      "mike-macbook-air" = {
        hostname = "mike-macbook-air.local";
        user = "mike";
        port = 22;
      };
      "iad-jump" = {
        hostname = "jump1.dev2.iad1.sre.aspect-cloud.net";
        user = "mbeasley";
        port = 22;
      };
      "bitbucket.aws.alvaria.com" = {
        identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };
    };
  };
}
