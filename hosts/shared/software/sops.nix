{
  config,
  pkgs,
  lib,
  ...
}: {
  # Setup done outside of Nix
  #
  #   ssh-keygen -f ~/.ssh/sops_ed25519 -N ''
  #
  #   mkdir -p ~/Library/Application\ Config/sops/age
  #
  #   nix run nixpkgs#ssh-to-age -- --private-key -i ~/.ssh/sops_ed25519 \
  #     > ~/Library/Application\ Config/sops/age/keys.txt
  #
  # Make sure the output of this matches the keys.txt file
  #
  #   nix run nixpkgs#ssh-to-age < ~/.ssh/sops_ed25519.pub
  #
  # Create a secrets file
  #
  #   sops hosts/$HOST/users/$USER/home-manager/secrets/secrets.yaml
  #
  # A .sops.yaml in the repo root is needed for the initial bootstrapping
  # https://github.com/zendesk/helm-secrets/issues/121
  sops = {
    age = {
      sshKeyPaths = ["${config.home.homeDirectory}/.ssh/sops_ed25519"];
      keyFile = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "${config.home.homeDirectory}/Library/Application Support/sops/age/keys.txt"
        # Linux path (not currently used on NixOS)
        ;
    };
  };

  # macOS-specific: launchd agent for GH_TOKEN
  launchd.agents.gh-token-env = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    enable = true;
    domain = "user";
    config = {
      ProgramArguments = [
        "/bin/sh"
        "-c"
        "if [ -f ${config.home.homeDirectory}/.creds.d/gh_token ]; then /bin/launchctl setenv GH_TOKEN \"$(cat ${config.home.homeDirectory}/.creds.d/gh_token)\"; fi"
      ];
      RunAtLoad = true;
      WatchPaths = ["${config.home.homeDirectory}/.creds.d/gh_token"];
      ProcessType = "Background";
    };
  };

  # NixOS-specific: systemd user service for GH_TOKEN
  systemd.user.services.gh-token-env = lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
    enable = true;
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = lib.escapeShellArgs [
        "/bin/sh"
        "-c"
        "if [ -f ${config.home.homeDirectory}/.creds.d/gh_token ]; then /usr/bin/systemctl --user setenv GH_TOKEN \"$(cat ${config.home.homeDirectory}/.creds.d/gh_token)\"; fi"
      ];
    };
    unitConfig = {
      WatchPaths = ["${config.home.homeDirectory}/.creds.d"];
    };
  };
}
