{
  pkgs,
  lib,
  ...
}: let
  llama-swap = pkgs.llama-swap.overrideAttrs (oldAttrs: {
    version = "235";
    src = pkgs.fetchFromGitHub {
      owner = "mostlygeek";
      repo = "llama-swap";
      rev = "v${oldAttrs.version}";
      hash = "sha256-IblAaM9FBdI2Y9rg36SWpclQ0jV6Y93RC+N+cXWEO94=";
      leaveDotGit = true;
      postFetch = ''
        cd "$out"
        git rev-parse HEAD > $out/COMMIT
        date -u -d "@$(git log -1 --pretty=%ct)" "+'%Y-%m-%dT%H:%M:%SZ'" > $out/SOURCE_DATE_EPOCH
        find "$out" -name .git -print0 | xargs -0 rm -rf
      '';
    };
  });
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
    isNormalUser = true;
    group = "llama-swap";
  };
  users.groups.llama-swap = {};
  environment = {
    systemPackages = [llama-cpp];
  };
  services = {
    llama-swap = {
      enable = true;
      package = llama-swap;
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
              --spec-type draft-mtp \
              --spec-draft-n-max 3 \
              --temp 1.0 \
              --top-p 0.95 \
              --top-k 64 \
              --jinja \
              --cache-ram 32400 \
              --threads 16 \
              --kv-unified \
              --prio 2
            '';
            aliases = [
              "gemma-4-e2b"
            ];
          };
          "gemma-4-e4b" = {
            cmd = ''
              ${llama-cpp}/bin/llama-server \
              --port ''${PORT} \
              --hf-repo unsloth/gemma-4-E4B-it-qat-GGUF:UD-Q4_K_XL \
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
            aliases = [
              "gemma-4-e4b"
            ];
          };
          "gemma-4-12B" = {
            cmd = ''
              ${llama-cpp}/bin/llama-server \
              --port ''${PORT} \
              --hf-repo unsloth/gemma-4-12B-it-qat-GGUF:UD-Q4_K_XL \
              --n-gpu-layers 99 \
              --flash-attn on \
              --ctx-size 128000 \
              --batch-size 4096 \
              --ubatch-size 1024 \
              --cache-type-k q8_0 \
              --cache-type-v q8_0 \
              --reasoning-budget 2048 \
              --spec-type draft-mtp \
              --spec-draft-n-max 3 \
              --temp 1.0 \
              --top-p 0.95 \
              --top-k 64 \
              --jinja \
              --cache-ram 32400 \
              --threads 16 \
              --kv-unified \
              --prio 2
            '';
            aliases = [
              "gemma-4-12B"
            ];
          };
          "qwen3-4b-instruct" = {
            cmd = ''
              ${llama-cpp}/bin/llama-server \
              --port ''${PORT} \
              --hf-repo unsloth/Qwen3-4B-Instruct-2507-GGUF:UD-Q4_K_XL \
              --n-gpu-layers 99 \
              --flash-attn on \
              --ctx-size 64000 \
              --batch-size 4096 \
              --ubatch-size 1024 \
              --cache-type-k q8_0 \
              --cache-type-v q8_0 \
              --reasoning-budget 0 \
              --temp 1.0 \
              --top-p 0.95 \
              --top-k 20 \
              --min-p 0.00 \
              --jinja \
              --cache-ram 32400 \
              --threads 16 \
              --kv-unified \
              --prio 2
            '';
            aliases = [
              "qwen3-4b-instruct"
            ];
          };
          "gpt-oss-20B" = {
            cmd = ''
              ${llama-cpp}/bin/llama-server \
              --port ''${PORT} \
              --hf-repo unsloth/gpt-oss-20b-GGUF:UD-Q4_K_XL \
              --n-gpu-layers 99 \
              --flash-attn on \
              --ctx-size 64000 \
              --batch-size 4096 \
              --ubatch-size 1024 \
              --cache-type-k q8_0 \
              --cache-type-v q8_0 \
              --reasoning-format auto \
              --reasoning-budget 2048 \
              --temp 1.0 \
              --top-p 1.0 \
              --jinja \
              --cache-ram 32400 \
              --threads 16 \
              --kv-unified \
              --prio 2
            '';
            aliases = [
              "gpt-oss-20B"
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
