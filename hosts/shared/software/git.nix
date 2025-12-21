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
      signing.key = "${config.home.homeDirectory}/.ssh/git-signing_ed25519.pub";
      settings = {
        user.name = "${cfg.name}";
        user.email = "${cfg.email}";
        core = {
          pager = "delta --pager=never --max-line-length=0";
          editor = "hx";
        };
        alias = {
          tagrelease = "tag -as";
          com = "checkout master";
          pom = "pull origin master";
          sendit = "!f() { git add . && git commit -S && git push -u $(git remote) $(git branch);};f";
        };
        gpg.format = "ssh";
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
