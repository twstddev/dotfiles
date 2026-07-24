# p10k theme palettes — role hex per palette, mirroring tmux/palettes/*.conf
# (same 6 role names + hex).
# Sourced by p10k.zsh. `_p10k_palette <name>` sets P10K_{BLUE,RED,GREEN,YELLOW,
# CYAN,PINK} to that palette's hex. Unknown/blank name => catppuccin-mocha.
#
# NOTE: keep in sync with tmux/palettes/*.conf.

_p10k_palette() {
  case ${1:-catppuccin-mocha} in
    catppuccin-frappe)
      P10K_BLUE=#8caaee P10K_RED=#ea999c P10K_GREEN=#a6d189 P10K_YELLOW=#e5c890 P10K_CYAN=#99d1db P10K_PINK=#e78284 ;;
    catppuccin-latte)
      P10K_BLUE=#1e66f5 P10K_RED=#e64553 P10K_GREEN=#40a02b P10K_YELLOW=#df8e1d P10K_CYAN=#04a5e5 P10K_PINK=#d20f39 ;;
    catppuccin-macchiato)
      P10K_BLUE=#8aadf4 P10K_RED=#ee99a0 P10K_GREEN=#a6da95 P10K_YELLOW=#eed49f P10K_CYAN=#91d7e3 P10K_PINK=#ed8796 ;;
    catppuccin-mocha)
      P10K_BLUE=#89b4fa P10K_RED=#eba0ac P10K_GREEN=#a6e3a1 P10K_YELLOW=#f9e2af P10K_CYAN=#89dceb P10K_PINK=#f38ba8 ;;
    everforest-dark)
      P10K_BLUE=#7fbbb3 P10K_RED=#d699b6 P10K_GREEN=#a7c080 P10K_YELLOW=#dbbc7f P10K_CYAN=#89bca6 P10K_PINK=#e67e80 ;;
    everforest-light)
      P10K_BLUE=#3a94c5 P10K_RED=#df69ba P10K_GREEN=#8da101 P10K_YELLOW=#dfa000 P10K_CYAN=#4f9794 P10K_PINK=#f85552 ;;
    gruvbox-dark)
      P10K_BLUE=#83a598 P10K_RED=#d3869b P10K_GREEN=#b8bb26 P10K_YELLOW=#fabd2f P10K_CYAN=#90aa7c P10K_PINK=#fb4934 ;;
    gruvbox-light)
      P10K_BLUE=#076678 P10K_RED=#8f3f71 P10K_GREEN=#79740e P10K_YELLOW=#b57614 P10K_CYAN=#246a5e P10K_PINK=#9d0006 ;;
    kanagawa-dragon)
      P10K_BLUE=#658594 P10K_RED=#a292a3 P10K_GREEN=#87a987 P10K_YELLOW=#c4b28a P10K_CYAN=#6e8e91 P10K_PINK=#c4746e ;;
    kanagawa-lotus)
      P10K_BLUE=#4d699b P10K_RED=#b35b79 P10K_GREEN=#6f894e P10K_YELLOW=#77713f P10K_CYAN=#567188 P10K_PINK=#c84053 ;;
    kanagawa-wave)
      P10K_BLUE=#7e9cd8 P10K_RED=#d27e99 P10K_GREEN=#98bb6c P10K_YELLOW=#e6c384 P10K_CYAN=#84a4bd P10K_PINK=#e46876 ;;
    nord-dark)
      P10K_BLUE=#5e81ac P10K_RED=#b48ead P10K_GREEN=#a3be8c P10K_YELLOW=#ebcb8b P10K_CYAN=#6f90a4 P10K_PINK=#bf616a ;;
    rose-pine-dawn)
      P10K_BLUE=#56949f P10K_RED=#d7827e P10K_GREEN=#6d8f89 P10K_YELLOW=#907aa9 P10K_CYAN=#5c939a P10K_PINK=#b4637a ;;
    rose-pine-main)
      P10K_BLUE=#9ccfd8 P10K_RED=#ebbcba P10K_GREEN=#95b1ac P10K_YELLOW=#c4a7e7 P10K_CYAN=#9ac8cd P10K_PINK=#eb6f92 ;;
    rose-pine-moon)
      P10K_BLUE=#9ccfd8 P10K_RED=#ea9a97 P10K_GREEN=#95b1ac P10K_YELLOW=#c4a7e7 P10K_CYAN=#9ac8cd P10K_PINK=#eb6f92 ;;
    solarized-dark)
      P10K_BLUE=#268bd2 P10K_RED=#d33682 P10K_GREEN=#859900 P10K_YELLOW=#b58900 P10K_CYAN=#3e8e9e P10K_PINK=#dc322f ;;
    solarized-light)
      P10K_BLUE=#268bd2 P10K_RED=#d33682 P10K_GREEN=#859900 P10K_YELLOW=#b58900 P10K_CYAN=#3e8e9e P10K_PINK=#dc322f ;;
    tokyonight-day)
      P10K_BLUE=#2e7de9 P10K_RED=#9854f1 P10K_GREEN=#587539 P10K_YELLOW=#8c6c3e P10K_CYAN=#387bbd P10K_PINK=#f52a65 ;;
    tokyonight-moon)
      P10K_BLUE=#82aaff P10K_RED=#c099ff P10K_GREEN=#c3e88d P10K_YELLOW=#ffc777 P10K_CYAN=#92bae2 P10K_PINK=#ff757f ;;
    tokyonight-night)
      P10K_BLUE=#7aa2f7 P10K_RED=#bb9af7 P10K_GREEN=#9ece6a P10K_YELLOW=#e0af68 P10K_CYAN=#83add4 P10K_PINK=#f7768e ;;
    tokyonight-storm)
      P10K_BLUE=#7aa2f7 P10K_RED=#bb9af7 P10K_GREEN=#9ece6a P10K_YELLOW=#e0af68 P10K_CYAN=#83add4 P10K_PINK=#f7768e ;;
  esac
}
