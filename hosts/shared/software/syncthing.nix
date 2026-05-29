{config, ...}: {
  services.syncthing = {
    enable = true;
    overrideFolders = true;
    overrideDevices = true;
    settings = {
      devices = {
        "rpi4-timemachine" = {
          id = "SB2LFPA-NH4T4U7-6MVKGR3-YC24CDS-ANNW2M7-XFJMBAH-6UVPZVC-RWIQKAT";
        };
      };
      folders = {
        "${config.home.homeDirectory}/Documents/Zed" = {
          id = "zed-journal";
          path = "${config.home.homeDirectory}/Documents/Zed";
          label = "zed-journal-directory";
          devices = ["rpi4-timemachine"];
        };
        "${config.home.homeDirectory}/.agents/skills" = {
          id = "zed-skills";
          path = "${config.home.homeDirectory}/.agents/skills";
          label = "zed-skills-directory";
          devices = ["rpi4-timemachine"];
        };
        "${config.home.homeDirectory}/.config/zed" = {
          id = "zed-config";
          path = "${config.home.homeDirectory}/.config/zed";
          label = "zed-config-directory";
          devices = ["rpi4-timemachine"];
        };
      };
    };
  };
}
