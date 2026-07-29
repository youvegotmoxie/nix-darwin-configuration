{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.extras.extraPackages;
in {
  config = {
    programs.mcp = {
      enable = cfg.serverOnly.enable;
      servers = {
        context7 = {
          command = "npx";
          args = ["-y" "context7-mcp-server"];
        };
        terraform = {
          command = "npx";
          args = ["-y" "terraform-mcp-server"];
        };
        nixos = {
          command = "${pkgs.uv}/bin/uvx";
          args = ["mcp-nixos"];
        };
      };
    };

    home.packages = lib.mkIf cfg.serverOnly.enable (with pkgs; [
      nodejs_26
      uv
    ]);
  };
}
