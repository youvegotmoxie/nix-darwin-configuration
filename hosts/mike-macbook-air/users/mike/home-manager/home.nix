{config, ...}: {
  imports = [
    # shared modules in root of hosts dir
    ../../../../shared/software
    # Per host modules
    ./software
  ];

  # Configure gpg-agent
  gpgConfig = {
    pubKey = "26693209BA633C80";
    sshKeys = ["FA2DB0DD531C864082BD10F5C936E7BFD93BA80A"];
  };
  # Configure git persona
  gitConfig = {
    person = {
      name = "Michael Beasley";
      email = "youvegotmoxie@gmail.com";
      gpgKey = "A6B4C8E1BAEA348F";
    };
  };

  # Configure SSH agent socket
  zshConfig = {
    ssh.socketPath = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";
    workAliases.enable = false;
  };

  home = {
    stateVersion = "25.05";

    file = {
      ".zsh.d/func.zsh".source = ../../../../shared/dots/func.zsh;
      ".vimrc".source = ../../../../shared/dots/dot_vimrc;
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
