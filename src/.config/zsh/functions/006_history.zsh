# initialize autocompletion
autoload -U compinit
compinit

# history setup
setopt APPEND_HISTORY
setopt SHARE_HISTORY

# History file
export HISTFILE=$HOME/.zhistory
# Maximum lines kept in memory
export HISTSIZE=100000
# Maximum lines saved to $HISTFILE
export SAVEHIST=100000
#
# Like INC_APPEND_HISTORY + re-read history whenever accessing it
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
