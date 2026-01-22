{...}: {
  programs.gpg = {
    enable = true;
  };
  programs.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    enableSshSupport = true;
  };
}
