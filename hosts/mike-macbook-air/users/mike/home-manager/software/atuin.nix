{
  programs.atuin = {
    enable = true;
    daemon = {
      enable = false;
    };
    enableZshIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
    settings = {
      auto_sync = true;
      sync_frequency = "10m";
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
          "ls"
          "ll"
          "vi"
          "vim"
          "hx"
          "nvim"
        ];
        common_subcommands = [
          "cargo"
          "go"
          "git"
          "npm"
          "yarn"
          "pnpm"
          "kubectl"
          "docker"
          "brew"
          "k"
          "helm"
          "helm2"
          "nix"
          "nh"
        ];
      };
    };
  };
}
