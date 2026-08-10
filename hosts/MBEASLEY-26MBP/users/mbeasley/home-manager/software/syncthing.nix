{config, lib, ...}: {
  services.syncthing.settings.folders = lib.mkMerge [
    {
      "${config.home.homeDirectory}/.config/opencode" = {
        id = "opencode-config";
        path = "${config.home.homeDirectory}/.config/opencode";
        label = "opencode-config-directory";
        devices = ["rpi4-timemachine"];
        versioning = {
          type = "simple";
          params = {
            keep = "10";
            cleanoutDays = "30";
          };
        };
      };
    }
  ];
}
