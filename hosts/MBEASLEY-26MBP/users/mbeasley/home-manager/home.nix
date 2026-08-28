{config, ...}: {
  imports = [
    # shared modules in root of hosts dir
    ../../../../shared/software
    # Per host modules
    ./software
  ];

  # Configure git persona
  gitConfig = {
    person = {
      name = "Michael Beasley";
      email = "michael.beasley@alvaria.com";
      gpgKey = "BB91DF43EC4CAE86";
    };
  };

  # Configure gpg-agent
  gpgConfig = {
    pubKey = "18B0D3665C0599CF";
    sshKeys = ["CCD38BCA13B9648549D6BE9AB189D1FC261433D2"];
  };

  # Configure SSH agent socket and add work shell aliases
  zshConfig = {
    ssh.socketPath = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";
    workAliases = {
      enable = true;
    };
  };
  extras.extraPackages.workOnly = {
    enable = true;
  };

  # See shared/software/sops.nix for Launchd configuration
  # if secrets are needed outside of the shell environment
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    secrets.bb_token = {
      path = "${config.home.homeDirectory}/.creds.d/bb_token";
      mode = "0600";
    };
    secrets.gh_token = {
      path = "${config.home.homeDirectory}/.creds.d/gh_token";
      mode = "0600";
    };
  };

  home = {
    stateVersion = "25.05";
    sessionVariables = rec {
      # Needed for Zed to prevent routing loops
      "NO_PROXY" = "localhost,127.0.0.1,192.168.1.87";
      "no_proxy" = NO_PROXY;
    };
    sessionPath = [
      "$HOME/.krew"
    ];
  };
}
