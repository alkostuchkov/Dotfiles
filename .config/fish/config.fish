# For ranger, htop and other console progs in Qtile ---------------------------
set -e COLUMNS # -e = --erase
set -e LINES

# disable shortening (~/O/Linux) entirely -------------------------------------
set fish_prompt_pwd_dir_length 0

###############################################################################
# EXPORTs
###############################################################################
set HOME (echo /home/$USER)
set GHCUP_INSTALL_BASE_PREFIX "$HOME/.config" # for GHCUP
set GOPATH "$HOME/go"

set -U fish_user_paths $HOME/.local/bin $HOME/Programs/AppImageApplications $fish_user_paths
set PATH $PATH $HOME/.cargo/bin $HOME/.config/vifm/scripts $GHCUP_INSTALL_BASE_PREFIX/.ghcup/bin $HOME/Programs/Android_SDK/platform-tools $GOPATH/bin # PATH for exa in cargo and ...

set EDITOR vim #  vim is either a link to nvim    or just  vim
set VISUAL gvim # gvim is either a link to nvim-qt or just gvim
set TERM xterm-256color
set TERMINAL wezterm
set BROWSER brave
# set MANPAGER "bat man -p"  # theme moved to the .config/bat/config
set PAGER bat
set MANPAGER "sh -c 'col -bx | bat -l man -p'" # theme moved to the .config/bat/config
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"  # $MANPAGER use batcat to read mans
set RANGER_LOAD_DEFAULT_RC FALSE # to avoid loading ranger's config twice
set ANDROID_SDK $HOME"/Programs/Android_SDK"

set XDG_CONFIG_HOME "$HOME/.config"
set XDG_DATA_HOME "$HOME/.local/share"
# set XDG_DATA_DIRS "$HOME/.local/share/flatpak/exports/share" "/var/lib/flatpak/exports/share"
set XDG_CACHE_HOME "$HOME/.cache"

# $EDITOR use Vim to edit crontab ---------------------------------------------
# EDITOR="vim" crontab -e
# select-editor  (~/.selected-editor)

set __GIT_PROMPT_DIR ~/.bash-git-prompt # Git autocomplition and prompt 

############################################################################### 
# AUTOCOMPLETE AND HIGHLIGHT COLORS
############################################################################### 
# set fish_color_normal brcyan
# set fish_color_autosuggestion '#7d7d7d'
# set fish_color_command brcyan
# set fish_color_error '#ff6c6b'
# set fish_color_param brcyan

set_colorscheme_ayu_Mirage
# set_colorscheme_ayu_Dark

###############################################################################
# FUNCTIONS
###############################################################################
function man
    command man "$argv" | eval $MANPAGER
end

# SET EITHER DEFAULT EMACS MODE OR VI MODE ------------------------------------
function fish_user_key_bindings
    fish_default_key_bindings
    # fish_vi_key_bindings
end

function fish_greeting -d "Greeting message on shell session start up"
    # Run neofetch
    neofetch
end

# Functions needed for !! and !$ ----------------------------------------------
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

