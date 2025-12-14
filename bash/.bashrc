# Salir si no es interactivo (compatible bash / zsh)
case $- in
  *i*) ;;
  *) return;;
esac

# Cargar PATH, aliases, prompt, etc.
if [ -d "$HOME/dotfiles/bash/bashrc.d" ]; then
    for file in "$HOME"/dotfiles/bash/bashrc.d/*.sh; do
        [ -r "$file" ] && source "$file"
    done
fi

