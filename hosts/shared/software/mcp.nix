{
  flake-inputs,
  pkgs,
  config,
  ...
}: let
  cfg = config.extras.extraPackages;
  mcp-nixos-overlay = pkgs.extend flake-inputs.mcp-nixos.overlays.default;
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
        command = "${mcp-nixos-overlay.mcp-nixos}/bin/mcp-nixos";
        args = ["--"];
      };
    };
  };
}
