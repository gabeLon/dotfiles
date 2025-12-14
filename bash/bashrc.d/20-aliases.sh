# ---- Aliases básicos ----
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cl='clear'

# ---- ls con colores (BSD vs GNU) ----
if ls --color > /dev/null 2>&1; then
  colorflag="--color"
else
  colorflag="-G"
fi

alias ls="command ls ${colorflag}"
alias la="ls -lahF ${colorflag}"

# ---- grep con color ----
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ---- permitir aliases con sudo ----
alias sudo='sudo '

