{pkgs, ...}: {
  programs.gpg = {
    enable = true;
    settings = {
      default-key = "A6B4C8E1BAEA348F";
      keyserver = "hkps://keys.openpgp.org";
      keyserver-options = "auto-key-retrieve";
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      require-cross-certification = true;
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      charset = "utf-8";
      default-recipient-self = true;
      keyid-format = "long";
      with-fingerprint = true;
      use-agent = true;
      require-secmem = true;
      armor = true;
      throw-keyids = true;
    };
    scdaemonSettings = {
      disable-ccid = true;
    };
  };
  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry_mac;
    defaultCacheTtl = 60;
    maxCacheTtl = 120;
    enableScDaemon = true;
    sshKeys = [
      "FA2DB0DD531C864082BD10F5C936E7BFD93BA80A"
    ];
  };
  services.ssh-agent = {
    enable = true;
    enableZshIntegration = true;
  };
}
