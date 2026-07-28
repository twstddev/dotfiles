# theme.zsh — one command to switch colorscheme + light/dark across apps.
#
# Usage:
#   theme                          show current selection
#   theme list                     list schemes, modes and variants
#   theme apply                    apply the committed selection to every app
#   theme <scheme>                 switch scheme, keep mode, use mode default variant
#   theme <scheme> <mode>          switch scheme + mode, use mode default variant
#   theme <scheme> <mode> <variant>  switch scheme + mode + explicit variant
#   theme <mode>                   flip mode only (keeps scheme, uses default variant)
#
# This is the PLUMBING layer only. It resolves the selection against the
# registry below and writes it to theme/current.zsh in this repository (a
# sourceable file). Each app reads that file separately and is updated by the
# apply functions below. THEME_STATE_FILE can override the path for testing.
#
# NOTE: nvim colorscheme names + backgrounds are known-good. ghostty and tmux
# values are best-guess placeholders and MUST be verified against each app's
# actual theme names when that app is wired up.

typeset -g THEME_STATE_FILE="${THEME_STATE_FILE:-${${(%):-%x}:A:h:h:h}/theme/current.zsh}"
typeset -g THEME_GHOSTTY_CONFIG="${THEME_GHOSTTY_CONFIG:-$HOME/.config/ghostty/config}"
typeset -g THEME_TMUX_DIR="${THEME_TMUX_DIR:-$HOME/.config/tmux}"
typeset -g THEME_EZA_DIR="${THEME_EZA_DIR:-$HOME/.config/eza}"
typeset -g THEME_BTOP_DIR="${THEME_BTOP_DIR:-$HOME/.config/btop}"
typeset -g THEME_FZF_DIR="${THEME_FZF_DIR:-$ZSH_CONFIG_DIR/fzf}"
typeset -g THEME_BAT_DIR="${THEME_BAT_DIR:-$HOME/.config/bat}"

# Bat ships several of our palettes; the rest live in bat/themes. Values must
# match `bat --list-themes` after the custom-theme cache has been built.
typeset -gA _THEME_BAT=(
  catppuccin-latte     "Catppuccin Latte"
  catppuccin-frappe    "Catppuccin Frappe"
  catppuccin-macchiato "Catppuccin Macchiato"
  catppuccin-mocha     "Catppuccin Mocha"
  tokyonight-day       tokyonight_day
  tokyonight-night     tokyonight_night
  tokyonight-storm     tokyonight_storm
  tokyonight-moon      tokyonight_moon
  gruvbox-light        gruvbox-light
  gruvbox-dark         gruvbox-dark
  rose-pine-dawn       rose-pine-dawn
  rose-pine-main       rose-pine
  rose-pine-moon       rose-pine-moon
  everforest-light     everforest-light
  everforest-dark      everforest-dark
  kanagawa-lotus       kanagawa-lotus
  kanagawa-wave        kanagawa
  kanagawa-dragon      kanagawa-dragon
  solarized-light      "Solarized (light)"
  solarized-dark       "Solarized (dark)"
  nord-dark            Nord
)

