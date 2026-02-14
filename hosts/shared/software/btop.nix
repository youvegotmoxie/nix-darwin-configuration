{config, ...}: {
  # Configure btop
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "${config.home.homeDirectory}/.config/btop/themes/tokyo-night.theme";
      vim_keys = true;
      update_ms = 2000;
      proc_per_core = true;
      disks_filter = "exclude=/System/Volumes/VM /System/Volumes/Preboot /System/Volumes/Update /System/Volumes/xarts /System/Volumes/iSCPreboot /System/Volumes/Hardware /System/Volumes/Update/SFR/mnt1 /System/Volumes/Update/mnt1 /nix /Users/michaelbeasley/OrbStack /Volumes/.timemachine, disk_filter=/dev/disk4";
      net_iface = "en0";
    };
    themes = {
      tokyo-night = builtins.readFile ../dots/btop-tokyo-night-theme.conf;
    };
  };
}
