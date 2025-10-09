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
      tokyo-night = ''
        theme[main_bg]="#1a1b26"
        theme[main_fg]="#cfc9c2"
        theme[title]="#cfc9c2"
        theme[hi_fg]="#7dcfff"
        theme[selected_bg]="#414868"
        theme[selected_fg]="#cfc9c2"
        theme[inactive_fg]="#565f89"
        theme[proc_misc]="#7dcfff"
        theme[cpu_box]="#565f89"
        theme[mem_box]="#565f89"
        theme[net_box]="#565f89"
        theme[proc_box]="#565f89"
        theme[div_line]="#565f89"
        theme[temp_start]="#9ece6a"
        theme[temp_mid]="#e0af68"
        theme[temp_end]="#f7768e"
        theme[cpu_start]="#9ece6a"
        theme[cpu_mid]="#e0af68"
        theme[cpu_end]="#f7768e"
        theme[free_start]="#9ece6a"
        theme[free_mid]="#e0af68"
        theme[free_end]="#f7768e"
        theme[cached_start]="#9ece6a"
        theme[cached_mid]="#e0af68"
        theme[cached_end]="#f7768e"
        theme[available_start]="#9ece6a"
        theme[available_mid]="#e0af68"
        theme[available_end]="#f7768e"
        theme[used_start]="#9ece6a"
        theme[used_mid]="#e0af68"
        theme[used_end]="#f7768e"
        theme[download_start]="#9ece6a"
        theme[download_mid]="#e0af68"
        theme[download_end]="#f7768e"
        theme[upload_start]="#9ece6a"
        theme[upload_mid]="#e0af68"
        theme[upload_end]="#f7768e"
      '';
    };
  };
}
