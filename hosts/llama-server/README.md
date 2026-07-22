# llama-server

AMD machine with ROCm support. Runs llama-swap through Docker for model serving

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

## Models
Source: [`models.ini`](./users/mike/home-manager/dots/models.ini)

| Model | Quantization | Context | HuggingFace | Idle Sleep |
|-------|--------------|---------|-------------|------------|
| gemma-4-e2b | Q4_K_XL | 128K | [unsloth/gemma-4-E2B-it-qat-GGUF](https://huggingface.co/unsloth/gemma-4-E2B-it-qat-GGUF) | 30 min |
| gemma-4-e4b | Q4_K_XL | 128K | [unsloth/gemma-4-E4B-it-qat-GGUF](https://huggingface.co/unsloth/gemma-4-E4B-it-qat-GGUF) | 5 min |
| gemma-4-12B | Q4_K_XL | 128K | [unsloth/gemma-4-12B-it-qat-GGUF](https://huggingface.co/unsloth/gemma-4-12B-it-qat-GGUF) | 2 min |
| qwen3-4b-instruct | Q4_K_XL | 64K | [unsloth/Qwen3-4B-Instruct-2507-GGUF](https://huggingface.co/unsloth/Qwen3-4B-Instruct-2507-GGUF) | 15 min |

## Hardware
- CPU: AMD Ryzen 7 3800X
- GPU: AMD RX 9070 XT (ROCm target: gfx1201)
- Memory: 48GiB DDR4
- Network interface: enp35s0
