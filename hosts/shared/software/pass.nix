{pkgs, ...}: {
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (extension: [extension.pass-checkup extension.pass-otp]);
    settings = {
      PASSWORD_STORE_CLIP_TIME = "60";
      PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
      PASSWORD_STORE_GENERATED_LENGTH = "14";
    };
  };
}
