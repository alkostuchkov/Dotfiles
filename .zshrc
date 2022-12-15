# For ranger, htop and other console progs in Qtile ---------------------------
unset COLUMNS
unset LINES

###############################################################################
# EXPORTs
###############################################################################
export HOME=$(echo /home/$USER)
export ZSH="$HOME/.oh-my-zsh"
export GHCUP_INSTALL_BASE_PREFIX="$HOME/.config"  # for GHCUP

# export
PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.config/vifm/scripts:$HOME/Programs/AppImageApplications:$GHCUP_INSTALL_BASE_PREFIX/.ghcup/bin:$HOME/Programs/Android_SDK/platform-tools
export EDITOR="vim"   #  vim is either a link to nvim    or just  vim
export VISUAL="gvim"  # gvim is either a link to nvim-qt or just gvim
export TERM="xterm-256color"
export TERMINAL="alacritty"
export BROWSER="brave"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"  # $MANPAGER use batcat to read mans
export RANGER_LOAD_DEFAULT_RC=FALSE  # to avoid loading ranger's config twice
export ANDROID_SDK="$HOME/Programs/Android_SDK"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
# export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share/applications:/var/lib/flatpak/exports/share/applications"
export XDG_CACHE_HOME="$HOME/.cache"

# # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

###############################################################################
# AUTOCOMPLETE AND HIGHLIGHT COLORS
###############################################################################
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7d7d7d"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="bira"
ZSH_THEME="bira_my"
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


###############################################################################
# PLUGINS
###############################################################################
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git asdf)
plugins=(zsh-autosuggestions)
# plugins=(zsh-syntax-highlighting)


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

###############################################################################
# ALIASes
###############################################################################
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# alias ls='ls --color=auto'
# alias ll='ls -l'
# alias ll='ls -lh'
# alias la='ls -la'
# alias la='ls -lah'
# alias lf='ls -lFh'
alias lse='exa -g --color=always --group-directories-first'
alias lle='lse -l'
alias ls='lsd --group-dirs=first'
alias ll='lsd --blocks=permission,links,user,group,size,date,name --group-dirs=first --date="+%d %b %H:%M"'
alias la='ll -a'
# alias bat='bat --theme gruvbox-dark'  # theme moved to the .config/bat/config
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ifconfig=/sbin/ifconfig
# confirm before overwriting something ----------------------------------------
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
# switch between shells -------------------------------------------------------
alias tobash="sudo chsh $USER -s /usr/bin/env bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /usr/bin/env zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /usr/bin/env fish && echo 'Now log out.'"
# navigation ------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
# get top process eating memory -----------------------------------------------
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
# get top process eating cpu --------------------------------------------------
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
# git -------------------------------------------------------------------------
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
# run some programs -----------------------------------------------------------
alias v='vim'
alias f='ranger'
alias vf='vifm'
alias emacs="emacsclient -c -a 'emacs'"

###############################################################################
# PROMPT
###############################################################################
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $ZSH/oh-my-zsh.sh

# Load ; should be last.
# source $HOME/powerlevel10k/powerlevel10k.zsh-theme

# source /usr/share/autojump/autojump.zsh 2>/dev/null
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Syntax-highlighting like in fish
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

###############################################################################
# Source
###############################################################################
# source ~/.git-completion.zsh
# source ~/.git-prompt.sh
# # asdf manager ----------------------------------------------------------------
# source $HOME/.asdf/asdf.sh
# source $HOME/.asdf/completions/asdf.bash
# Fuzzy finder ----------------------------------------------------------------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# # broot -----------------------------------------------------------------------
# source /home/alexander/.config/broot/launcher/bash/br

# Run neofetch ----------------------------------------------------------------
neofetch

