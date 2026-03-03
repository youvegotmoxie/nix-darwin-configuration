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

  home = {
    stateVersion = "25.05";
    sessionPath = [
      "$HOME/.krew"
    ];

    file = {
      # Disabled since I'm using tmux from nixpkgs
      # ".tmux.conf".source = ../../../../shared/dots/dot_tmux.conf;
      "shell.nix".source = ../../../../shared/dots/shell.nix;
      ".vimrc".source = ../../../../shared/dots/dot_vimrc;
      ".zsh.d/func.zsh".source = ../../../../shared/dots/func.zsh;
      ".restic/exclude.lst".source = ./conf/exclude.lst;
    };
  };
}
