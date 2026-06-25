{config, ...}: let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in {
  home.file = {
    ".config/mole/whitelist".source = mkOutOfStoreSymlink ../dots/mole_whitelist;
    ".config/mole/purge_paths".source = mkOutOfStoreSymlink ../dots/mole_purge_paths;
    ".config/mole/whitelist_optimize".source = mkOutOfStoreSymlink ../dots/mole_whitelist_optimize;
    ".config/raycast/ai/providers.yaml".source = mkOutOfStoreSymlink ../dots/raycast_providers.yaml;
    "Library/Application Support/com.mitchellh.ghostty/config".source = mkOutOfStoreSymlink ../dots/ghostty_config;
    ".rustup/settings.toml".source = mkOutOfStoreSymlink ../dots/rustup_settings.toml;
    ".vimrc".source = mkOutOfStoreSymlink ../dots/dot_vimrc;
    ".zsh.d/func.sh".source = mkOutOfStoreSymlink ../dots/func.sh;
  };
}
