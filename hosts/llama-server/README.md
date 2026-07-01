## Nix Packages
- alejandra
- bat
- bat-extras.batman
- btop-rocm
- cmake
- delta
- fd
- findutils
- gawk
- gh
- git
- home-manager
- jq
- llama-cpp *(custom build: ROCm/AMD GPU, HIP BLAS, gfx1201 target)*
- neovim
- nh
- nil
- nix-output-monitor
- nixd
- p7zip
- pciutils
- prek
- python314
- python314Packages.pip
- ripgrep
- rustup
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

### Services
- openssh
- llama.cpp

## Models

| Model | Quantization | Context |
|-------|-------------|---------|
| `gemma-4-e2b` | Q4_K_XL | 128K |
| `gemma-4-e4b` | Q4_K_XL | 128K |
| `gemma-4-12B` | Q4_K_XL | 128K |
| `qwen3-4b-instruct` | Q4_K_XL | 64K |
| `gpt-oss-20B` | Q4_K_XL | 64K |
