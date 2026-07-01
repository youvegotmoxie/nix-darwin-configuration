{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = ["${config.home.homeDirectory}/.orbstack/ssh/config"];
    settings = lib.mkMerge [
      (import ../../../../../shared/software/ssh.nix {inherit config pkgs lib;}).programs.ssh.settings
      {
        "rpi4-timemachine" = {
          Hostname = "192.168.148.217";
          User = "mike";
          Port = 22;
          IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519-lab_sk";
        };
        "rpi4-standalone" = {
          Hostname = "192.168.148.244";
          User = "ubuntu";
          Port = 22;
          PKCS11Provider = "${pkgs.yubico-piv-tool}/lib/libykcs11.dylib";
        };
        "mike-macbook-pro" = {
          Hostname = "mike-macbook-pro.local";
          User = "mike";
          Port = 22;
        };
        "iad-jump" = {
          Hostname = "jump1.dev2.iad1.sre.aspect-cloud.net";
          User = "mbeasley";
          Port = 22;
        };
        "bitbucket.aws.alvaria.com" = {
          IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
        };
        "mike-mac-pro" = {
          Hostname = "192.168.148.117";
          User = "mike";
          Port = 22;
        };
        "llama-server" = {
          Hostname = "192.168.148.125";
          User = "mike";
          Port = 22;
        };
      }
    ];
  };
}
