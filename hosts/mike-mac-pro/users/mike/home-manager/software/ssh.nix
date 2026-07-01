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
        };
        "rpi4-standalone" = {
          Hostname = "192.168.148.244";
          User = "ubuntu";
          Port = 22;
        };
      }
    ];
  };
}
