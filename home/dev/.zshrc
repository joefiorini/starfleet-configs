# The following lines were added by compinstall

export TERM=xterm-256color

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-/]=* r:|=*'
zstyle :compinstall filename '/home/dev/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=1000
setopt extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

# make meta+bksp kill path components
function backward-kill-partial-word {
        local WORDCHARS="${WORDCHARS//[\/.]/}"
        zle backward-kill-word "$@"
}

zle -N backward-kill-partial-word
bindkey '^Xw' backward-kill-partial-word


alias ll='ls -Gla'

setopt prompt_subst
typeset -Ag FX FG BG

FX=(
reset     "[00m"
bold      "[01m" no-bold      "[22m"
italic    "[03m" no-italic    "[23m"
underline "[04m" no-underline "[24m"
blink     "[05m" no-blink     "[25m"
reverse   "[07m" no-reverse   "[27m"
)

FG[none]="$FX[none]"
BG[none]="$FX[none]"
colors=(black red green yellow blue magenta cyan white)
for color in {0..255}; do
  if (( $color >= 0 )) && (( $color < $#colors )); then
    index=$(( $color + 1 ))
    FG[$colors[$index]]="[38;5;${color}m"
    BG[$colors[$index]]="[48;5;${color}m"
  fi

  BG[$color]="[48;5;${color}m"
  FG[$color]="[38;5;${color}m"
done
unset color{s,} index

autoload -Uz vcs_info

local smiley="%(?,%{$FG[64]%}❯%{$FX[reset]%},%{$FG[160]%}❯%{$FX[reset]%})"

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%{$FG[37]%}+%{$FX[reset]%}"
zstyle ':vcs_info:*' unstagedstr "%{$FG[160]%}!%{$FX[reset]%}"
zstyle ':vcs_info:*' formats "(%{$FG[64]%}%b%{$FX[reset]%}%u%c)"
zstyle ':vcs_info:*' actionformats \
          "[%{$FG[64]%}%r%{$FX[reset]%}|%{$FG[160]%}%a%{$FX[reset]%}]"
precmd () { vcs_info }

local jobs="%(1j, %{$FG[160]%}%j%{$FX[reset]%},)"
PROMPT='${smiley}${jobs} '
RPROMPT='${vcs_info_msg_0_}'

