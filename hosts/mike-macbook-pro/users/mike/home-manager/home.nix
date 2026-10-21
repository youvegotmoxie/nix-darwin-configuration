{
  config,
  pkgs,
  lib,
  ...
}: let
  k0sctl = pkgs.buildGoLatestModule (finalAttrs: {
    pname = "k0sctl";
    version = "0.33.1";
    src = pkgs.fetchFromGitHub {
      owner = "k0sproject";
      repo = finalAttrs.pname;
      tag = "v${finalAttrs.version}";
      hash = "sha256-g/8rN0UWbUjiIuWKcBb9sr8PjMx+rcq3Hce64cGziU0=";
    };
    vendorHash = "sha256-3TIQ1VY+52DFCVWiJs5U+5A+mVSU3QPyr5Vzrzs7zF8=";
    meta = {
      description = "A command-line bootstrapping and management tool for k0s zero friction kubernetes clusters";
      homepage = "https://github.com/k0sproject/k0sctl";
      license = lib.licenses.afl20;
      mainProgram = finalAttrs.pname;
    };
  });
in {
  imports = [
    # shared modules in root of hosts dir
    ../../../../shared/software
    # Per host modules
    ./software
  ];

  # Configure SSH agent socket
  zshConfig = {
    ssh.socketPath = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";
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
      "NO_PROXY" = "localhost,127.0.0.1,192.168.1.87,192.168.1.180";
      "no_proxy" = NO_PROXY;
    };

    packages = lib.mkMerge [[k0sctl]];
    file = {
      ".config/yt-dlp/config".text = ''
        --format best[height<=1080]
        --format-sort +size
        --merge-output-format mp4
        --embed-thumbnail
        --embed-metadata
        --output "%(title)s.%(ext)s"
      '';
    };
  };
}
