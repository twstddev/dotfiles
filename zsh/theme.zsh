# theme.zsh — one command to switch colorscheme + light/dark across apps.
#
# Usage:
#   theme                          show current selection
#   theme list                     list schemes, modes and variants
#   theme <scheme>                 switch scheme, keep mode, use mode default variant
#   theme <scheme> <mode>          switch scheme + mode, use mode default variant
#   theme <scheme> <mode> <variant>  switch scheme + mode + explicit variant
#   theme <mode>                   flip mode only (keeps scheme, uses default variant)
#
# This is the PLUMBING layer only. It resolves the selection against the
# registry below and writes it to $THEME_STATE_DIR/current (a sourceable file).
# Each app (nvim, tmux, ghostty) reads that file separately — wiring the apps
# up is done later, once each theme is installed in that app.
#
# NOTE: nvim colorscheme names + backgrounds are known-good. ghostty and tmux
# values are best-guess placeholders and MUST be verified against each app's
# actual theme names when that app is wired up.

typeset -g THEME_STATE_DIR="${THEME_STATE_DIR:-$HOME/.config/theme}"
typeset -g THEME_GHOSTTY_CONFIG="${THEME_GHOSTTY_CONFIG:-$HOME/.config/ghostty/config}"

# Ordered list of selectable schemes.
typeset -ga _THEME_SCHEMES=(
  catppuccin tokyonight gruvbox rose-pine everforest kanagawa solarized nord
)

# Variants per scheme+mode. First entry in each list is that mode's default.
# Empty/unset list => scheme does not support that mode.
typeset -gA _THEME_VARIANTS
_THEME_VARIANTS=(
  "catppuccin:light"  "latte"
  "catppuccin:dark"   "mocha frappe macchiato"
  "tokyonight:light"  "day"
  "tokyonight:dark"   "night storm moon"
  "gruvbox:light"     "medium hard soft"
  "gruvbox:dark"      "medium hard soft"
  "rose-pine:light"   "dawn"
  "rose-pine:dark"    "main moon"
  "everforest:light"  "medium hard soft"
  "everforest:dark"   "medium hard soft"
  "kanagawa:light"    "lotus"
  "kanagawa:dark"     "wave dragon"
  "solarized:light"   "solarized"
  "solarized:dark"    "solarized"
  "nord:dark"         "nord"
)

