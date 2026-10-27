# alias
alias c='clear'
alias i='sudo dnf install'
alias vi='nvim'
alias ra='yazi'
alias la='ls -a'
alias u='sudo dnf upgrade --refresh'
alias m='sudo dnf remove'
alias s='source ~/.zshrc'
alias conf='cd ~/.config'
alias ds='cd ~/ds/liner/linklist'

# starship
export STARSHIP_CONFIG="/home/zhang/.config/starship/starship.toml"
eval "$(starship init zsh)"

# autosuggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

# syntax
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Tab completion & menu
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# append history instantly
setopt inc_append_history

# skip seen
setopt hist_find_no_dups

# fzf
# preview file
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {} 2>/dev/null || cat {}'"
# preview tree structure
export FZF_ALT_C_OPTS='--preview "eza --tree --level=2 --color=always {} 2>/dev/null || ls -la {}"'
# use ctrl+/ to show/hide the preview window
export FZF_DEFAULT_OPTS="--layout=reverse-list --bind 'ctrl-/:toggle-preview' --height 40%"
# use double tab Esc to insert 'sudo' in front of the command
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line

# set every editor as neovim
export EDITOR="nvim"
export VISUAL="nvim"

# set vi-mode
bindkey -v
export KEYTIMEOUT=5
bindkey -M viins '^H' beginning-of-line
bindkey -M viins '^L' end-of-line

cursor_beam='\e[6 q'
cursor_block='\e[2 q'

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne $cursor_block
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne $cursor_beam
  fi
}
zle -N zle-keymap-select

zle-line-init() {
  echo -ne $cursor_beam
}
zle -N zle-line-init
