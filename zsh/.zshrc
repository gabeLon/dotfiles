# ~/.zshrc
# Configuración Zsh modular

# Usar bashrc para aliases, path y modularidad
if [[ -f "$HOME/dotfiles/bash/.bashrc" ]]; then
    source "$HOME/dotfiles/bash/.bashrc"
fi

# Cargar prompt Zsh específico si existe
if [[ -f "$HOME/dotfiles/zsh/prompt.zsh" ]]; then
    source "$HOME/dotfiles/zsh/prompt.zsh"
fi

# Opcional: otras configuraciones Zsh específicas
setopt autocd          # Cambiar automáticamente al cd sin escribir 'cd'
setopt correct         # Corregir errores de comando

