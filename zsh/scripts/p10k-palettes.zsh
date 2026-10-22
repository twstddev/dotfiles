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
# Additional theme palettes.
    dayfox)
      P10K_BLUE=#2848a9 P10K_RED=#6e33ce P10K_GREEN=#396847 P10K_YELLOW=#ac5402 P10K_CYAN=#287980 P10K_PINK=#a5222f ;;
    dawnfox)
      P10K_BLUE=#286983 P10K_RED=#907aa9 P10K_GREEN=#618774 P10K_YELLOW=#ea9d34 P10K_CYAN=#56949f P10K_PINK=#b4637a ;;
    nightfox)
      P10K_BLUE=#719cd6 P10K_RED=#9d79d6 P10K_GREEN=#81b29a P10K_YELLOW=#dbc074 P10K_CYAN=#63cdcf P10K_PINK=#c94f6d ;;
    duskfox)
      P10K_BLUE=#569fba P10K_RED=#c4a7e7 P10K_GREEN=#a3be8c P10K_YELLOW=#f6c177 P10K_CYAN=#9ccfd8 P10K_PINK=#eb6f92 ;;
    nordfox)
      P10K_BLUE=#81a1c1 P10K_RED=#b48ead P10K_GREEN=#a3be8c P10K_YELLOW=#ebcb8b P10K_CYAN=#88c0d0 P10K_PINK=#bf616a ;;
    terafox)
      P10K_BLUE=#5a93aa P10K_RED=#ad5c7c P10K_GREEN=#7aa4a1 P10K_YELLOW=#fda47f P10K_CYAN=#a1cdd8 P10K_PINK=#e85c51 ;;
    carbonfox)
      P10K_BLUE=#78a9ff P10K_RED=#be95ff P10K_GREEN=#25be6a P10K_YELLOW=#08bdba P10K_CYAN=#33b1ff P10K_PINK=#ee5396 ;;
    monokai-pro-light)
      P10K_BLUE=#e16032 P10K_RED=#7058be P10K_GREEN=#269d69 P10K_YELLOW=#cc7a0a P10K_CYAN=#1c8ca8 P10K_PINK=#e14775 ;;
    monokai-pro-pro)
      P10K_BLUE=#fc9867 P10K_RED=#ab9df2 P10K_GREEN=#a9dc76 P10K_YELLOW=#ffd866 P10K_CYAN=#78dce8 P10K_PINK=#ff6188 ;;
    monokai-pro-classic)
      P10K_BLUE=#fd971f P10K_RED=#ae81ff P10K_GREEN=#a6e22e P10K_YELLOW=#e6db74 P10K_CYAN=#66d9ef P10K_PINK=#f92672 ;;
    monokai-pro-octagon)
      P10K_BLUE=#ff9b5e P10K_RED=#c39ac9 P10K_GREEN=#bad761 P10K_YELLOW=#ffd76d P10K_CYAN=#9cd1bb P10K_PINK=#ff657a ;;
    monokai-pro-machine)
      P10K_BLUE=#ffb270 P10K_RED=#baa0f8 P10K_GREEN=#a2e57b P10K_YELLOW=#ffed72 P10K_CYAN=#7cd5f1 P10K_PINK=#ff6d7e ;;
    monokai-pro-ristretto)
      P10K_BLUE=#f38d70 P10K_RED=#a8a9eb P10K_GREEN=#adda78 P10K_YELLOW=#f9cc6c P10K_CYAN=#85dacc P10K_PINK=#fd6883 ;;
    monokai-pro-spectrum)
      P10K_BLUE=#fd9353 P10K_RED=#948ae3 P10K_GREEN=#7bd88f P10K_YELLOW=#fce566 P10K_CYAN=#5ad4e6 P10K_PINK=#fc618d ;;
    material-lighter)
      P10K_BLUE=#6e98eb P10K_RED=#b480d6 P10K_GREEN=#abcf76 P10K_YELLOW=#e6b455 P10K_CYAN=#71c6e7 P10K_PINK=#dc6068 ;;
    material-oceanic)
      P10K_BLUE=#6e98eb P10K_RED=#b480d6 P10K_GREEN=#abcf76 P10K_YELLOW=#e6b455 P10K_CYAN=#71c6e7 P10K_PINK=#dc6068 ;;
    material-darker)
      P10K_BLUE=#6e98eb P10K_RED=#b480d6 P10K_GREEN=#abcf76 P10K_YELLOW=#e6b455 P10K_CYAN=#71c6e7 P10K_PINK=#dc6068 ;;
    material-palenight)
      P10K_BLUE=#6e98eb P10K_RED=#b480d6 P10K_GREEN=#abcf76 P10K_YELLOW=#e6b455 P10K_CYAN=#71c6e7 P10K_PINK=#dc6068 ;;
    material-deep-ocean)
      P10K_BLUE=#6e98eb P10K_RED=#b480d6 P10K_GREEN=#abcf76 P10K_YELLOW=#e6b455 P10K_CYAN=#71c6e7 P10K_PINK=#dc6068 ;;
    onedark-light)
      P10K_BLUE=#4078f2 P10K_RED=#a626a4 P10K_GREEN=#50a14f P10K_YELLOW=#986801 P10K_CYAN=#0184bc P10K_PINK=#e45649 ;;
    onedark-dark)
      P10K_BLUE=#61afef P10K_RED=#c678dd P10K_GREEN=#98c379 P10K_YELLOW=#e5c07b P10K_CYAN=#56b6c2 P10K_PINK=#e86671 ;;
    onedark-darker)
      P10K_BLUE=#4fa6ed P10K_RED=#bf68d9 P10K_GREEN=#8ebd6b P10K_YELLOW=#e2b86b P10K_CYAN=#48b0bd P10K_PINK=#e55561 ;;
    onedark-cool)
      P10K_BLUE=#5ab0f6 P10K_RED=#ca72e4 P10K_GREEN=#97ca72 P10K_YELLOW=#ebc275 P10K_CYAN=#4dbdcb P10K_PINK=#ef5f6b ;;
    onedark-deep)
      P10K_BLUE=#41a7fc P10K_RED=#c75ae8 P10K_GREEN=#8bcd5b P10K_YELLOW=#efbd5d P10K_CYAN=#34bfd0 P10K_PINK=#f65866 ;;
    onedark-warm)
      P10K_BLUE=#68aee8 P10K_RED=#c27fd7 P10K_GREEN=#99bc80 P10K_YELLOW=#dfbe81 P10K_CYAN=#5fafb9 P10K_PINK=#e16d77 ;;
    onedark-warmer)
      P10K_BLUE=#57a5e5 P10K_RED=#bb70d2 P10K_GREEN=#8fb573 P10K_YELLOW=#dbb671 P10K_CYAN=#51a8b3 P10K_PINK=#de5d68 ;;

  esac
}