# Built-in btop theme names for palettes it already ships. Anything absent
# here resolves to a generated theme in ~/.config/btop/themes instead.
typeset -gA _THEME_BTOP_BUILTIN=(
  everforest-dark  everforest-dark-hard
  everforest-light everforest-light-medium
  gruvbox-dark     gruvbox_dark
  gruvbox-light    gruvbox_light
  kanagawa-lotus   kanagawa-lotus
  kanagawa-wave    kanagawa-wave
  nord-dark        nord
  solarized-dark   solarized_dark
  solarized-light  solarized_light
  tokyonight-night tokyo-night
  tokyonight-storm tokyo-storm
)

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
# Fields: nvim (colorscheme), bg (background), ghostty, tmux. The canonical
# tmux palette name is also shared by fzf and the other palette consumers.
typeset -gA _THEME
_THEME=(
  # catppuccin -----------------------------------------------------------
  "catppuccin:light:latte:nvim"        catppuccin-latte
  "catppuccin:light:latte:bg"          light
  "catppuccin:light:latte:ghostty"     "Catppuccin Latte"
  "catppuccin:light:latte:tmux"        catppuccin-latte
  "catppuccin:dark:mocha:nvim"         catppuccin-mocha
  "catppuccin:dark:mocha:bg"           dark
  "catppuccin:dark:mocha:ghostty"      "Catppuccin Mocha"
  "catppuccin:dark:mocha:tmux"         catppuccin-mocha
  "catppuccin:dark:frappe:nvim"        catppuccin-frappe
  "catppuccin:dark:frappe:bg"          dark
  "catppuccin:dark:frappe:ghostty"     "Catppuccin Frappe"
  "catppuccin:dark:frappe:tmux"        catppuccin-frappe
  "catppuccin:dark:macchiato:nvim"     catppuccin-macchiato
  "catppuccin:dark:macchiato:bg"       dark
  "catppuccin:dark:macchiato:ghostty"  "Catppuccin Macchiato"
  "catppuccin:dark:macchiato:tmux"     catppuccin-macchiato

  # tokyonight -----------------------------------------------------------
  "tokyonight:light:day:nvim"          tokyonight-day
  "tokyonight:light:day:bg"            light
  "tokyonight:light:day:ghostty"       "TokyoNight Day"
  "tokyonight:light:day:tmux"          tokyonight-day
  "tokyonight:dark:night:nvim"         tokyonight-night
  "tokyonight:dark:night:bg"           dark
  "tokyonight:dark:night:ghostty"      "TokyoNight Night"
  "tokyonight:dark:night:tmux"         tokyonight-night
  "tokyonight:dark:storm:nvim"         tokyonight-storm
  "tokyonight:dark:storm:bg"           dark
  "tokyonight:dark:storm:ghostty"      "TokyoNight Storm"
  "tokyonight:dark:storm:tmux"         tokyonight-storm
  "tokyonight:dark:moon:nvim"          tokyonight-moon
  "tokyonight:dark:moon:bg"            dark
  "tokyonight:dark:moon:ghostty"       "TokyoNight Moon"
  "tokyonight:dark:moon:tmux"          tokyonight-moon

  # gruvbox (single colorscheme; contrast via variant, mode via bg) -------
  "gruvbox:light:medium:nvim"          gruvbox
  "gruvbox:light:medium:bg"            light
  "gruvbox:light:medium:ghostty"       "Gruvbox Light"
  "gruvbox:light:medium:tmux"          gruvbox-light
  "gruvbox:light:hard:nvim"            gruvbox
  "gruvbox:light:hard:bg"              light
  "gruvbox:light:hard:ghostty"         "Gruvbox Light Hard"
  "gruvbox:light:hard:tmux"            gruvbox-light
  "gruvbox:light:soft:nvim"            gruvbox
  "gruvbox:light:soft:bg"              light
  "gruvbox:light:soft:ghostty"         "Gruvbox Light"
  "gruvbox:light:soft:tmux"            gruvbox-light
  "gruvbox:dark:medium:nvim"           gruvbox
  "gruvbox:dark:medium:bg"             dark
  "gruvbox:dark:medium:ghostty"        "Gruvbox Dark"
  "gruvbox:dark:medium:tmux"           gruvbox-dark
  "gruvbox:dark:hard:nvim"             gruvbox
  "gruvbox:dark:hard:bg"               dark
  "gruvbox:dark:hard:ghostty"          "Gruvbox Dark Hard"
  "gruvbox:dark:hard:tmux"             gruvbox-dark
  "gruvbox:dark:soft:nvim"             gruvbox
  "gruvbox:dark:soft:bg"               dark
  "gruvbox:dark:soft:ghostty"          "Gruvbox Dark"
  "gruvbox:dark:soft:tmux"             gruvbox-dark

  # rose-pine ------------------------------------------------------------
  "rose-pine:light:dawn:nvim"          rose-pine-dawn
  "rose-pine:light:dawn:bg"            light
  "rose-pine:light:dawn:ghostty"       "Rose Pine Dawn"
  "rose-pine:light:dawn:tmux"          rose-pine-dawn
  "rose-pine:dark:main:nvim"           rose-pine-main
  "rose-pine:dark:main:bg"             dark
  "rose-pine:dark:main:ghostty"        "Rose Pine"
  "rose-pine:dark:main:tmux"           rose-pine-main
  "rose-pine:dark:moon:nvim"           rose-pine-moon
  "rose-pine:dark:moon:bg"             dark
  "rose-pine:dark:moon:ghostty"        "Rose Pine Moon"
  "rose-pine:dark:moon:tmux"           rose-pine-moon

  # everforest (single colorscheme; contrast via variant) ----------------
  "everforest:light:medium:nvim"       everforest
  "everforest:light:medium:bg"         light
  "everforest:light:medium:ghostty"    "Everforest Light Med"
  "everforest:light:medium:tmux"       everforest-light
  "everforest:light:hard:nvim"         everforest
  "everforest:light:hard:bg"           light
  "everforest:light:hard:ghostty"      "Everforest Light Med"
  "everforest:light:hard:tmux"         everforest-light
  "everforest:light:soft:nvim"         everforest
  "everforest:light:soft:bg"           light
  "everforest:light:soft:ghostty"      "Everforest Light Med"
  "everforest:light:soft:tmux"         everforest-light
  "everforest:dark:medium:nvim"        everforest
  "everforest:dark:medium:bg"          dark
  "everforest:dark:medium:ghostty"     "Everforest Dark Hard"
  "everforest:dark:medium:tmux"        everforest-dark
  "everforest:dark:hard:nvim"          everforest
  "everforest:dark:hard:bg"            dark
  "everforest:dark:hard:ghostty"       "Everforest Dark Hard"
  "everforest:dark:hard:tmux"          everforest-dark
  "everforest:dark:soft:nvim"          everforest
  "everforest:dark:soft:bg"            dark
  "everforest:dark:soft:ghostty"       "Everforest Dark Hard"
  "everforest:dark:soft:tmux"          everforest-dark

  # kanagawa -------------------------------------------------------------
  "kanagawa:light:lotus:nvim"          kanagawa-lotus
  "kanagawa:light:lotus:bg"            light
  "kanagawa:light:lotus:ghostty"       "Kanagawa Lotus"
  "kanagawa:light:lotus:tmux"          kanagawa-lotus
  "kanagawa:dark:wave:nvim"            kanagawa-wave
  "kanagawa:dark:wave:bg"              dark
  "kanagawa:dark:wave:ghostty"         "Kanagawa Wave"
  "kanagawa:dark:wave:tmux"            kanagawa-wave
  "kanagawa:dark:dragon:nvim"          kanagawa-dragon
  "kanagawa:dark:dragon:bg"            dark
  "kanagawa:dark:dragon:ghostty"       "Kanagawa Dragon"
  "kanagawa:dark:dragon:tmux"          kanagawa-dragon

  # solarized (single colorscheme, background toggles mode) --------------
  "solarized:light:solarized:nvim"     solarized
  "solarized:light:solarized:bg"       light
  "solarized:light:solarized:ghostty"  "iTerm2 Solarized Light"
  "solarized:light:solarized:tmux"     solarized-light
  "solarized:dark:solarized:nvim"      solarized
  "solarized:dark:solarized:bg"        dark
  "solarized:dark:solarized:ghostty"   "iTerm2 Solarized Dark"
  "solarized:dark:solarized:tmux"      solarized-dark

  # nord (dark only) -----------------------------------------------------
  "nord:dark:nord:nvim"                nord
  "nord:dark:nord:bg"                  dark
  "nord:dark:nord:ghostty"             "Nord"
  "nord:dark:nord:tmux"                nord-dark
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
  if [[ -r $THEME_STATE_FILE ]]; then
    source $THEME_STATE_FILE
    _cur_scheme=${THEME_SCHEME:-$_cur_scheme}
    _cur_mode=${THEME_MODE:-$_cur_mode}
    _cur_variant=${THEME_VARIANT:-$_cur_variant}
  fi
}

