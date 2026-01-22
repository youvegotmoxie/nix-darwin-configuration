{...}: {
  programs.gpg = {
    enable = true;
  };
  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    enableSshSupport = true;
  };
  services.ssh-agent = {
    enable = true;
    enableZshIntegration = true;
  };
}
