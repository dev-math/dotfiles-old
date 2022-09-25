export PATH=$HOME/.local/bin:$PATH

# default programs
export EDITOR='nvim'
export TERMINAL='alacritty'
export BROWSER='firefox'

export ZDOTDIR=${ZDOTDIR:-~/.config/zsh}

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-~/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-~/.local/share}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-~/.xdg}
export XDG_DESKTOP_DIR=${XDG_DESKTOP_DIR:-$HOME/Desktop}
export XDG_DOCUMENTS_DIR=${XDG_DOCUMENTS_DIR:-$HOME/Documents}
export XDG_DOWNLOAD_DIR=${XDG_DOWNLOAD_DIR:-$HOME/Downloads}
export XDG_MUSIC_DIR=${XDG_MUSIC_DIR:-$HOME/Music}
export XDG_PICTURES_DIR=${XDG_PICTURES_DIR:-$HOME/Pictures}
export XDG_VIDEOS_DIR=${XDG_VIDEOS_DIR:-$HOME/Videos}
export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/Projects}

# lang
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_TYPE=en_US.UTF-8

# Java exports
export JDTLS_HOME=$HOME/.local/share/nvim/lsp/jdt-language-server/
export WORKSPACE=$HOME/.local/share/nvim/lsp/jdt-language-server/workspace/
export JAVA_HOME=/usr/lib/jvm/default
export PATH=$JAVA_HOME/bin:$PATH

# Other programs
export PRETTIERD_DEFAULT_CONFIG=$HOME/.dotfiles/prettierrc
export LESS_TERMCAP_md="$ORANGE" # Highlight section titles in manual pages
export MANPAGER="less -X" # Don’t clear the screen after quitting a manual page
