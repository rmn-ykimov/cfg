export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export TERM="xterm-256color"
export SHELL=/bin/zsh
export XDG_CONFIG_HOME=$HOME/.config

# Enable command auto-correction
ENABLE_CORRECTION="true"

# Display red dots during completion waiting time
COMPLETION_WAITING_DOTS="true"

# Disable tracking untracked files in version control systems
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Format of timestamps in command history
HIST_STAMPS="mm/dd/yyyy"

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

# Personal settings
alias ll='ls -lah'
alias h='history'

PROMPT='%F{cyan}%n@%m %F{yellow}%1~ %F{green}> %f'

# Automatic tmux startup when launching the terminal
if [[ -z "$TMUX" ]]; then
  tmux attach -t default || tmux new -s default
fi

