{
  flake-inputs,
  pkgs,
  ...
}: let
  mcp-nixos-overlay = pkgs.extend flake-inputs.mcp-nixos.overlays.default;
in {
  programs.mcp = {
    enable = false;
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
