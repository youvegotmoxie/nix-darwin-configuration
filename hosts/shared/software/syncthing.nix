{config, ...}: {
  services.syncthing = {
    enable = true;
    overrideFolders = true;
    overrideDevices = true;
    settings = {
      folders = {
        "${config.home.homeDirectory}/Documents/Zed" = {
          id = "zed-journal";
          path = "${config.home.homeDirectory}/Documents/Zed";
          label = "zed-journal-directory";
        };
        "${config.home.homeDirectory}/.agents/skills" = {
          id = "zed-skills";
          path = "${config.home.homeDirectory}/.agents/skills";
          label = "zed-skills-directory";
        };
        "${config.home.homeDirectory}/.config/zed" = {
          id = "zed-config";
          path = "${config.home.homeDirectory}/.config/zed";
          label = "zed-config-directory";
        };
      };
    };
  };
}
