# My fish config.

### EXPORTs ###
set HOME (echo /home/$USER)
# set -U fish_user_paths $HOME/.local/bin $HOME/Programs/AppImageApplications $fish_user_paths
# # set fish_greeting                                # Supresses fish's intro message
# # set fish_greeting 'Welcome to fish!'
# set TERM "xterm-256color"                          # Sets the terminal type
# set EDITOR "vim"                                   # $EDITOR use Vim in terminal
# # EDITOR="vim" crontab -e                          # $EDITOR use Vim to edit crontab
# # select-editor  (~/.selected-editor)
# set VISUAL "gvim"                                  # $VISUAL use GVim in GUI mode
# set PATH $PATH $HOME/.cargo/bin $HOME/.config/vifm/scripts                   # PATH for exa in cargo
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"  # $MANPAGER use batcat to read mans
set __GIT_PROMPT_DIR ~/.bash-git-prompt            # Git autocomplition and prompt 

source ~/.asdf/asdf.fish                  # For asdf manager 

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
  fish_default_key_bindings
  # fish_vi_key_bindings
end
### END OF VI MODE ###

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
# cyan from manjaro theme: #00CCBB #145C56 #16A085
# set fish_color_normal '#16A085'
# set fish_color_command '#16A085'
# set fish_color_param '#16A085'
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### FUNCTIONS ###
function fish_greeting -d "Greeting message on shell session start up"
    # Run neofetch
    neofetch 
