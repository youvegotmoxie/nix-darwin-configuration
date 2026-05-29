{config, ...}: {
  services.syncthing = {
    settings = {
      devices = {
        "mike-macbook-air" = {
          id = "QOLXRZD-ZSQP7MT-3GFCUAU-PJ3HZR7-5M3TESB-6GYSIM5-ZHNBV66-GA3L4AT";
        };
      };
      folders = {
        "${config.home.homeDirectory}/Documents/Zed" = {
          devices = ["mike-macbook-air"];
        };
        "${config.home.homeDirectory}/.agents/skills" = {
          devices = ["mike-macbook-air"];
        };
        "${config.home.homeDirectory}/.config/zed" = {
          devices = ["mike-macbook-air"];
        };
      };
    };
  };
}
