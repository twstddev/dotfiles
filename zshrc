ZIM_HOME=~/.zim

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

source ${ZIM_HOME}/modules/powerlevel10k/powerlevel10k.zsh-theme
source ${ZIM_HOME}/modules/zsh-defer/zsh-defer.plugin.zsh
source ${ZIM_HOME}/modules/zsh-vi-mode/zsh-vi-mode.zsh

zsh-defer source ${ZIM_HOME}/init.zsh

ZSH_CONFIG_DIR=${ZSH_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}

typeset -g THEME_STATE_FILE=${THEME_STATE_FILE:-${${(%):-%x}:A:h}/theme/current.zsh}
[[ -r $THEME_STATE_FILE ]] && source $THEME_STATE_FILE

source ${ZSH_CONFIG_DIR}/theme.zsh
source ${ZSH_CONFIG_DIR}/aliases.zsh
source ${ZSH_CONFIG_DIR}/options.zsh
source ${ZSH_CONFIG_DIR}/keybindings.zsh
source ${ZSH_CONFIG_DIR}/scripts/theme.zsh

zsh-defer _theme_reconcile_fsh

export _ZO_EXCLUDE_DIRS="${_ZO_EXCLUDE_DIRS:+${_ZO_EXCLUDE_DIRS}:}*/worktree/*:*/worktrees/*"
(( $+commands[zoxide] )) && eval "$(zoxide init zsh --cmd j)"
[[ -x ${HOME}/.local/bin/mise ]] && eval "$("${HOME}/.local/bin/mise" activate zsh)"

####################
# LOCAL
####################
if [[ -a ~/.zshrc.local ]]; then
  zsh-defer source ~/.zshrc.local
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
