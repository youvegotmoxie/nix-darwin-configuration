{config, ...}: {
  services.syncthing.settings = {
    devices = {
      "mike-mac-mini" = {
        id = "254YDIM-5DY6MRJ-T3VSQQE-3ADWZ2H-YYG5PGA-7K35VU7-TEHEWVR-6XURAAW";
      };
      "MBEASLEY-26MBP" = {
        id = "PEY4ZKM-6VZAVQ7-G4ZENTS-252Y6KU-ABROJ5O-HCRCHYE-CEZKZD5-CMCC7QI";
      };
    };
    folders = {
      "${config.home.homeDirectory}/.omlx/models" = {
        id = "omlx-models";
        path = "${config.home.homeDirectory}/.omlx/models";
        label = "omlx-models";
        devices = ["MBEASLEY-26MBP"];
      };
    };
  };
}
