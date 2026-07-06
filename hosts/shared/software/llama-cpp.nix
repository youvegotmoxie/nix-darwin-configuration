{pkgs, ...}: let
  llama-cpp =
    (pkgs.llama-cpp.override {
      rocmSupport = true;
      blasSupport = true;
    }).overrideAttrs
    (oldAttrs: {
      version = "9852";
      src = pkgs.fetchFromGitHub {
        owner = "ggml-org";
        repo = "llama.cpp";
        tag = "b${oldAttrs.version}";
        hash = "sha256-QlhfzDvVA8qUfT73QujpqIuhNW8vOtc5xQ2FLN9ux7A=";
        leaveDotGit = true;
        postFetch = ''
          git -C "$out" rev-parse --short HEAD > $out/COMMIT
          find "$out" -name .git -print0 | xargs -0 rm -rf
        '';
      };
      # Enable native CPU optimizations (AVX, AVX2, etc.)
      npmDepsHash = "sha256-wtaHsVOyCNCITABe1TvDo/MiWpNlH2YqZewBDxERtt4=";
      cmakeFlags =
        (oldAttrs.cmakeFlags or [])
        ++ [
          "-DGGML_NATIVE=ON"
          "-DGGML_HIP=ON"
          "-DGPU_TARGETS=gfx1201"
          "-DCMAKE_BUILD_TYPE=Release"
        ];
      preConfigure = ''
        export NIX_ENFORCE_NO_NATIVE=0
        ${oldAttrs.preConfigure or ""}
      '';
    });
in {
  environment = {
    systemPackages = [llama-cpp];
  };
  services = {
    llama-swap = {
      enable = true;
      listenAddress = "0.0.0.0";
      settings = {
        healthCheckTimeout = 60;
        models = {
          "gemma-4-e2b" = {
            cmd = "${llama-cpp}/bin/llama-server --port \${PORT} -m /var/lib/llama-cpp/emma-4-E2B-it-qat-UD-Q4_K_XL.gguf -ngl 99";
            concurrencyLimit = 2;
            aliases = [
              "gemma-4-e2b"
            ];
          };
        };
      };
    };
    llama-cpp = {
      enable = false;
      package = llama-cpp;
      settings = {
        models-preset = "/var/lib/llama-cpp/models.ini";
        host = "0.0.0.0";
        port = 8080;
        cache-ram = 32400;
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        threads = 16;
        kv-unified = true;
        jinja = true;
        prio = 2;
      };
    };
  };
}
