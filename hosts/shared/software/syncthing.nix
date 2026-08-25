{
  config,
  lib,
  ...
}:
lib.mkIf config.extras.extraPackages.macOnly.enable {
  services.syncthing = {
    enable = true;
    overrideFolders = true;
    overrideDevices = true;
    settings = {
      folders = {
        "${config.home.homeDirectory}/.omlx/models" = {
          id = "omlx-models";
          path = "${config.home.homeDirectory}/.omlx/models";
          label = "omlx-models";
          devices = config.extras.syncthingTarget;
        };
        "${config.home.homeDirectory}/repos/projects" = {
          id = "projects";
          path = "${config.home.homeDirectory}/repos/projects";
          label = "projects";
          devices = config.extras.syncthingTarget;
        };
        "${config.home.homeDirectory}/Documents/Zed" = {
          id = "zed-journal";
          path = "${config.home.homeDirectory}/Documents/Zed";
          label = "zed-journal-directory";
          devices = config.extras.syncthingTarget;
        };
        "${config.home.homeDirectory}/.agents/skills" = {
          id = "zed-skills";
          path = "${config.home.homeDirectory}/.agents/skills";
          label = "zed-skills-directory";
          devices = config.extras.syncthingTarget;
          versioning = {
            type = "simple";
            params = {
              keep = "10";
              cleanoutDays = "30";
            };
          };
        };
        "${config.home.homeDirectory}/.config/zed" = {
          id = "zed-config";
          path = "${config.home.homeDirectory}/.config/zed";
          label = "zed-config-directory";
          devices = config.extras.syncthingTarget;
          versioning = {
            type = "simple";
            params = {
              keep = "10";
              cleanoutDays = "30";
            };
          };
        };
        "${config.home.homeDirectory}/.config/opencode" = {
          id = "opencode-config";
          path = "${config.home.homeDirectory}/.config/opencode";
          label = "opencode-config-directory";
          devices = config.extras.syncthingTarget;
          versioning = {
            type = "simple";
            params = {
              keep = "10";
              cleanoutDays = "30";
            };
          };
        };
      };
    };
  };
}
