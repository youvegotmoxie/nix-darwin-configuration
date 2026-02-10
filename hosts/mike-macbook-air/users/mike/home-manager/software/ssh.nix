{config, ...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = ["${config.home.homeDirectory}/.orbstack/ssh/config"];
    # TODO: Merge this with work-laptop ssh.nix
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
