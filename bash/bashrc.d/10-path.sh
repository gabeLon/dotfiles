# ---- PATH configuration ----

# Ensure a minimal PATH exists (safety net)
if [[ -z "$PATH" ]]; then
  PATH="/bin:/usr/bin:/sbin:/usr/sbin"
fi

# Homebrew (Apple Silicon)
if [[ -d /opt/homebrew/bin ]]; then
  case ":$PATH:" in
    *:/opt/homebrew/bin:*) ;;
    *) PATH="/opt/homebrew/bin:$PATH" ;;
  esac
fi

# User local binaries
if [[ -d "$HOME/.local/bin" ]]; then
  case ":$PATH:" in
    *:$HOME/.local/bin:*) ;;
    *) PATH="$HOME/.local/bin:$PATH" ;;
  esac
fi

export PATH

