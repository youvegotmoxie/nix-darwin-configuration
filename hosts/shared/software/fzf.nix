{...}: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = ["--exact"];
    # Disable ctrl-r keybind since Atuin manages shell history
    historyWidget.command = "";
    tmux = {
      enableShellIntegration = true;
    };
  };
}
