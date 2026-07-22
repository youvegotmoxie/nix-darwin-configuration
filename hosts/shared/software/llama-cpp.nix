{ pkgs, lib, ... }: let
  llama-cpp =
    (pkgs.llama-cpp.override {
      rocmSupport = true;
      blasSupport = true;
      # vulkanSupport = true;
    }).overrideAttrs
    (oldAttrs: {
      version = "10081";
      src = pkgs.fetchFromGitHub {
        owner = "ggml-org";
        repo = "llama.cpp";
        tag = "b${oldAttrs.version}";
        hash = "sha256-wtaHsVOyCNCITABe1TvDo/MiWpNlH2YqZewBDxERtt4=";
        leaveDotGit = true;
        postFetch = ''
          git -C "$out" rev-parse --short HEAD > $out/COMMIT
          find "$out" -name .git -print0 | xargs -0 rm -rf
        '';
      };
      npmDepsHash = "sha256-X1DZgmhS/zHTqDT5zq0kywwntthcJ9vRXeqyO3zz6UU=";
      cmakeFlags =
        (oldAttrs.cmakeFlags or [])
        ++ [
          "-DGGML_NATIVE=ON"
          "-DGGML_HIP=ON"
          "-DGPU_TARGETS=gfx1151"
          "-DCMAKE_BUILD_TYPE=Release"
        ];
      preConfigure = ''
        export NIX_ENFORCE_NO_NATIVE=0
        ${oldAttrs.preConfigure or ""}
      '';
    });
in {
  services = {
    llama-cpp = {
      enable = true;
      package = llama-cpp;
      settings = {
        models-preset = "/var/lib/llama-cpp/models.ini";
        host = "0.0.0.0";
        port = 8080;
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        threads = 32;
        kv-unified = true;
        tools = "all";
        jinja = true;
        prio = 2;
      };
    };
  };
  systemd.services.llama-cpp.serviceConfig = lib.mkMerge [{
    Environment = "GPU_MAX_HW_QUEUES=1";
  }];
}
