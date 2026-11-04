{config, ...}: {
  services.syncthing.settings = {
    devices = {
      "mike-mac-mini" = {
        id = "254YDIM-5DY6MRJ-T3VSQQE-3ADWZ2H-YYG5PGA-7K35VU7-TEHEWVR-6XURAAW";
      };
      "mike-macbook-pro" = {
        id = "SZK7DWS-XDKEDD5-YS4AUT5-AOUIGCC-BT3GHML-Y3AJGM2-ZEVEGK3-WHWOJAM";
      };
    };
    folders = {
      "${config.home.homeDirectory}/.omlx/models" = {
        id = "omlx-models";
        path = "${config.home.homeDirectory}/.omlx/models";
        label = "omlx-models";
        devices = ["mike-macbook-pro"];
      };
    };
  };
}