# Per-variant app values. Keys: "<scheme>:<mode>:<variant>:<field>".
# Fields: nvim (colorscheme), bg (background), ghostty, tmux.
typeset -gA _THEME
_THEME=(
  # catppuccin -----------------------------------------------------------
  "catppuccin:light:latte:nvim"        catppuccin-latte
  "catppuccin:light:latte:bg"          light
  "catppuccin:light:latte:ghostty"     "Catppuccin Latte"
  "catppuccin:light:latte:tmux"        latte
  "catppuccin:dark:mocha:nvim"         catppuccin-mocha
  "catppuccin:dark:mocha:bg"           dark
  "catppuccin:dark:mocha:ghostty"      "Catppuccin Mocha"
  "catppuccin:dark:mocha:tmux"         mocha
  "catppuccin:dark:frappe:nvim"        catppuccin-frappe
  "catppuccin:dark:frappe:bg"          dark
  "catppuccin:dark:frappe:ghostty"     "Catppuccin Frappe"
  "catppuccin:dark:frappe:tmux"        frappe
  "catppuccin:dark:macchiato:nvim"     catppuccin-macchiato
  "catppuccin:dark:macchiato:bg"       dark
  "catppuccin:dark:macchiato:ghostty"  "Catppuccin Macchiato"
  "catppuccin:dark:macchiato:tmux"     macchiato

  # tokyonight -----------------------------------------------------------
  "tokyonight:light:day:nvim"          tokyonight-day
  "tokyonight:light:day:bg"            light
  "tokyonight:light:day:ghostty"       "TokyoNight Day"
  "tokyonight:light:day:tmux"          tokyonight_day
  "tokyonight:dark:night:nvim"         tokyonight-night
  "tokyonight:dark:night:bg"           dark
  "tokyonight:dark:night:ghostty"      "TokyoNight Night"
  "tokyonight:dark:night:tmux"         tokyonight_night
  "tokyonight:dark:storm:nvim"         tokyonight-storm
  "tokyonight:dark:storm:bg"           dark
  "tokyonight:dark:storm:ghostty"      "TokyoNight Storm"
  "tokyonight:dark:storm:tmux"         tokyonight_storm
  "tokyonight:dark:moon:nvim"          tokyonight-moon
  "tokyonight:dark:moon:bg"            dark
  "tokyonight:dark:moon:ghostty"       "TokyoNight Moon"
  "tokyonight:dark:moon:tmux"          tokyonight_moon

  # gruvbox (single colorscheme; contrast via variant, mode via bg) -------
  "gruvbox:light:medium:nvim"          gruvbox
  "gruvbox:light:medium:bg"            light
  "gruvbox:light:medium:ghostty"       "Gruvbox Light"
  "gruvbox:light:medium:tmux"          gruvbox_light_medium
  "gruvbox:light:hard:nvim"            gruvbox
  "gruvbox:light:hard:bg"              light
  "gruvbox:light:hard:ghostty"         "Gruvbox Light Hard"
  "gruvbox:light:hard:tmux"            gruvbox_light_hard
  "gruvbox:light:soft:nvim"            gruvbox
  "gruvbox:light:soft:bg"              light
  "gruvbox:light:soft:ghostty"         "Gruvbox Light"
  "gruvbox:light:soft:tmux"            gruvbox_light_soft
  "gruvbox:dark:medium:nvim"           gruvbox
  "gruvbox:dark:medium:bg"             dark
  "gruvbox:dark:medium:ghostty"        "Gruvbox Dark"
  "gruvbox:dark:medium:tmux"           gruvbox_dark_medium
  "gruvbox:dark:hard:nvim"             gruvbox
  "gruvbox:dark:hard:bg"               dark
  "gruvbox:dark:hard:ghostty"          "Gruvbox Dark Hard"
  "gruvbox:dark:hard:tmux"             gruvbox_dark_hard
  "gruvbox:dark:soft:nvim"             gruvbox
  "gruvbox:dark:soft:bg"               dark
  "gruvbox:dark:soft:ghostty"          "Gruvbox Dark"
  "gruvbox:dark:soft:tmux"             gruvbox_dark_soft

  # rose-pine ------------------------------------------------------------
  "rose-pine:light:dawn:nvim"          rose-pine-dawn
  "rose-pine:light:dawn:bg"            light
  "rose-pine:light:dawn:ghostty"       "Rose Pine Dawn"
  "rose-pine:light:dawn:tmux"          dawn
  "rose-pine:dark:main:nvim"           rose-pine-main
  "rose-pine:dark:main:bg"             dark
  "rose-pine:dark:main:ghostty"        "Rose Pine"
  "rose-pine:dark:main:tmux"           main
  "rose-pine:dark:moon:nvim"           rose-pine-moon
  "rose-pine:dark:moon:bg"             dark
  "rose-pine:dark:moon:ghostty"        "Rose Pine Moon"
  "rose-pine:dark:moon:tmux"           moon

  # everforest (single colorscheme; contrast via variant) ----------------
  "everforest:light:medium:nvim"       everforest
  "everforest:light:medium:bg"         light
  "everforest:light:medium:ghostty"    "Everforest Light Med"
  "everforest:light:medium:tmux"       everforest_light_medium
  "everforest:light:hard:nvim"         everforest
  "everforest:light:hard:bg"           light
  "everforest:light:hard:ghostty"      "Everforest Light Med"
  "everforest:light:hard:tmux"         everforest_light_hard
  "everforest:light:soft:nvim"         everforest
  "everforest:light:soft:bg"           light
  "everforest:light:soft:ghostty"      "Everforest Light Med"
  "everforest:light:soft:tmux"         everforest_light_soft
  "everforest:dark:medium:nvim"        everforest
  "everforest:dark:medium:bg"          dark
  "everforest:dark:medium:ghostty"     "Everforest Dark Hard"
  "everforest:dark:medium:tmux"        everforest_dark_medium
  "everforest:dark:hard:nvim"          everforest
  "everforest:dark:hard:bg"            dark
  "everforest:dark:hard:ghostty"       "Everforest Dark Hard"
  "everforest:dark:hard:tmux"          everforest_dark_hard
  "everforest:dark:soft:nvim"          everforest
  "everforest:dark:soft:bg"            dark
  "everforest:dark:soft:ghostty"       "Everforest Dark Hard"
  "everforest:dark:soft:tmux"          everforest_dark_soft

  # kanagawa -------------------------------------------------------------
  "kanagawa:light:lotus:nvim"          kanagawa-lotus
  "kanagawa:light:lotus:bg"            light
  "kanagawa:light:lotus:ghostty"       "Kanagawa Lotus"
  "kanagawa:light:lotus:tmux"          lotus
  "kanagawa:dark:wave:nvim"            kanagawa-wave
  "kanagawa:dark:wave:bg"              dark
  "kanagawa:dark:wave:ghostty"         "Kanagawa Wave"
  "kanagawa:dark:wave:tmux"            wave
  "kanagawa:dark:dragon:nvim"          kanagawa-dragon
  "kanagawa:dark:dragon:bg"            dark
  "kanagawa:dark:dragon:ghostty"       "Kanagawa Dragon"
  "kanagawa:dark:dragon:tmux"          dragon

  # solarized (single colorscheme, background toggles mode) --------------
  "solarized:light:solarized:nvim"     solarized
  "solarized:light:solarized:bg"       light
  "solarized:light:solarized:ghostty"  "iTerm2 Solarized Light"
  "solarized:light:solarized:tmux"     solarized_light
  "solarized:dark:solarized:nvim"      solarized
  "solarized:dark:solarized:bg"        dark
  "solarized:dark:solarized:ghostty"   "iTerm2 Solarized Dark"
  "solarized:dark:solarized:tmux"      solarized_dark

  # nord (dark only) -----------------------------------------------------
  "nord:dark:nord:nvim"                nord
  "nord:dark:nord:bg"                  dark
  "nord:dark:nord:ghostty"             "Nord"
  "nord:dark:nord:tmux"                nord
)

