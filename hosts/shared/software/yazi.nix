{...}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      mgr = {
        prepend_keymap = [
          {
            on = "!";
            run = "shell $SHELL --block --confirm";
            desc = "Open shell here";
          }
        ];
        sort_by = "alphabetical";
        sort_sensitive = true;
        sort_dir_first = true;
        show_symlink = true;
      };
      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        image_delay = 0;
      };
    };
  };
}
