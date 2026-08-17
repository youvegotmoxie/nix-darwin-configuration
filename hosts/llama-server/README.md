# llama-server

Custom built AMD machine with ROCm support.

Runs llama.cpp backend for llama-swap to handle local inference and model routing to fw-desktop.

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
- vnstat

## Models
Source: [`models.ini`](./users/mike/home-manager/dots/models.ini)

| Model | Quantization | Context | HuggingFace |
|-------|--------------|---------|-------------|
| qwen3.6-35B | Q4_K_M | 128K | [unsloth/Qwen3.6-35B-A3B-MTP-GGUF](https://huggingface.co/unsloth/Qwen3.6-35B-A3B-MTP-GGUF) |
| muse-glimmer-30B | Q5_K_M | 128K | [unsloth/Muse-Glimmer-30B-GGUF](https://huggingface.co/unsloth/Muse-Glimmer-30B-GGUF) |
| qwen3.8-27B | Q4_K_XL | 128K | [unsloth/Qwen3.8-27B-GGUF](https://huggingface.co/unsloth/Qwen3.8-27B-GGUF) |

## Hardware
- CPU: AMD Ryzen 7 3800X
- GPU: Dual AMD RX 9070 XT (ROCm target: gfx1201, 32GiB total)
- Memory: 48GiB DDR4
- Network interface: enp35s0
