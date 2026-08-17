# fw-desktop

Framework Desktop. Runs llama.cpp model serving

## Packages
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
- shfmt
- shellcheck
- tmux
- tldr
- ugrep
- uutils-coreutils-noprefix
- uv
- viddy
- vim
- wget
- yq

## Services
- openssh
- docker
- fwupd
- vnstat
- llama.cpp: enabled (0.0.0.0:8080)
  - ROCm support (gfx1151 target)
  - 32 threads, Q8_0 KV cache
  - Tools and jinja enabled

## Models
Source: [models.ini](./users/mike/home-manager/dots/models.ini)

| Model | Quantization | Context | HuggingFace |
|-------|--------------|---------|-------------|
| qwen-3.5-122B | Q4_K_M | 128K | [unsloth/Qwen3.5-122B-A10B-MTP-GGUF](https://huggingface.co/unsloth/Qwen3.5-122B-A10B-MTP-GGUF) |

## Hardware
- CPU: AMD Ryzen AI MAX+ 395
- GPU: AMD Radeon 8060S (ROCm target: gfx1151)
- Memory: 128GiB total
- Network interface: enp191s0
