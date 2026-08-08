{ config, ... }: {
  launchd.agents.hermes-dashboard = {
    enable = true;
    domain = "user";
    config = {
      ProgramArguments = [
        "${config.home.homeDirectory}/.hermes/hermes-agent/venv/bin/python"
        "-m"
        "hermes_cli.main"
        "dashboard"
        "--host"
        "0.0.0.0"
        "--port"
        "9119"
        "--no-open"
      ];
      WorkingDirectory = "${config.home.homeDirectory}/.hermes";
      EnvironmentVariables = {
        PATH = "${config.home.homeDirectory}/.hermes/hermes-agent/venv/bin:${config.home.homeDirectory}/.hermes/hermes-agent/node_modules/.bin:/etc/profiles/per-user/mike/bin:${config.home.homeDirectory}/.local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:${config.home.homeDirectory}/.nix-profile/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin";
        VIRTUAL_ENV = "${config.home.homeDirectory}/.hermes/hermes-agent/venv";
        HERMES_HOME = "${config.home.homeDirectory}/.hermes";
      };
      LimitLoadToSessionType = ["Aqua" "Background"];
      RunAtLoad = true;
      KeepAlive = true;
      ThrottleInterval = 10;
      ExitTimeOut = 60;
      StandardOutPath = "${config.home.homeDirectory}/.hermes/logs/dashboard.log";
      StandardErrorPath = "${config.home.homeDirectory}/.hermes/logs/dashboard.error.log";
    };
  };
}
