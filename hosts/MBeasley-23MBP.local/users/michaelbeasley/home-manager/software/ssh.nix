{
  config,
  pkgs,
  ...
}: {
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
      "mike-macbook-air" = {
        Hostname = "mike-macbook-air.local";
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
    };
  };
}
