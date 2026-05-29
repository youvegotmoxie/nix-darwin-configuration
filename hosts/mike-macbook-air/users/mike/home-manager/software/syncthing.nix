{...}: {
  services.syncthing = {
    settings = {
      overrideFolders = false;
      overrideDevices = false;
    };
  };
}
