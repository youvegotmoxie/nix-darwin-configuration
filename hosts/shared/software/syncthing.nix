{config, ...}: {
  services.syncthing = {
    enable = false;
    overrideFolders = true;
    overrideDevices = false;
    settings = {
      folders = {
        "${config.home.homeDirectory}/.config/zed" = {
          id = "zed-config";
          path = "${config.home.homeDirectory}/.config/zed";
          label = "zed-config-directory";
        };
        "${config.home.homeDirectory}/.agents/skills" = {
          id = "zed-skills";
          path = "${config.home.homeDirectory}/.agents/skills";
          label = "zed-skills-directory";
        };
      };
    };
  };
}
