{
  config,
  pkgs,
  ...
}: let
  cfg = config.extras.extraPackages;
in {
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
}
