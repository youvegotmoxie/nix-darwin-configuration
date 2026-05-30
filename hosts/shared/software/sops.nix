{config, ...}: {
  # Setup done outside of Nix
  #
  #   mkdir -p ~/Library/Application\ Support/sops/age
  #   nix shell nixpkgs#ssh-to-age --command \
  #     ssh-to-age -private-key -i ~/.ssh/sops_ed25519 \
  #     > ~/Library/Application\ Support/sops/age/keys.txt
  #
  # Make sure the output of this matches the keys.txt file
  #
  #   nix shell nixpkgs#ssh-to-age --command \
  #     ssh-to-age < ~/.ssh/sops_ed25519.pub
  #
  # Create a secrets file
  #
  #   sops hosts/$HOST/users/$USER/home-manager/secrets/secrets.yaml
  #
  sops = {
    age.sshKeyPaths = ["${config.home.homeDirectory}/.ssh/sops_ed25519"];
  };

  launchd.agents.gh-token-env = {
    enable = true;
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
}
