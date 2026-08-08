{
  config,
  ...
}: {
  programs.ssh = {
    includes = ["${config.home.homeDirectory}/.orbstack/ssh/config"];
  };
}
