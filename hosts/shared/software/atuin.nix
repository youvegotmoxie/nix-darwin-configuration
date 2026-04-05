{
  programs.atuin = {
    enable = true;
    daemon = {
      enable = true;
    };
    enableZshIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      search_mode = "fulltext";
      filter_mode = "host";
      inline_height = 20;
      show_preview = false;
      enter_accept = false;
      keymap_mode = "vim-insert";
      keymap_cursor = {
        emacs = "blink-block";
        vim_insert = "blink-block";
        vim_normal = "steady-block";
      };
      sync.records = true;
      dotfiles.enabled = true;
      stats = {
        common_prefix = [
          "sudo"
        ];
        ignored_commands = [
          "cd"
          "hx"
          "ll"
          "ls"
          "nvim"
          "vi"
          "vim"
        ];
        common_subcommands = [
          "brew"
          "cargo"
          "docker"
          "git"
          "go"
          "helm"
          "helm2"
          "k"
          "kubectl"
          "nh"
          "nix"
          "npm"
          "pnpm"
          "ssh"
          "yarn"
        ];
      };
    };
  };
}
