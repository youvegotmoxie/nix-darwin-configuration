{pkgs, ...}: {
  # Set EDITOR to helix
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "tokyonight";
      editor = {
        true-color = true;
        auto-format = true;
        trim-final-newlines = true;
        trim-trailing-whitespace = true;
        end-of-line-diagnostics = "hint";
        indent-guides = {
          render = true;
          character = "┊";
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker = {
          hidden = false;
        };
        inline-diagnostics = {
          cursor-line = "error";
        };
      };
      keys.normal = {
        space = {
          B.b = ":run-shell-command blame-line-pretty %{buffer_name} %{cursor_line}";
          B.h = ":run-shell-command git-hunk %{buffer_name} %{cursor_line} 3";
        };
        C-x = [
          ":buffer-close!"
        ];
        C-g = [
          ":write-all"
          ":new"
          ":insert-output lazygit"
          ":buffer-close!"
          ":redraw"
          ":reload-all"
        ];
      };
    };
    languages = {
      # language-server.bash = {
      #   command = "${pkgs.bash-language-server}/bin/bash-language-server";
      #   args = ["start"];
      # };
      language = [
      ];
    };
  };

  home.packages = with pkgs; [
  ];
}
