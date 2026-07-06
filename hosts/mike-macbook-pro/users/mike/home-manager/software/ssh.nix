{
  config,
  lib,
  ...
}: {
  programs.ssh = {
    includes = ["${config.home.homeDirectory}/.orbstack/ssh/config"];
    settings = lib.mkMerge {
      "rpi4-timemachine" = {
        Hostname = "192.168.148.217";
        User = "mike";
        Port = 22;
        ControlMaster = "auto";
        ControlPath = "${config.home.homeDirectory}/.ssh/S.%r@%h:%p";
        ControlPersist = "2h";
      };
      "rpi4-standalone" = {
        Hostname = "192.168.148.244";
        User = "ubuntu";
        Port = 22;
        ControlMaster = "auto";
        ControlPath = "${config.home.homeDirectory}/.ssh/S.%r@%h:%p";
        ControlPersist = "2h";
      };
      "work-laptop" = {
        Hostname = "192.168.148.132";
        User = "michaelbeasley";
        Port = 22;
        IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519_worklaptop_sk";
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
        ControlMaster = "auto";
        ControlPath = "${config.home.homeDirectory}/.ssh/S.%r@%h:%p";
        ControlPersist = "2h";
      };
    };
  };
}
