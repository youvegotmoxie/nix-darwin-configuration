{config, ...}: {
  home.file = {
    ".config/mole/whitelist".source = ../dots/mole_whitelist;
    ".config/mole/purge_paths".source = ../dots/mole_purge_paths;
    ".config/mole/whitelist_optimize".source = ../dots/mole_whitelist_optimize;
    ".vimrc".source = ../dots/dot_vimrc;
    ".zsh.d/func.sh".source = ../dots/func.sh;
    ".rustup/settings.toml".source = ../dots/rustup_settings.toml;
    "${config.home.homeDirectory}/Library/Application Support/com.mitchellh.ghostty/config".source = ../dots/ghostty_config;
  };
}
