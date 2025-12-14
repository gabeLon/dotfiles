# ~/.zsh/prompt.zsh
# Prompt Zsh con colores y git

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' (%b)'

precmd() { vcs_info }
PROMPT="%F{green}%n@%m %F{blue}%~%f%F{yellow}${vcs_info_msg_0_}%f %# "