# Write the resolved selection to the state file.
_theme_write() {
  local s=$1 m=$2 v=$3 k="$1:$2:$3"
  command mkdir -p ${THEME_STATE_FILE:h}
  {
    print "THEME_SCHEME=$s"
    print "THEME_MODE=$m"
    print "THEME_VARIANT=$v"
    print "THEME_NVIM=${_THEME[${k}:nvim]}"
    print "THEME_NVIM_BG=${_THEME[${k}:bg]}"
    print "THEME_GHOSTTY=\"${_THEME[${k}:ghostty]}\""
    # Canonical palette identity, shared by any app that consumes the semantic
    # colour palette (p10k, tmux). The value is the palette basename
    # (tmux/palettes/<name>.conf).
    print "THEME_PALETTE=${_THEME[${k}:tmux]}"
    print "THEME_FSH=${_THEME[${k}:tmux]}"
    print "THEME_EZA=${_THEME[${k}:tmux]}"
    print "THEME_BTOP=${_THEME[${k}:tmux]}"
    print "THEME_FZF=${_THEME[${k}:tmux]}"
    print "THEME_BAT=\"${_THEME_BAT[${_THEME[${k}:tmux]}]}\""
  } > $THEME_STATE_FILE

  _theme_apply_resolved $s $m $v
}