# The bindings for !! and !$ --------------------------------------------------
if [ $fish_key_bindings = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Function for creating a backup file -----------------------------------------
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# name: bash-git-prompt -------------------------------------------------------
# author: Mariusz Smykuła <mariuszs@gmail.com>
function fish_prompt
    # - green lines if the last return command is OK, red otherwise
    # - your user name, in red if root or yellow otherwise
    # - your hostname, in cyan if ssh or blue otherwise
    # - the current path (with prompt_pwd)
    # - date +%X
    # - the current virtual environment, if any
    # - the current git status, if any, with __fish_git_prompt
    # - the current battery state, if any, and if your power cable is unplugged, and if you have "acpi"
    # - current background jobs, if any

    # It goes from:
    # ┬─[nim@Hattori:~]─[11:39:00]
    # ╰─>$ echo here

    # To:
    # ┬─[nim@Hattori:~/w/dashboard]─[11:37:14]─[V:django20]─[G:master↑1|●1✚1…1]─[B:85%, 05:41:42 remaining]
    # │ 2	15054	0%	arrêtée	sleep 100000
    # │ 1	15048	0%	arrêtée	sleep 100000
    # ╰─>$ echo there

    # Colors
    # Reset
    set ResetColor (set_color normal) # Text Reset

    # Regular Colors
    set Blue (set_color blue) # Blue
    set Green (set_color green) # Green
    set Yellow (set_color yellow) # Yellow
    set Cyan (set_color cyan)
    set Red (set_color red) # Red
    set White (set_color white)

    # Bold
    set BBlue (set_color -o blue)
    set BGreen (set_color -o green) # Green
    set BYellow (set_color -o yellow) # Yellow
    set BCyan (set_color -o brcyan)
    set BRed (set_color -o red)
    set BWhite (set_color -o white)
    set BMagenta (set_color -o magenta) # Purple
    set BBlack (set_color -o black) # Black

    # # Default values for the appearance of the prompt. Configure at will.
    set GIT_PROMPT_PREFIX "("
    set GIT_PROMPT_SUFFIX ")"
    set GIT_PROMPT_SEPARATOR "|"
    set GIT_PROMPT_BRANCH "$BMagenta"
    set GIT_PROMPT_STAGED "$Red● "
    set GIT_PROMPT_CONFLICTS "$Red✖ "
    set GIT_PROMPT_CHANGED "$Blue✚ "
    set GIT_PROMPT_REMOTE " "
    set GIT_PROMPT_UNTRACKED "…"
    set GIT_PROMPT_STASHED "⚑ "
    set GIT_PROMPT_CLEAN "$BGreen✔"

    set -q __fish_git_prompt_showupstream
    or set -g __fish_git_prompt_showupstream auto

    function _nim_prompt_wrapper
        set retc $argv[1]
        set field_name $argv[2]
        set field_value $argv[3]

        set_color normal
        set_color $retc
        #       echo -n '─'
        set_color -o green
        echo -n '['
        set_color normal
        test -n $field_name
        and echo -n $field_name:
        set_color $retc
        echo -n $field_value
        set_color -o green
        echo -n ']'
    end
    and set retc green
    or set retc red

    set_color $retc
    echo
    #   echo -n '┬─'
    set_color -o green
    echo -n [
    if test "$USER" = root -o "$USER" = toor
        set_color -o red
    else
        set_color -o yellow
    end
    echo -n $USER
    set_color -o white
    echo -n @
    if [ -z "$SSH_CLIENT" ]
        set_color -o blue
    else
        set_color -o cyan
    end
    echo -n (prompt_hostname):
    set_color -o white
    echo -n (prompt_pwd)
    set_color -o green
    echo -n ']'

    # Date
    # _nim_prompt_wrapper $retc '' (date "+%I:%M %p")
    _nim_prompt_wrapper $retc '' (date "+%H:%M")

    # Virtual Environment
    # set -q VIRTUAL_ENV
    # and _nim_prompt_wrapper $retc V (basename "$VIRTUAL_ENV")

    # git
    set -e __CURRENT_GIT_STATUS
    set gitstatus "$__GIT_PROMPT_DIR/gitstatus.py"

    # set _GIT_STATUS (python $gitstatus)
    set _GIT_STATUS (python3 $gitstatus)
    set __CURRENT_GIT_STATUS $_GIT_STATUS

    set __CURRENT_GIT_STATUS_PARAM_COUNT (count $__CURRENT_GIT_STATUS)

    if not test 0 -eq $__CURRENT_GIT_STATUS_PARAM_COUNT
        set GIT_BRANCH $__CURRENT_GIT_STATUS[1]
        set GIT_REMOTE "$__CURRENT_GIT_STATUS[2]"
        if contains "." "$GIT_REMOTE"
            set -e GIT_REMOTE
        end
        set GIT_STAGED $__CURRENT_GIT_STATUS[3]
        set GIT_CONFLICTS $__CURRENT_GIT_STATUS[4]
        set GIT_CHANGED $__CURRENT_GIT_STATUS[5]
        set GIT_UNTRACKED $__CURRENT_GIT_STATUS[6]
        set GIT_STASHED $__CURRENT_GIT_STATUS[7]
        set GIT_CLEAN $__CURRENT_GIT_STATUS[8]
    end

    if test -n "$__CURRENT_GIT_STATUS"
        set STATUS "$GIT_PROMPT_BRANCH$GIT_BRANCH$ResetColor"

        if set -q GIT_REMOTE
            set STATUS "$STATUS$GIT_PROMPT_REMOTE$GIT_REMOTE$ResetColor"
        end

        set STATUS "$STATUS$GIT_PROMPT_SEPARATOR"

        if [ $GIT_STAGED != 0 ]
            set STATUS "$STATUS$GIT_PROMPT_STAGED$GIT_STAGED$ResetColor"
        end

        if [ $GIT_CONFLICTS != 0 ]
            set STATUS "$STATUS$GIT_PROMPT_CONFLICTS$GIT_CONFLICTS$ResetColor"
        end

        if [ $GIT_CHANGED != 0 ]
            set STATUS "$STATUS$GIT_PROMPT_CHANGED$GIT_CHANGED$ResetColor"
        end

        if [ "$GIT_UNTRACKED" != 0 ]
            set STATUS "$STATUS$GIT_PROMPT_UNTRACKED$GIT_UNTRACKED$ResetColor"
        end

        if [ "$GIT_STASHED" != 0 ]
            set STATUS "$STATUS$GIT_PROMPT_STASHED$GIT_STASHED$ResetColor"
        end

        if [ "$GIT_CLEAN" = 1 ]
            set STATUS "$STATUS$GIT_PROMPT_CLEAN"
        end

        set STATUS "$STATUS$ResetColor"

        set prompt_git "$STATUS"
    else
        set prompt_git ""
    end
    # set prompt_git (__fish_git_prompt | string trim -c ' ()')
    test -n "$prompt_git"
    and _nim_prompt_wrapper $retc G $prompt_git

    # Battery status
    type -q acpi
    and test (acpi -a 2> /dev/null | string match -r off)
    and _nim_prompt_wrapper $retc B (acpi -b | cut -d' ' -f 4-)

    # New line
    echo

    # Background jobs
    set_color normal
    for job in (jobs)
        set_color $retc
        #       echo -n '│ '
        set_color brown
        echo $job
    end
    set_color normal
    set_color $retc
    #   echo -n '╰─>'
    if test "$USER" = root -o "$USER" = toor
        set_color -o red
        #        echo -n '# '
        echo -n ' >_ '
    else
        set_color -o yellow
        #        echo -n '$ '
        echo -n ' >_ '
    end
    set_color normal
end

###############################################################################
# ALIASES
###############################################################################
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
alias tree='lsd --tree'
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
# Source
###############################################################################
# asdf manager ----------------------------------------------------------------
# source ~/.asdf/asdf.fish
# opam configuration ----------------------------------------------------------
source /home/alexander/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true
# Fuzzy finder ----------------------------------------------------------------
source /usr/share/fzf/key-bindings.fish

### key-bindings.fish ###
#     ____      ____
#    / __/___  / __/
#   / /_/_  / / /_
#  / __/ / /_/ __/
# /_/   /___/_/ key-bindings.fish
#
# - $FZF_TMUX_OPTS
# - $FZF_CTRL_T_COMMAND
# - $FZF_CTRL_T_OPTS
# - $FZF_CTRL_R_OPTS
# - $FZF_ALT_C_COMMAND
# - $FZF_ALT_C_OPTS

status is-interactive; or exit 0


# Key bindings
# ------------
function fzf_key_bindings

  function __fzf_defaults
    # $1: Prepend to FZF_DEFAULT_OPTS_FILE and FZF_DEFAULT_OPTS
    # $2: Append to FZF_DEFAULT_OPTS_FILE and FZF_DEFAULT_OPTS
    test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
    echo "--height $FZF_TMUX_HEIGHT --bind=ctrl-z:ignore" $argv[1]
    command cat "$FZF_DEFAULT_OPTS_FILE" 2> /dev/null
    echo $FZF_DEFAULT_OPTS $argv[2]
  end

  # Store current token in $dir as root for the 'find' command
  function fzf-file-widget -d "List files and folders"
    set -l commandline (__fzf_parse_commandline)
    set -lx dir $commandline[1]
    set -l fzf_query $commandline[2]
    set -l prefix $commandline[3]

    test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
    begin
      set -lx FZF_DEFAULT_OPTS (__fzf_defaults "--reverse --walker=file,dir,follow,hidden --scheme=path --walker-root='$dir'" "$FZF_CTRL_T_OPTS")
      set -lx FZF_DEFAULT_COMMAND "$FZF_CTRL_T_COMMAND"
      set -lx FZF_DEFAULT_OPTS_FILE ''
      eval (__fzfcmd)' -m --query "'$fzf_query'"' | while read -l r; set result $result $r; end
    end
    if [ -z "$result" ]
      commandline -f repaint
      return
    else
      # Remove last token from commandline.
      commandline -t ""
    end
    for i in $result
      commandline -it -- $prefix
      commandline -it -- (string escape $i)
      commandline -it -- ' '
    end
    commandline -f repaint
  end

  function fzf-history-widget -d "Show command history"
    test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
    begin
      set -l FISH_MAJOR (echo $version | cut -f1 -d.)
      set -l FISH_MINOR (echo $version | cut -f2 -d.)

      # merge history from other sessions before searching
      if test -z "$fish_private_mode"
        builtin history merge
      end

      # history's -z flag is needed for multi-line support.
      # history's -z flag was added in fish 2.4.0, so don't use it for versions
      # before 2.4.0.
      if [ "$FISH_MAJOR" -gt 2 -o \( "$FISH_MAJOR" -eq 2 -a "$FISH_MINOR" -ge 4 \) ];
        if type -P perl > /dev/null 2>&1
          set -lx FZF_DEFAULT_OPTS (__fzf_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort --wrap-sign '"\t"↳ ' --highlight-line $FZF_CTRL_R_OPTS +m")
          set -lx FZF_DEFAULT_OPTS_FILE ''
          builtin history -z --reverse | command perl -0 -pe 's/^/$.\t/g; s/\n/\n\t/gm' | eval (__fzfcmd) --tac --read0 --print0 -q '(commandline)' | command perl -pe 's/^\d*\t//' | read -lz result
          and commandline -- $result
        else
          set -lx FZF_DEFAULT_OPTS (__fzf_defaults "" "--scheme=history --bind=ctrl-r:toggle-sort --wrap-sign '"\t"↳ ' --highlight-line $FZF_CTRL_R_OPTS +m")
          set -lx FZF_DEFAULT_OPTS_FILE ''
          builtin history -z | eval (__fzfcmd) --read0 --print0 -q '(commandline)' | read -lz result
          and commandline -- $result
        end
      else
        builtin history | eval (__fzfcmd) -q '(commandline)' | read -l result
        and commandline -- $result
      end
    end
    commandline -f repaint
  end

  function fzf-cd-widget -d "Change directory"
    set -l commandline (__fzf_parse_commandline)
    set -lx dir $commandline[1]
    set -l fzf_query $commandline[2]
    set -l prefix $commandline[3]

    test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
    begin
      set -lx FZF_DEFAULT_OPTS (__fzf_defaults "--reverse --walker=dir,follow,hidden --scheme=path --walker-root='$dir'" "$FZF_ALT_C_OPTS")
      set -lx FZF_DEFAULT_OPTS_FILE ''
      set -lx FZF_DEFAULT_COMMAND "$FZF_ALT_C_COMMAND"
      eval (__fzfcmd)' +m --query "'$fzf_query'"' | read -l result

      if [ -n "$result" ]
        cd -- $result

        # Remove last token from commandline.
        commandline -t ""
        commandline -it -- $prefix
      end
    end

    commandline -f repaint
  end

  function __fzfcmd
    test -n "$FZF_TMUX"; or set FZF_TMUX 0
    test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
    if [ -n "$FZF_TMUX_OPTS" ]
      echo "fzf-tmux $FZF_TMUX_OPTS -- "
    else if [ $FZF_TMUX -eq 1 ]
      echo "fzf-tmux -d$FZF_TMUX_HEIGHT -- "
    else
      echo "fzf"
    end
  end

  bind \cr fzf-history-widget
  if not set -q FZF_CTRL_T_COMMAND; or test -n "$FZF_CTRL_T_COMMAND"
    bind \ct fzf-file-widget
  end
  if not set -q FZF_ALT_C_COMMAND; or test -n "$FZF_ALT_C_COMMAND"
    bind \ec fzf-cd-widget
  end

  if bind -M insert > /dev/null 2>&1
    bind -M insert \cr fzf-history-widget
    if not set -q FZF_CTRL_T_COMMAND; or test -n "$FZF_CTRL_T_COMMAND"
      bind -M insert \ct fzf-file-widget
    end
    if not set -q FZF_ALT_C_COMMAND; or test -n "$FZF_ALT_C_COMMAND"
      bind -M insert \ec fzf-cd-widget
    end
  end

  function __fzf_parse_commandline -d 'Parse the current command line token and return split of existing filepath, fzf query, and optional -option= prefix'
    set -l commandline (commandline -t)

    # strip -option= from token if present
    set -l prefix (string match -r -- '^-[^\s=]+=' $commandline)
    set commandline (string replace -- "$prefix" '' $commandline)

    # eval is used to do shell expansion on paths
    eval set commandline $commandline

    if [ -z $commandline ]
      # Default to current directory with no --query
      set dir '.'
      set fzf_query ''
    else
      set dir (__fzf_get_dir $commandline)

      if [ "$dir" = "." -a (string sub -l 1 -- $commandline) != '.' ]
        # if $dir is "." but commandline is not a relative path, this means no file path found
        set fzf_query $commandline
      else
        # Also remove trailing slash after dir, to "split" input properly
        set fzf_query (string replace -r "^$dir/?" -- '' "$commandline")
      end
    end

    echo $dir
    echo $fzf_query
    echo $prefix
  end

  function __fzf_get_dir -d 'Find the longest existing filepath from input string'
    set dir $argv

    # Strip all trailing slashes. Ignore if $dir is root dir (/)
    if [ (string length -- $dir) -gt 1 ]
      set dir (string replace -r '/*$' -- '' $dir)
    end

    # Iteratively check if dir exists and strip tail end of path
    while [ ! -d "$dir" ]
      # If path is absolute, this can keep going until ends up at /
      # If path is relative, this can keep going until entire input is consumed, dirname returns "."
      set dir (dirname -- "$dir")
    end

    echo $dir
  end

end
### end: key-bindings.fish ###
fzf_key_bindings
