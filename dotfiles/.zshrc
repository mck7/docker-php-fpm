# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

LS_COLORS=$LS_COLORS:'di=0;33:' ;

export LS_COLORS
export ZSH=/root/.oh-my-zsh
export EDITOR=vim
export TZ=America/New_York
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/opt/mysql-client/bin:${PATH}"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# shellcheck disable=SC2034
ZSH_THEME="powerlevel10k/powerlevel10k"

setopt clobber
setopt ignoreeof
setopt interactivecomments
setopt APPEND_HISTORY           # no erase history
setopt CORRECT
setopt EXTENDED_HISTORY         # Add timestamp
setopt INC_APPEND_HISTORY_TIME  # Append immediately
setopt RM_STAR_WAIT
setopt SHARE_HISTORY            # Share between session

# shellcheck disable=SC2034
plugins=(man git)

# shellcheck disable=SC1091
# shellcheck source=/Users/cory/.oh-my-zsh/oh-my-zsh.sh
source ${ZSH}/oh-my-zsh.sh

# shellcheck disable=SC1091
# shellcheck source=/Users/cory/.oh-my-zsh/oh-my-zsh.sh
source <(antibody init)
antibody bundle zdharma/fast-syntax-highlighting
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-completions
antibody bundle romkatv/powerlevel10k

# for my emulator
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ -f ~/.p10k.zsh ]]; then
  # shellcheck disable=SC1090
  source ~/.p10k.zsh
fi
