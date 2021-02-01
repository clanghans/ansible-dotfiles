# new keyboard mappings
if [ -f "$HOME/.Xmodmap" ]; then
   xmodmap "$HOME/.Xmodmap"
fi

# Geze Proxy settings
export ftp_proxy=""
export https_proxy=""
export http_proxy=""

# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Display red dots while waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# HISTORY settings
HISTFILE="$HOME/.zhistory"
HISTSIZE=10000000
SAVEHIST=10000000
HIST_STAMPS="yyyy-mm-dd"
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

# User configuration
# Configure zsh options #######################################################
setopt AUTO_CD # change directories without cd
setopt AUTO_PUSHD # use directory stack
setopt CHASE_LINKS # resolve symbolic links
setopt COMPLETE_ALIASES
setopt GLOB_COMPLETE
setopt NONOMATCH
