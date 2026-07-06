{
  pkgs,
  lib,
  ...
}: let
  llama-cpp =
    (pkgs.llama-cpp.override {
      rocmSupport = true;
      blasSupport = true;
    }).overrideAttrs
    (oldAttrs: {
      version = "9878";
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
      # Enable native CPU optimizations (AVX, AVX2, etc.)
      npmDepsHash = "sha256-X1DZgmhS/zHTqDT5zq0kywwntthcJ9vRXeqyO3zz6UU=";
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
  users.users.llama-swap = {
    isSystemUser = true;
    group = "llama-swap";
  };
  users.groups.llama-swap = {};
  environment = {
    systemPackages = [llama-cpp];
  };
  services = {
    llama-swap = {
      enable = true;
      listenAddress = "0.0.0.0";
      settings = {
        healthCheckTimeout = 60;
        sendLoadingState = true;
        models = {
          "gemma-4-e2b" = {
            cmd = ''
              ${llama-cpp}/bin/llama-server \
              --port ''${PORT} \
              --hf-repo unsloth/gemma-4-E2B-it-qat-GGUF:UD-Q4_K_XL \
              --n-gpu-layers 99 \
              --flash-attn on \
              --ctx-size 128000 \
              --batch-size 4096 \
              --ubatch-size 1024 \
              --cache-type-k q8_0 \
              --cache-type-v q8_0 \
              --reasoning-budget 2048 \
              --temp 1.0 \
              --top-p 0.95 \
              --top-k 64 \
              --jinja \
              --cache-ram 32400 \
              --threads 16 \
              --kv-unified \
              --prio 2
            '';
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
  systemd.services.llama-swap = {
    serviceConfig = {
      User = lib.mkForce "llama-swap";
      DynamicUser = lib.mkForce false;
      ProtectHome = lib.mkForce false;
      MemoryDenyWriteExecute = lib.mkForce false;
    };
  };
}
