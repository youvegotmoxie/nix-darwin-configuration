{
  config,
  lib,
  ...
}: {
  programs.ssh = {
    includes = ["${config.home.homeDirectory}/.orbstack/ssh/config"];
    settings = lib.mkMerge [
      {
        "work-laptop" = {
          Hostname = "192.168.1.155";
          User = "mbeasley";
          Port = 22;
          IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519_worklaptop_sk";
        };
        "mike-mac-mini" = {
          Hostname = "192.168.1.45";
          User = "mike";
          Port = 22;
          ControlMaster = "auto";
          ControlPath = "${config.home.homeDirectory}/.ssh/S.%r@%h:%p";
          ControlPersist = "2h";
        };
        "llama-server" = {
          Hostname = "192.168.1.87";
          User = "mike";
          Port = 22;
          ControlMaster = "auto";
          ControlPath = "${config.home.homeDirectory}/.ssh/S.%r@%h:%p";
          ControlPersist = "2h";
        };
        "fw-desktop" = {
          Hostname = "192.168.1.180";
          User = "mike";
          Port = 22;
          ControlMaster = "auto";
          ControlPath = "${config.home.homeDirectory}/.ssh/S.%r@%h:%p";
          ControlPersist = "2h";
        };
      }
    ];
  };
}
