{...}: {
  imports = [../shared/darwin.nix];

  # Use Homebrew for these to avoid a bunch of compiling
  homebrew = {
    brews = [
      "ffmpeg"
      "yt-dlp"
    ];
  };
}
