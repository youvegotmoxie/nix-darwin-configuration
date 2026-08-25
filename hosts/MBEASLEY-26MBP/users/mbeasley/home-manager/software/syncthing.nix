{config, lib, ...}: {
  services.syncthing.settings = lib.mkMerge [
    {
      devices = {
        "mike-mac-mini" = {
          id = "254YDIM-5DY6MRJ-T3VSQQE-3ADWZ2H-YYG5PGA-7K35VU7-TEHEWVR-6XURAAW";
        };
      };
      folders = {
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
    }
  ];
}
