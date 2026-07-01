{config, ...}: {
  programs.ssh.settings = {
    "*" = {
      ForwardAgent = true;
      ControlMaster = "auto";
      ControlPath = "${config.home.homeDirectory}/.ssh/S.%r@%h:%p";
      ControlPersist = "2h";
      StreamLocalBindUnlink = "yes";
      IdentityAgent = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";
    };
  };
}
