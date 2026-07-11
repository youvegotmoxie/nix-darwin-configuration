{ pkgs, lib, config, ... }: let
  llama-cpp = config.services.llama-cpp.package;
  default-ubatch-size = 2048;
  llama-swap = pkgs.llama-swap.overrideAttrs (oldAttrs: {
    version = "238";
    src = pkgs.fetchFromGitHub {
      owner = "mostlygeek";
      repo = "llama-swap";
      rev = "v${oldAttrs.version}";
      hash = "sha256-IblAaM9FBdI2Y9rg36SWpclQ0jV6Y93RC+N+cXWEO94=";
      leaveDotGit = true;
      postFetch = ''
        cd "$out"
        git rev-parse HEAD > $out/COMMIT
        date -u -d "@$(git log -1 --pretty=%ct)" "'+%Y-%m-%dT%H:%M:%SZ'" > $out/SOURCE_DATE_EPOCH
        find "$out" -name .git -print0 | xargs -0 rm -rf
      '';
    };
  });
in {
  # Use a normal user to run llama-swap so a homedir gets created
  # which makes managing things far easier, especially with the hf CLI tool
  users.users.llama-swap = {
    isNormalUser = true;
    group = "llama-swap";
  };
  users.groups.llama-swap = {};
  services = {
    llama-swap = {
      enable = false;
      package = llama-swap;
      listenAddress = "0.0.0.0";
      settings = {
        groups = {
          "small" = {
            # Swapping logic:
            # Allow all models in the group to be loaded at once
            # Loading from this group unloads loaded models from another group
            swap = false;
            exclusive = true;
            members = [
              "gemma-4-E2B-it-qat-GGUF:UD-Q4_K_XL"
              "Qwen3-4B-Instruct-2507-GGUF:UD-Q4_K_XL"
            ];
          };
          "medium" = {
            # Swapping logic:
            # Allow 1 model in the group to be loaded at once
            # Loading from this group unloads loaded models from another group
            swap = true;
            exclusive = true;
            members = [
              "gemma-4-E4B-it-qat-GGUF:UD-Q4_K_XL"
              "gemma-4-12B-it-qat-GGUF:UD-Q4_K_XL"
              "gpt-oss-20b-GGUF:UD-Q4_K_XL"
              "Qwen3-Coder-30B-A3B-Instruct-GGUF:Q4_K_M"
            ];
          };
        };
        hooks = {
          on_startup = {
            preload = ["gemma-4-E2B-it-qat-GGUF:UD-Q4_K_XL" "Qwen3-4B-Instruct-2507-GGUF:UD-Q4_K_XL"];
          };
        };
        healthCheckTimeout = 120;
        sendLoadingState = true;
        models = {
          "gemma-4-E2B-it-qat-GGUF:UD-Q4_K_XL" = {
            cmd = ''
              ${llama-cpp}/bin/llama-server \
              --port ''${PORT} \
              --hf-repo unsloth/gemma-4-E2B-it-qat-GGUF:UD-Q4_K_XL \
              --gpu-layers 99 \
              --flash-attn on \
              --ctx-size 128000 \
              --batch-size 4096 \
              --ubatch-size 4096 \
              --cache-type-k q8_0 \
              --cache-type-v q8_0 \
              --reasoning-budget 2048 \
              --spec-type draft-mtp \
              --spec-draft-n-max 3 \
              --temp 0.7 \
              --top-p 0.95 \
              --top-k 64 \
              --jinja \
              --cache-ram 32400 \
              --threads 16 \
              --kv-unified \
              --prio 2
            '';
            ttl = 1800;
            aliases = [
              "gemma-4-e2b"
            ];
          };
          "gemma-4-E4B-it-qat-GGUF:UD-Q4_K_XL" = {
            cmd = ''
              ${llama-cpp}/bin/llama-server \
              --port ''${PORT} \
              --hf-repo unsloth/gemma-4-E4B-it-qat-GGUF:UD-Q4_K_XL \
              --gpu-layers 99 \
              --flash-attn on \
              --ctx-size 128000 \
              --batch-size 4096 \
              --ubatch-size ${toString default-ubatch-size} \
              --cache-type-k q8_0 \
              --cache-type-v q8_0 \
              --reasoning-budget 2048 \
              --temp 0.7 \
              --top-p 0.95 \
              --top-k 64 \
              --jinja \
              --cache-ram 32400 \
              --threads 16 \
              --kv-unified \
              --prio 2
            '';
            ttl = 300;
            aliases = [
              "gemma-4-e4b"
            ];
          };
          "gemma-4-12B-it-qat-GGUF:UD-Q4_K_XL" = {
            cmd = ''
              ${llama-cpp}/bin/llama-server \
              --port ''${PORT} \
              --hf-repo unsloth/gemma-4-12B-it-qat-GGUF:UD-Q4_K_XL \
              --gpu-layers 99 \
              --flash-attn on \
              --ctx-size 128000 \
              --batch-size 4096 \
              --ubatch-size ${toString default-ubatch-size} \
              --cache-type-k q8_0 \
              --cache-type-v q8_0 \
              --reasoning-budget 2048 \
              --spec-type draft-mtp \
              --spec-draft-n-max 3 \
              --temp 0.7 \
              --top-p 0.95 \
              --top-k 64 \
              --jinja \
              --cache-ram 32400 \
              --threads 16 \
              --kv-unified \
              --prio 2
            '';
            ttl = 120;
            aliases = [
              "gemma-4-12B"
            ];
          };
          "Qwen3-4B-Instruct-2507-GGUF:UD-Q4_K_XL" = {
            cmd = ''
              ${llama-cpp}/bin/llama-server \
              --port ''${PORT} \
              --hf-repo unsloth/Qwen3-4B-Instruct-2507-GGUF:UD-Q4_K_XL \
              --gpu-layers 99 \
              --flash-attn on \
              --ctx-size 64000 \
              --batch-size 4096 \
              --ubatch-size ${toString default-ubatch-size} \
              --cache-type-k q8_0 \
              --cache-type-v q8_0 \
              --reasoning-budget 0 \
              --temp 0.7 \
              --top-p 0.95 \
              --top-k 20 \
              --min-p 0.00 \
              --jinja \
              --cache-ram 32400 \
              --threads 16 \
              --kv-unified \
              --prio 2
            '';
            ttl = 900;
            aliases = [
              "qwen3-4b-instruct"
            ];
          };
          "Qwen3-Coder-30B-A3B-Instruct-GGUF:Q4_K_M" = {
            cmd = ''
              ${llama-cpp}/bin/llama-server \
              --port ''${PORT} \
              --hf-repo unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q4_K_M \
              --gpu-layers 99 \
              --flash-attn on \
              --ctx-size 64000 \
              --batch-size 4096 \
              --ubatch-size ${toString default-ubatch-size} \
              --cache-type-k q8_0 \
              --cache-type-v q8_0 \
              --reasoning-budget 0 \
              --temp 0.7 \
              --top-p 0.8 \
              --top-k 20 \
              --min-p 0.00 \
              --repeat-penalty 1.05 \
              --cpu-moe on \
              --no-mmap \
              --jinja \
              --cache-ram 32400 \
              --threads 16 \
              --kv-unified \
              --prio 2
            '';
            ttl = 120;
            aliases = [
              "qwen-3-coder-30B"
            ];
          };
          "gpt-oss-20b-GGUF:UD-Q4_K_XL" = {
            cmd = ''
              ${llama-cpp}/bin/llama-server \
              --port ''${PORT} \
              --hf-repo unsloth/gpt-oss-20b-GGUF:UD-Q4_K_XL \
              --gpu-layers 99 \
              --flash-attn on \
              --ctx-size 64000 \
              --batch-size 4096 \
              --ubatch-size ${toString default-ubatch-size} \
              --cache-type-k q8_0 \
              --cache-type-v q8_0 \
              --reasoning-format auto \
              --reasoning-budget 2048 \
              --temp 0.7 \
              --top-p 1.0 \
              --no-mmap \
              --jinja \
              --cache-ram 32400 \
              --threads 16 \
              --kv-unified \
              --prio 2
            '';
            ttl = 120;
            aliases = [
              "gpt-oss-20B"
            ];
          };
        };
      };
    };
  };
  systemd.services.llama-swap = {
    serviceConfig = {
      User = lib.mkForce "llama-swap";
      Group = lib.mkForce "llama-swap";
      DynamicUser = lib.mkForce false;
      ProtectHome = lib.mkForce false;
    };
  };
}
