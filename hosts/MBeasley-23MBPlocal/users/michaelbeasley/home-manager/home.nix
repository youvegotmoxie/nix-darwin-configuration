{config, ...}: {
  imports = [
    # shared modules in root of hosts dir
    ../../../../shared/software
    # Per host modules
    ./software
  ];

  # Configure SSH agent socket and add work shell aliases
  zshConfig = {
    ssh.socketPath = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";
    workAliases.enable = true;
    homeAliases.enable = false;
  };

  # See shared/software/sops.nix for Launchd configuration
  # if secrets are needed outside of the shell environment
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    secrets.gh_token = {
      path = "${config.home.homeDirectory}/.creds.d/gh_token";
      mode = "0600";
    };
  };

  home = {
    stateVersion = "25.05";
    sessionVariables = rec {
      # Needed for Zed to prevent routing loops
      "NO_PROXY" = "localhost,127.0.0.1";
      "no_proxy" = NO_PROXY;
    };
    sessionPath = [
      "$HOME/.krew"
    ];

    file = {
      ".vimrc".source = ../../../../shared/dots/dot_vimrc;
      ".zsh.d/func.sh".source = ../../../../shared/dots/func.sh;
    };
  };
}
