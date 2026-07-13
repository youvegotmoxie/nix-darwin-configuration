{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    # Disable the embedded ruby and python3 interpreters
    withRuby = false;
    withPython3 = false;
    # Don't overwrite ~/.config/nvim/init.lua
    sideloadInitLua = true;
  };

  programs.direnv = {
    enable = true;
    config = {
      warn_timeout = "10m";
    };
    nix-direnv = {
      enable = true;
    };
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    extraOptions = [
      "-lahg"
      "--git-repos-no-status"
    ];
  };
}