# Apply a resolved registry selection to every destination without rewriting
# the repository manifest. Shared by theme switching and `theme apply`.
_theme_apply_resolved() {
  local k="$1:$2:$3"
  _theme_apply_ghostty "${_THEME[${k}:ghostty]}"
  _theme_apply_eza "${_THEME[${k}:tmux]}"
  _theme_apply_btop "${_THEME[${k}:tmux]}"
  _theme_apply_nvim
  _theme_apply_tmux "${_THEME[${k}:tmux]}"
  _theme_apply_fsh "${_THEME[${k}:tmux]}"
  _theme_apply_fzf "${_THEME[${k}:tmux]}"
  _theme_apply_bat "${_THEME[${k}:tmux]}"
}

# Rewrite the `theme = ...` line in ghostty's config, preserving everything
# else. A blank value is skipped so ghostty keeps its previous theme (used for
# schemes/variants with no matching ghostty built-in). Reload ghostty to apply.
_theme_apply_ghostty() {
  local name=$1 cfg=$THEME_GHOSTTY_CONFIG
  [[ -z $name ]] && return 0
  [[ -f $cfg ]] || return 0
  local content
  if grep -qE '^[[:space:]]*theme[[:space:]]*=' $cfg; then
    content=$(sed -E "s|^[[:space:]]*theme[[:space:]]*=.*|theme = ${name}|" $cfg) || return
  else
    content=$({ cat $cfg; print "theme = $name" }) || return
  fi
  print -r -- "$content" > $cfg
}

# Point eza at the selected palette. Eza reads theme.yml on every invocation,
# so changing the symlink applies immediately without a live-reload step.
_theme_apply_eza() {
  local name=$1
  local src=$THEME_EZA_DIR/themes/$name.yml
  local dst=$THEME_EZA_DIR/theme.yml
  [[ -z $name || ! -f $src ]] && return 0
  command mkdir -p $THEME_EZA_DIR
  command ln -sfn themes/$name.yml $dst
}

# Select the matching local btop theme. btop persists options by rewriting this
# same config, so leave every unrelated option intact.
_theme_apply_btop() {
  local name=$1 cfg=$THEME_BTOP_DIR/btop.conf
  [[ -z $name || ! -f $cfg ]] && return 0
  local theme=${_THEME_BTOP_BUILTIN[$name]}
  if [[ -z $theme ]]; then
    [[ -f $THEME_BTOP_DIR/themes/$name.theme ]] || return 0
    theme=$name
  fi
  local content
  if grep -qE '^[[:space:]]*color_theme[[:space:]]*=' $cfg; then
    content=$(sed -E "s|^[[:space:]]*color_theme[[:space:]]*=.*|color_theme = \"$theme\"|" $cfg) || return
  else
    content=$({ print "color_theme = \"$theme\""; cat $cfg }) || return
  fi
  print -r -- "$content" > $cfg
}

