{
  config,
  lib,
  ...
}: {
  programs.ssh = {
    includes = ["${config.home.homeDirectory}/.orbstack/ssh/config"];
    settings = lib.mkMerge [
      {
        "mike-mac-pro" = {
          Hostname = "192.168.148.232";
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
        "fw-desktop" = {
          Hostname = "192.168.148.148";
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
