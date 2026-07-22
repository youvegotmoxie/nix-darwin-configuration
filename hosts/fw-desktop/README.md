# fw-desktop

AMD workstation with ROCm support. Runs llama.cpp model serving

## Packages
- alejandra
- amdgpu_top
- atuin
- bat
- bat-extras.batman
- btop-rocm
- cmake
- delta
- direnv
- eza
- fd
- findutils
- gawk
- gh
- git
- home-manager
- jq
- lazygit
- lazydocker
- neovim
- nh
- nil
- nix-output-monitor
- nixd
- nodejs_26
- p7zip
- prek
- python314
- python314Packages.pip
- ripgrep
- rocm-smi
- rustup
- shfmt
- shellcheck
- tmux
- tldr
- uugrep
- uv
- viddy
- vim
- wget
- yq

## Services
- openssh
- docker
- fwupd
- llama.cpp: enabled (0.0.0.0:8080)
  - ROCm support (gfx1151 target)
  - 32 threads, Q8_0 KV cache
  - Tools and jinja enabled

## Models
Source: [models.ini](./users/mike/home-manager/dots/models.ini)

| Model | Quantization | Context | HuggingFace | Idle Sleep |
|-------|--------------|---------|-------------|------------|
| gemma-4-26B | Q4_K_XL | 128K | [unsloth/gemma-4-26B-A4B-it-qat-GGUF](https://huggingface.co/unsloth/gemma-4-26B-A4B-it-qat-GGUF) | 2 min |
| gpt-oss-20B | Q4_K_XL | 64K | [unsloth/gpt-oss-20b-GGUF](https://huggingface.co/unsloth/gpt-oss-20b-GGUF) | 2 min |
| qwen-3-coder-30B | Q4_K_M | 64K | [unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF](https://huggingface.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF) | 2 min |
| qwen-3.5-122B | Q4_K_M | 256K | [unsloth/Qwen3.5-122B-A10B-MTP-GGUF](https://huggingface.co/unsloth/Qwen3.5-122B-A10B-MTP-GGUF) | 2 min |
| ornith-1.0-35B | Q4_K_M | 256K | [deepreinforce-ai/Ornith-1.0-35B-GGUF](https://huggingface.co/deepreinforce-ai/Ornith-1.0-35B-GGUF) | 2 min |

## Hardware
- CPU: AMD Ryzen AI MAX+ 395
- GPU: AMD RX 7900 series (ROCm target: gfx1151)
- Memory: 128GiB LPDDR5X
- Network interface: enp191s0