_theme_is_scheme() { (( ${_THEME_SCHEMES[(Ie)$1]} )) }
_theme_is_mode()   { [[ $1 == light || $1 == dark ]] }

# Variants for a scheme+mode as an array; empty if the mode is unsupported.
_theme_variants_of() { print -r -- ${(z)_THEME_VARIANTS[$1:$2]} }
# Default (first) variant for a scheme+mode.
_theme_default_variant() { local v=(${(z)_THEME_VARIANTS[$1:$2]}); print -r -- $v[1] }
_theme_scheme_supports() { [[ -n ${_THEME_VARIANTS[$1:$2]} ]] }
_theme_is_variant() { local v=(${(z)_THEME_VARIANTS[$1:$2]}); (( ${v[(Ie)$3]} )) }

# Load current selection into _cur_{scheme,mode,variant} (defaults: catppuccin dark mocha).
_theme_load() {
  local THEME_SCHEME THEME_MODE THEME_VARIANT
  _cur_scheme=catppuccin
  _cur_mode=dark
  _cur_variant=mocha
  if [[ -r $THEME_STATE_DIR/current ]]; then
    source $THEME_STATE_DIR/current
    _cur_scheme=${THEME_SCHEME:-$_cur_scheme}
    _cur_mode=${THEME_MODE:-$_cur_mode}
    _cur_variant=${THEME_VARIANT:-$_cur_variant}
  fi
}

