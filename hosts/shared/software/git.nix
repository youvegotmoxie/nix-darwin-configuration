{
  lib,
  config,
  ...
}: let
  cfg = config.gitConfig.person;
in {
  options.gitConfig.person = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "Git username";
      default = "Michael Beasley";
    };
    email = lib.mkOption {
      type = lib.types.str;
      description = "Git email";
      default = "michael.beasley@alvaria.com";
    };
  };
  # Configure Git for the user
  config = {
    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          showNumstatInFilesView = true;
          nerdFontsVersion = "3";
        };

        # Moved git.paging object to git.pagers array
        git.pagers = [
          {
            pager = "delta --dark --paging=never --max-line-length=0";
            useConfig = false;
          }
        ];
      };
    };
    programs.git = {
      enable = true;
      signing.key = "0799D2A68981EEE3";
      settings = {
        user.name = "${cfg.name}";
        user.email = "${cfg.email}";
        core = {
          pager = "delta --pager=never --max-line-length=0";
          editor = "nvim";
        };
        alias = {
          tagrelease = "tag -as";
          ptags = "push --tags";
          com = "checkout master";
          pom = "pull origin master";
          sendit = "!f() { git add . ; git commit -S ; git push -u \$(git remote\) \$(git branch --show-current\);};f";
          fall = "fetch --all --verbose";
          pfall = "fetch --all --verbose --prune";
          logs = "log --stat --reverse";
          patchlog = "log --stat --patch --reverse";
          sts = "status --short --show-stash --branch --renames";
          alist = "config --global --get-regexp ^alias\.";
          co = "checkout";
          cb = "checkout -b";
          db = "branch -D";
          dbp = "push origin -d";
        };
        commit.gpgsign = true;
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
          followTags = true;
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
  };
}
