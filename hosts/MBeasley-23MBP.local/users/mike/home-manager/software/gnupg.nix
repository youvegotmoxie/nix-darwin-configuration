{pkgs, ...}: {
  programs.gpg = {
    enable = true;
    settings = {
      # default-key = "224F8BD5FD67C344";
      default-recipient-self = true;
      keyid-format = "long";
      with-fingerprint = true;
      use-agent = true;
      require-secmem = true;
      armor = true;
      throw-keyids = true;
    };
  };
  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-tty;
  };
  services.ssh-agent = {
    enable = true;
    enableZshIntegration = true;
  };
}
