{
  # Configure Git for the user
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        showNumstatInFilesView = true;
        nerdFontsVersion = "3";
      };
      git.paging = {
        pager = "delta --dark --paging=never --max-line-length=0";
        useConfig = false;
      };
    };
  };
  programs.git = {
    enable = true;
    userName = "Michael Beasley";
    userEmail = "michael.beasley@alvaria.com";
    signing.key = "~/.ssh/id_rsa.pub";
    extraConfig = {
      core = {
        pager = "delta --pager=never --max-line-length=0";
        editor = "hx";
      };
      init = {
        defaultBranch = "master";
      };
      pull = {
        rebase = false;
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        navigate = false;
        light = false;
        hyperlinks = true;
      };
      merge = {
        conflictstyle = "zdiff3";
      };
      diff = {
        colorMoved = "default";
      };
      push = {
        autoSetupRemove = true;
      };
      filter = {
        lfs = {
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          process = "git-lfs filter-process";
          required = true;
        };
      };
    };
  };
}