# Live-reload every running nvim by asking it to re-read the state file.
# Linux puts sockets directly in $XDG_RUNTIME_DIR; macOS uses a nested
# $TMPDIR/nvim.$USER directory. The null-globs make missing paths no-ops.
_theme_apply_nvim() {
  command -v nvim >/dev/null || return 0
  local sock runtime_dir=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}
  local -a sockets=(
    $runtime_dir/nvim.*(N)
    ${TMPDIR:-/tmp}/nvim.$USER/*/nvim.*.0(N)
  )
  for sock in $sockets; do
    nvim --server $sock --remote-expr \
      'luaeval("(function() require(\"util.theme\").apply() end)()")' &>/dev/null
  done
}

# Copy the selected palette over the tmux theme file, then live-reload every
# running tmux server. The palette basename comes from the registry; a missing
# palette file or a blank value is skipped so tmux keeps its current colours.
# tmux resolves #{@theme_*} at draw time, so source-file + refresh recolours
# the status line live without restarting the server.
_theme_apply_tmux() {
  local name=$1
  local src=$THEME_TMUX_DIR/palettes/$name.conf
  local dst=$THEME_TMUX_DIR/theme.conf
  [[ -z $name ]] && return 0
  [[ -f $src ]] || return 0
  command cp $src $dst
  command -v tmux >/dev/null || return 0
  local sock
  # tmux keeps sockets under $TMUX_TMPDIR (default /tmp), NOT $TMPDIR — on macOS
  # $TMPDIR points at a per-user /var/folders dir where tmux never writes.
  # Re-source styling.conf after the palette so the selected @tmux_accent
  # re-resolves its @theme_ac_* display vars against the new palette's hues.
  for sock in ${TMUX_TMPDIR:-/tmp}/tmux-$(id -u)/*(N=); do
    tmux -S $sock source-file $dst 2>/dev/null \
      && tmux -S $sock source-file $THEME_TMUX_DIR/styling.conf 2>/dev/null \
      && tmux -S $sock run-shell '#{@fingers-cli} load-config' 2>/dev/null \
      && tmux -S $sock refresh-client -S 2>/dev/null
  done
}

# Apply and persist the matching fast-syntax-highlighting theme. Theme files
# live in ~/.config/fsh and share the canonical palette basename.
_theme_apply_fsh() {
  local name=$1
  [[ -z $name ]] && return 0
  (( $+functions[fast-theme] )) || return 0
  fast-theme -q XDG:$name
}

# FSH loads after this file through zsh-defer. Once it is available, generate
# its machine-local cache only when no cache was loaded or its palette differs
# from the selection committed in theme/current.zsh.
_theme_reconcile_fsh() {
  [[ -z $THEME_FSH ]] && return 0
  (( $+functions[fast-theme] )) || return 0
  [[ -r $FAST_WORK_DIR/current_theme.zsh && $FAST_THEME_NAME == $THEME_FSH ]] && return 0
  _theme_apply_fsh $THEME_FSH
}

# Load the selected fzf colours into the current shell. New shells source the
# same file from options.zsh using THEME_PALETTE in the persisted state file.
_theme_apply_fzf() {
  local name=$1
  local file=$THEME_FZF_DIR/themes/$name.zsh
  [[ -z $name || ! -r $file ]] && return 0
  source $file
}

# Bat reads its config on every invocation, so update only its theme option and
# preserve every unrelated setting.
_theme_apply_bat() {
  local name=${_THEME_BAT[$1]}
  local cfg=$THEME_BAT_DIR/config content
  [[ -z $name || ! -f $cfg ]] && return 0
  if grep -qE '^[[:space:]]*--theme=' $cfg; then
    content=$(sed -E "s|^[[:space:]]*--theme=.*|--theme=\"${name}\"|" $cfg) || return
  else
    content=$({ print -r -- "--theme=\"$name\""; cat $cfg }) || return
  fi
  print -r -- "$content" > $cfg
}

_theme_status() {
  _theme_load
  print "theme: $_cur_scheme $_cur_mode $_cur_variant"
}

_theme_apply_current() {
  _theme_load
  local k="$_cur_scheme:$_cur_mode:$_cur_variant"
  if [[ -z ${_THEME[${k}:nvim]} ]]; then
    print -u2 "theme: committed selection is not in the theme registry"
    return 1
  fi
  _theme_apply_resolved $_cur_scheme $_cur_mode $_cur_variant
  print "theme: applied $_cur_scheme $_cur_mode $_cur_variant"
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
    apply)       _theme_apply_current ;;
    light|dark)  _theme_set "" $a ;;
    *)           _theme_set $a $2 $3 ;;
  esac
}

# completion
if (( $+functions[compdef] )); then
  _theme_complete() {
    _theme_load
    case $CURRENT in
      2) compadd $_THEME_SCHEMES apply list status light dark ;;
      3) compadd light dark ;;
      4) compadd $(_theme_variants_of $words[2] $words[3]) ;;
    esac
  }
  compdef _theme_complete theme
fi
