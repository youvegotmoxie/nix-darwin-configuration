{pkgs, ...}: {
  programs.gpg = {
    enable = true;
    settings = {
      default-key = "18B0D3665C0599CF";
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
      # Idle the Smartcard after 5 seconds
      card-timeout = "5";
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
      "CCD38BCA13B9648549D6BE9AB189D1FC261433D2"
    ];
  };
}
