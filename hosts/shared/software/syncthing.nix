{config, ...}: {
  services.syncthing = {
    enable = true;
    overrideFolders = true;
    overrideDevices = false;
    settings = {
      folders = {
        "${config.home.homeDirectory}/.agents/skills" = {
          id = "zed-skills";
          path = "${config.home.homeDirectory}/.agents/skills";
          label = "zed-skills-directory";
        };
      };
    };
  };
}
