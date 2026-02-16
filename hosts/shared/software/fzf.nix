{...}: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = ["--exact"];
    tmux = {
      enableShellIntegration = true;
    };
  };
}
