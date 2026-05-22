{config, ...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = ["${config.home.homeDirectory}/.orbstack/ssh/config"];
    settings = {
      "*" = {
        ForwardAgent = true;
        ControlMaster = "auto";
        ControlPath = "${config.home.homeDirectory}/.ssh/S.%r@%h:%p";
        ControlPersist = "2h";
        StreamLocalBindUnlink = "yes";
        IdentityAgent = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";
      };
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
      "work-laptop" = {
        Hostname = "192.168.148.132";
        User = "michaelbeasley";
        Port = 22;
        IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519_worklaptop_sk";
      };
    };
  };
}
