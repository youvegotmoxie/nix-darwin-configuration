{...}: {
  programs.mcp = {
    enable = true;
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
        command = "uvx";
        args = ["mcp-nixos"];
      };
    };
  };
}
