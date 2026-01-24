{...}: {
  programs.gpg = {
    enable = true;
    settings = {
      default-key = "A6B4C8E1BAEA348F";
      default-recipient-self = true;
      keyid-format = "long";
      with-fingerprint = true;
      use-agent = true;
      require-secmem = true;
    };
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