end

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
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
# The bindings for !! and !$
if [ $fish_key_bindings = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

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
    set ResetColor (set_color normal)       # Text Reset

    # Regular Colors
    set Blue (set_color blue)               # Blue
    set Green (set_color green)             # Green
    set Yellow (set_color yellow)           # Yellow
    set Cyan (set_color cyan)
    set Red (set_color red)                 # Red
    set White (set_color white)

    # Bold
    set BBlue (set_color -o blue)
    set BGreen (set_color -o green)         # Green
    set BYellow (set_color -o yellow)       # Yellow
    set BCyan (set_color -o brcyan)
    set BRed (set_color -o red)
    set BWhite (set_color -o white)
    set BMagenta (set_color -o magenta)      # Purple
    set BBlack (set_color -o black)         # Black

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
        echo -n '─'
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
    echo -n '┬─'
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
    _nim_prompt_wrapper $retc '' (date "+%I:%M %p")

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

    if not test "0" -eq $__CURRENT_GIT_STATUS_PARAM_COUNT
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

        if [ $GIT_STAGED != "0" ]
            set STATUS "$STATUS$GIT_PROMPT_STAGED$GIT_STAGED$ResetColor"
        end

        if [ $GIT_CONFLICTS != "0" ]
            set STATUS "$STATUS$GIT_PROMPT_CONFLICTS$GIT_CONFLICTS$ResetColor"
        end

        if [ $GIT_CHANGED != "0" ]
            set STATUS "$STATUS$GIT_PROMPT_CHANGED$GIT_CHANGED$ResetColor"
        end

        if [ "$GIT_UNTRACKED" != "0" ]
            set STATUS "$STATUS$GIT_PROMPT_UNTRACKED$GIT_UNTRACKED$ResetColor"
        end

        if [ "$GIT_STASHED" != "0" ]
            set STATUS "$STATUS$GIT_PROMPT_STASHED$GIT_STASHED$ResetColor"
        end

        if [ "$GIT_CLEAN" = "1" ]
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
        echo -n '│ '
        set_color brown
        echo $job
    end
    set_color normal
    set_color $retc
    echo -n '╰─>'
    if test "$USER" = root -o "$USER" = toor
        set_color -o red
        echo -n '# '
    else
        set_color -o yellow
        echo -n '$ '
    end
    set_color normal
end

# name: bash-git-prompt
# author: Mariusz Smykuła <mariuszs@gmail.com>
# function fish_prompt
    # if not set -q __GIT_PROMPT_DIR
        # set __GIT_PROMPT_DIR ~/.bash-git-prompt
    # end
#
    # # Colors
    # # Reset
    # set ResetColor (set_color normal)       # Text Reset
#
    # # Regular Colors
    # set Blue (set_color blue)               # Blue
    # set Green (set_color green)             # Green
    # set Yellow (set_color yellow)           # Yellow
    # set Cyan (set_color cyan)
    # set Red (set_color red)                 # Red
    # set White (set_color white)
#
    # # Bold
    # set BBlue (set_color -o blue)
    # set BGreen (set_color -o green)         # Green
    # set BYellow (set_color -o yellow)       # Yellow
    # set BCyan (set_color -o brcyan)
    # set BRed (set_color -o red)
    # set BWhite (set_color -o white)
    # set BMagenta (set_color -o magenta)      # Purple
    # set BBlack (set_color -o black)         # Black
#
    # # Default values for the appearance of the prompt. Configure at will.
    # set GIT_PROMPT_PREFIX "("
    # set GIT_PROMPT_SUFFIX ")"
    # set GIT_PROMPT_SEPARATOR "|"
    # set GIT_PROMPT_BRANCH "$BMagenta"
    # set GIT_PROMPT_STAGED "$Red● "
    # set GIT_PROMPT_CONFLICTS "$Red✖ "
    # set GIT_PROMPT_CHANGED "$Blue✚ "
    # set GIT_PROMPT_REMOTE " "
    # set GIT_PROMPT_UNTRACKED "…"
    # set GIT_PROMPT_STASHED "⚑ "
    # set GIT_PROMPT_CLEAN "$BGreen✔"
#
    # # Various variables you might want for your PS1 prompt instead
    # # set Time (date +%R)
    # set Time (date "+%I:%M %p")
    # set PathShort (pwd|sed "s=$HOME=~=")
    # # set Name (whoami)
    # set HostName (hostname)
    # # set -g __fish_prompt_char \u276f\u276f
    # # set -g __fish_prompt_char »»»
    # # set -g __fish_prompt_char \u276d
    # set -g __fish_prompt_char ↪
#
    # # set PROMPT_START "$Yellow$PathShort$ResetColor"
    # # set PROMPT_END " \n$White$Time$ResetColor  \$ "
    # set PROMPT_START "\n$BYellow$USER$BWhite@$BGreen$HostName:$Blue$PathShort$ResetColor"
    # # set PROMPT_END "\n$BWhite$Time$BYellow > "
    # # set PROMPT_END "\n$BWhite$Time$BYellow $__fish_prompt_char "
    # # set PROMPT_END "\n$BYellow $__fish_prompt_char "
    # set PROMPT_END "\n$BYellow > "
#
    # set -e __CURRENT_GIT_STATUS
    # set gitstatus "$__GIT_PROMPT_DIR/gitstatus.py"
#
    # set _GIT_STATUS (python $gitstatus)
    # set __CURRENT_GIT_STATUS $_GIT_STATUS
#
    # set __CURRENT_GIT_STATUS_PARAM_COUNT (count $__CURRENT_GIT_STATUS)
#
    # if not test "0" -eq $__CURRENT_GIT_STATUS_PARAM_COUNT
        # set GIT_BRANCH $__CURRENT_GIT_STATUS[1]
        # set GIT_REMOTE "$__CURRENT_GIT_STATUS[2]"
        # if contains "." "$GIT_REMOTE"
            # set -e GIT_REMOTE
        # end
        # set GIT_STAGED $__CURRENT_GIT_STATUS[3]
        # set GIT_CONFLICTS $__CURRENT_GIT_STATUS[4]
        # set GIT_CHANGED $__CURRENT_GIT_STATUS[5]
        # set GIT_UNTRACKED $__CURRENT_GIT_STATUS[6]
        # set GIT_STASHED $__CURRENT_GIT_STATUS[7]
        # set GIT_CLEAN $__CURRENT_GIT_STATUS[8]
    # end
#
    # if test -n "$__CURRENT_GIT_STATUS"
        # set STATUS " $GIT_PROMPT_PREFIX$GIT_PROMPT_BRANCH$GIT_BRANCH$ResetColor"
#
        # if set -q GIT_REMOTE
            # set STATUS "$STATUS$GIT_PROMPT_REMOTE$GIT_REMOTE$ResetColor"
        # end
#
        # set STATUS "$STATUS$GIT_PROMPT_SEPARATOR"
#
        # if [ $GIT_STAGED != "0" ]
            # set STATUS "$STATUS$GIT_PROMPT_STAGED$GIT_STAGED$ResetColor"
        # end
#
        # if [ $GIT_CONFLICTS != "0" ]
            # set STATUS "$STATUS$GIT_PROMPT_CONFLICTS$GIT_CONFLICTS$ResetColor"
        # end
#
        # if [ $GIT_CHANGED != "0" ]
            # set STATUS "$STATUS$GIT_PROMPT_CHANGED$GIT_CHANGED$ResetColor"
        # end
#
        # if [ "$GIT_UNTRACKED" != "0" ]
            # set STATUS "$STATUS$GIT_PROMPT_UNTRACKED$GIT_UNTRACKED$ResetColor"
        # end
#
        # if [ "$GIT_STASHED" != "0" ]
            # set STATUS "$STATUS$GIT_PROMPT_STASHED$GIT_STASHED$ResetColor"
        # end
#
        # if [ "$GIT_CLEAN" = "1" ]
            # set STATUS "$STATUS$GIT_PROMPT_CLEAN"
        # end
#
        # set STATUS "$STATUS$ResetColor$GIT_PROMPT_SUFFIX"
#
        # set PS1 "$PROMPT_START$STATUS$PROMPT_END"
    # else
        # set PS1 "$PROMPT_START$PROMPT_END"
    # end
#
    # echo -e $PS1
# end
#
# function fish_right_prompt -d "Write out the right prompt"
    # # set_color -o yellow
    # # date "+%I:%M %p "
    # set_color normal
    # date "+%A %d %B %Y | %I:%M %p "
    # # date
# end
### END OF FUNCTIONS ###




### ALIASES ###
# alias ls='ls --color=auto'
alias ls='exa -g --color=always --group-directories-first'
alias bat='bat --theme gruvbox-dark'
alias ll='ls -l'
alias la='ls -la'
# alias ll='ls -lh'
# alias la='ls -lah'
# alias lf='ls -lFh'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ifconfig=/sbin/ifconfig
alias bat='bat --theme gruvbox-dark' 

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# switch between shells
alias tobash="sudo chsh $USER -s /usr/bin/env bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /usr/bin/env zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /usr/bin/env fish && echo 'Now log out.'"

# navigation
alias ..='cd ..' 
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## git
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
### END OF ALIASES ###



### EXTRA fish_prompt.fish from theme-cbjohnson ###
# function fish_prompt
  # # Cache exit status
  # set -l last_status $status
#
  # # Just calculate these once, to save a few cycles when displaying the prompt
  # if not set -q __fish_prompt_hostname
    # set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  # end
  # if not set -q __fish_prompt_char
    # switch (id -u)
      # case 0
        # set -g __fish_prompt_char \u276f\u276f
      # case '*'
        # set -g __fish_prompt_char »
    # end
  # end
#
  # # Setup colors
  # set -l normal (set_color normal)
  # set -l cyan (set_color cyan)
  # set -l yellow (set_color yellow)
  # set -l bpurple (set_color -o purple)
  # set -l bred (set_color -o red)
  # set -l bcyan (set_color -o cyan)
  # set -l bwhite (set_color -o white)
#
  # # Configure __fish_git_prompt
  # set -g __fish_git_prompt_show_informative_status true
  # set -g __fish_git_prompt_showcolorhints true
#
  # # Color prompt char red for non-zero exit status
  # set -l pcolor $bpurple
  # if [ $last_status -ne 0 ]
    # set pcolor $bred
  # end
#
  # # Top
  # echo -n $cyan$USER$normal at $yellow$__fish_prompt_hostname$normal in $bred(prompt_pwd)$normal
  # __fish_git_prompt
#
  # echo
#
  # # Bottom
  # echo -n $pcolor$__fish_prompt_char $normal
# end
