{pkgs, ...}: let
  llama-cpp =
    (pkgs.llama-cpp.override {
      rocmSupport = true;
      blasSupport = true;
    }).overrideAttrs
    (oldAttrs: rec {
      version = "9843";
      src = pkgs.fetchFromGitHub {
        owner = "ggml-org";
        repo = "llama.cpp";
        tag = "b${version}";
        hash = "sha256-ZlAXXqoTqC4EJdY97ZPmu0rDLg+EQ5tJvRBabf3fnGU=";
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
  environment = {
    systemPackages = [llama-cpp];
  };
  services = {
    llama-swap = {
      enable = true;
      listenAddress = "0.0.0.0";
      port = 8080;
      settings = {
        healthCheckTimeout = 60;
        models = {
          "gemma-4-e2b" = {
            cmd = "${llama-cpp}/bin/llama-server --model /var/cache/llama-cpp/models--unsloth--gemma-4-E2B-it-qat-GGUF/gemma-4-E2B-it-qat-UD-Q4_K_XL.gguf";
            concurrencyLimit = 4;
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
# models--unsloth--Qwen3-4B-Instruct-2507-GGUF
# models--unsloth--gemma-4-12B-it-qat-GGUF
# models--unsloth--gemma-4-E2B-it-qat-GGUF
# models--unsloth--gemma-4-E4B-it-qat-GGUF
# models--unsloth--gpt-oss-20b-GGUF