# Write the resolved selection to the state file.
_theme_write() {
  local s=$1 m=$2 v=$3 k="$1:$2:$3"
  command mkdir -p $THEME_STATE_DIR
  {
    print "THEME_SCHEME=$s"
    print "THEME_MODE=$m"
    print "THEME_VARIANT=$v"
    print "THEME_NVIM=${_THEME[${k}:nvim]}"
    print "THEME_NVIM_BG=${_THEME[${k}:bg]}"
    print "THEME_GHOSTTY=\"${_THEME[${k}:ghostty]}\""
    print "THEME_TMUX=${_THEME[${k}:tmux]}"
  } > $THEME_STATE_DIR/current

  _theme_apply_ghostty ${_THEME[${k}:ghostty]}
}

# Rewrite the `theme = ...` line in ghostty's config, preserving everything
# else. A blank value is skipped so ghostty keeps its previous theme (used for
# schemes/variants with no matching ghostty built-in). Reload ghostty to apply.
_theme_apply_ghostty() {
  local name=$1 cfg=$THEME_GHOSTTY_CONFIG
  [[ -z $name ]] && return 0
  [[ -f $cfg ]] || return 0
  local tmp=$cfg.theme-tmp
  if grep -qE '^[[:space:]]*theme[[:space:]]*=' $cfg; then
    sed -E "s|^[[:space:]]*theme[[:space:]]*=.*|theme = ${name}|" $cfg > $tmp && command mv $tmp $cfg
  else
    { cat $cfg; print "theme = $name" } > $tmp && command mv $tmp $cfg
  fi
}

_theme_status() {
  _theme_load
  print "theme: $_cur_scheme $_cur_mode $_cur_variant"
}

_theme_list() {
  _theme_load
  print "available schemes (* = current):"
  local s m variants marker
  for s in $_THEME_SCHEMES; do
    [[ $s == $_cur_scheme ]] && marker="*" || marker=" "
    print "$marker $s"
    for m in light dark; do
      _theme_scheme_supports $s $m || continue
      variants=($(_theme_variants_of $s $m))
      # mark the default variant of each mode
      print "    $m: ${variants[1]} (default)${variants[2,-1]:+, ${(j:, :)variants[2,-1]}}"
    done
  done
}

# Apply a selection. Blank scheme/mode inherit current; blank variant => default.
_theme_set() {
  local scheme=$1 mode=$2 variant=$3
  _theme_load
  [[ -z $scheme ]] && scheme=$_cur_scheme
  [[ -z $mode ]] && mode=$_cur_mode

  if ! _theme_is_scheme $scheme; then
    print -u2 "theme: unknown scheme '$scheme'"
    return 1
  fi
  if ! _theme_is_mode $mode; then
    print -u2 "theme: unknown mode '$mode' (use light|dark)"
    return 1
  fi
  if ! _theme_scheme_supports $scheme $mode; then
    print -u2 "theme: '$scheme' has no '$mode' mode"
    return 1
  fi
  if [[ -z $variant ]]; then
    variant=$(_theme_default_variant $scheme $mode)
  elif ! _theme_is_variant $scheme $mode $variant; then
    print -u2 "theme: '$scheme' ($mode) has no variant '$variant'"
    print -u2 "       variants: $(_theme_variants_of $scheme $mode)"
    return 1
  fi

  _theme_write $scheme $mode $variant
  print "theme: $scheme $mode $variant"
}

theme() {
  local a=$1
  case $a in
    ""|status)   _theme_status ;;
    list|ls)     _theme_list ;;
    light|dark)  _theme_set "" $a ;;
    *)           _theme_set $a $2 $3 ;;
  esac
}

# completion
if (( $+functions[compdef] )); then
  _theme_complete() {
    _theme_load
    case $CURRENT in
      2) compadd $_THEME_SCHEMES list status light dark ;;
      3) compadd light dark ;;
      4) compadd $(_theme_variants_of $words[2] $words[3]) ;;
    esac
  }
  compdef _theme_complete theme
fi
