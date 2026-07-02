{config, ...}: {
  programs.ssh.settings = {
    "*" = {
      ForwardAgent = true;
      StreamLocalBindUnlink = "yes";
      IdentityAgent = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";
    };
  };
}
