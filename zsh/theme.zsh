# Semantic colors for Zsh UI components, keyed by the shared theme palette.
typeset -gA _ZSH_THEME_MUTED=(
  catppuccin-frappe    '#737994'
  catppuccin-latte     '#9ca0b0'
  catppuccin-macchiato '#6e738d'
  catppuccin-mocha     '#6c7086'
  everforest-dark      '#859289'
  everforest-light     '#939f91'
  gruvbox-dark         '#928374'
  gruvbox-light        '#928374'
  kanagawa-dragon      '#737c73'
  kanagawa-lotus       '#716e61'
  kanagawa-wave        '#727169'
  nord-dark            '#616e88'
  rose-pine-dawn       '#9893a5'
  rose-pine-main       '#6e6a86'
  rose-pine-moon       '#6e6a86'
  solarized-dark       '#586e75'
  solarized-light      '#93a1a1'
  tokyonight-day       '#848cb5'
  tokyonight-moon      '#636da6'
  tokyonight-night     '#565f89'
  tokyonight-storm     '#565f89'
)

zsh_theme_apply() {
  local palette=${1:-catppuccin-mocha}
  typeset -gx ZSH_THEME_MUTED=${_ZSH_THEME_MUTED[$palette]:-8}
}

zsh_theme_apply ${THEME_PALETTE:-catppuccin-mocha}
