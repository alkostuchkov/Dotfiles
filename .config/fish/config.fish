# For ranger, htop and other console progs in Qtile ---------------------------
set -e COLUMNS  # -e = --erase
set -e LINES

# disable shortening (~/O/Linux) entirely -------------------------------------
set fish_prompt_pwd_dir_length 0

###############################################################################
# EXPORTs
###############################################################################
set HOME (echo /home/$USER)
set GHCUP_INSTALL_BASE_PREFIX "$HOME/.config"  # for GHCUP
set GOPATH "$HOME/go"

set -U fish_user_paths $HOME/.local/bin $HOME/Programs/AppImageApplications $fish_user_paths
set PATH $PATH $HOME/.cargo/bin $HOME/.config/vifm/scripts $GHCUP_INSTALL_BASE_PREFIX/.ghcup/bin $HOME/Programs/Android_SDK/platform-tools $GOPATH/bin # PATH for exa in cargo and ...

set EDITOR "vim"   #  vim is either a link to nvim    or just  vim
set VISUAL "gvim"  # gvim is either a link to nvim-qt or just gvim
set TERM "xterm-256color"
set TERMINAL "alacritty"
set BROWSER "brave"
set MANPAGER "bat man -p"  # theme moved to the .config/bat/config
# set MANPAGER "sh -c 'col -bx | bat -l man -p'"  # theme moved to the .config/bat/config
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"  # $MANPAGER use batcat to read mans
set RANGER_LOAD_DEFAULT_RC FALSE  # to avoid loading ranger's config twice
set ANDROID_SDK $HOME"/Programs/Android_SDK"

set XDG_CONFIG_HOME "$HOME/.config"
set XDG_DATA_HOME "$HOME/.local/share"
# set XDG_DATA_DIRS "$HOME/.local/share/flatpak/exports/share" "/var/lib/flatpak/exports/share"
set XDG_CACHE_HOME "$HOME/.cache"

# $EDITOR use Vim to edit crontab ---------------------------------------------
# EDITOR="vim" crontab -e
# select-editor  (~/.selected-editor)

set __GIT_PROMPT_DIR ~/.bash-git-prompt            # Git autocomplition and prompt 

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

# The bindings for !! and !$ --------------------------------------------------
if [ $fish_key_bindings = fish_vi_key_bindings ];
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
source /home/alexander/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# # Icons for lf file manager ---------------------------------------------------
# set LF_ICONS "\
# fi=:\
# di=:\
# ln=:\
# pi=|:\
# so=ﯲ:\
# db=:\
# cd=c:\
# or=:\
# su=:\
# sg=:\
# tw=:\
# ow=w:\
# st=:\
# ex=:\
# *.7z=:\
# *.a=:\
# *.aac=:\
# *.ace=:\
# *.ai=:\
# *.alz=:\
# *.apk=:\
# *.arc=:\
# *.arj=:\
# *.asf=:\
# *.asm=:\
# *.asp=:\
# *.au=:\
# *.aup=:\
# *.avi=:\
# *.avi=:\
# *.awk=:\
# *.bash=:\
# *.bat=:\
# *.bmp=:\
# *.bz2=:\
# *.bz=:\
# *.c++=:\
# *.c=:\
# *.cab=:\
# *.cbr=:\
# *.cbz=:\
# *.cc=:\
# *.cgm=:\
# *.class=:\
# *.clj=:\
# *.cljc=:\
# *.cljs=:\
# *.cmake=:\
# *.cmd=:\
# *.coffee=:\
# *.conf=:\
# *.cp=:\
# *.cpio=:\
# *.cpp=:\
# *.cs=:\
# *.css=:\
# *.cue=:\
# *.csh=:\
# *.cvs=:\
# *.cxx=:\
# *.d=:\
# *.dart=:\
# *.db=:\
# *.deb=:\
# *.diff=:\
# *.dl=:\
# *.dll=:\
# *.doc=:\
# *.docx=:\
# *.dump=:\
# *.dwm=:\
# *.dz=:\
# *.ear=:\
# *.edn=:\
# *.eex=:\
# *.efi=:\
# *.ejs=:\
# *.elf=:\
# *.elm=:\
# *.emf=:\
# *.epub=:\
# *.erl=:\
# *.esd=:\
# *.ex=:\
# *.exe=:\
# *.exs=:\
# *.f#=:\
# *.fifo=|:\
# *.fish=:\
# *.flac=:\
# *.flc=:\
# *.fli=:\
# *.flv=:\
# *.flv=:\
# *.fs=:\
# *.fsi=:\
# *.fsscript=:\
# *.fsx=:\
# *.gem=:\
# *.gif=:\
# *.git=:\
# *.gl=:\
# *.go=:\
# *.gz=:\
# *.gzip=:\
# *.h=:\
# *.hbs=:\
# *.hh=:\
# *.hpp=:\
# *.hrl=:\
# *.hs=:\
# *.htaccess=:\
# *.htm=:\
# *.html=:\
# *.htpasswd=:\
# *.ico=:\
# *.img=:\
# *.ini=:\
# *.iso=:\
# *.jar=:\
# *.java=:\
# *.jl=:\
# *.jpeg=:\
# *.jpg=:\
# *.js=:\
# *.json=:\
# *.jsx=:\
# *.key=:\
# *.ksh=:\
# *.less=:\
# *.lha=:\
# *.lhs=:\
# *.log=:\
# *.lrz=:\
# *.lua=:\
# *.lz4=:\
# *.lz=:\
# *.lzh=:\
# *.lzma=:\
# *.lzo=:\
# *.m2v=:\
# *.m4a=:\
# *.m4v=:\
# *.markdown=:\
# *.md=:\
# *.mid=:\
# *.midi=:\
# *.mjpeg=:\
# *.mjpg=:\
# *.mka=:\
# *.mkv=:\
# *.ml=λ:\
# *.mli=λ:\
# *.mng=:\
# *.mov=:\
# *.mp3=:\
# *.mp4=:\
# *.mp4v=:\
# *.mpc=:\
# *.mpeg=:\
# *.mpg=:\
# *.msi=:\
# *.mustache=:\
# *.nix=:\
# *.nuv=:\
# *.o=:\
# *.oga=:\
# *.ogg=:\
# *.ogm=:\
# *.ogv=:\
# *.ogx=:\
# *.opus=:\
# *.pbm=:\
# *.pcx=:\
# *.pdf=:\
# *.pgm=:\
# *.php=:\
# *.pl=:\
# *.pm=:\
# *.png=:\
# *.ppk=:\
# *.ppm=:\
# *.ppt=:\
# *.pptx=:\
# *.pro=:\
# *.ps1=:\
# *.psb=:\
# *.psd=:\
# *.pub=:\
# *.py=:\
# *.pyc=:\
# *.pyd=:\
# *.pyo=:\
# *.qt=:\
# *.ra=:\
# *.rar=:\
# *.rb=:\
# *.rc=:\
# *.rlib=:\
# *.rm=:\
# *.rmvb=:\
# *.rom=:\
# *.rpm=:\
# *.rs=:\
# *.rss=:\
# *.rtf=:\
# *.rz=:\
# *.s=:\
# *.sar=:\
# *.scala=:\
# *.scss=:\
# *.sh=:\
# *.slim=:\
# *.sln=:\
# *.so=:\
# *.spx=:\
# *.sql=:\
# *.styl=:\
# *.suo=:\
# *.svg=:\
# *.svgz=:\
# *.swm=:\
# *.t7z=:\
# *.t=:\
# *.tar=:\
# *.taz=:\
# *.tbz2=:\
# *.tbz=:\
# *.tga=:\
# *.tgz=:\
# *.tif=:\
# *.tiff=:\
# *.tlz=:\
# *.ts=:\
# *.twig=:\
# *.txz=:\
# *.tz=:\
# *.tzo=:\
# *.tzst=:\
# *.vim=:\
# *.vimrc=:\
# *.vob=:\
# *.war=:\
# *.wav=:\
# *.wav=:\
# *.webm=:\
# *.wim=:\
# *.wmv=:\
# *.xbm=:\
# *.xbps=:\
# *.xcf=:\
# *.xhtml=:\
# *.xls=:\
# *.xlsx=:\
# *.xml=:\
# *.xpm=:\
# *.xspf=:\
# *.xul=:\
# *.xwd=:\
# *.xz=:\
# *.yaml=:\
# *.yml=:\
# *.yuv=:\
# *.z=:\
# *.zip=:\
# *.zoo=:\
# *.zsh=:\
# *.zst=:\
# *.src=:\
# *.ebuild=:\
# "
#
# # set LF_ICONS "\
# # tw=:\
# # st=:\
# # ow=:\
# # dt=:\
# # di=:\
# # fi=:\
# # ln=:\
# # or=:\
# # *.7z=:\
# # *.a=:\
# # *.ai=:\
# # *.apk=:\
# # *.asm=:\
# # *.asp=:\
# # *.aup=:\
# # *.avi=:\
# # *.awk=:\
# # *.bash=:\
# # *.bat=:\
# # *.bmp=:\
# # *.bz2=:\
# # *.c=:\
# # *.c++=:\
# # *.cab=:\
# # *.cbr=:\
# # *.cbz=:\
# # *.cc=:\
# # *.class=:\
# # *.clj=:\
# # *.cljc=:\
# # *.cljs=:\
# # *.cmake=:\
# # *.coffee=:\
# # *.conf=:\
# # *.cp=:\
# # *.cpio=:\
# # *.cpp=:\
# # *.cs=:\
# # *.csh=:\
# # *.css=:\
# # *.cue=:\
# # *.cvs=:\
# # *.cxx=:\
# # *.d=:\
# # *.dart=:\
# # *.db=:\
# # *.deb=:\
# # *.diff=:\
# # *.dll=:\
# # *.doc=:\
# # *.docx=:\
# # *.dump=:\
# # *.edn=:\
# # *.eex=:\
# # *.efi=:\
# # *.ejs=:\
# # *.elf=:\
# # *.elm=:\
# # *.epub=:\
# # *.erl=:\
# # *.ex=:\
# # *.exe=:\
# # *.exs=:\
# # *.f#=:\
# # *.fifo=|
# # *.fish=:\
# # *.flac=:\
# # *.flv=:\
# # *.fs=:\
# # *.fsi=:\
# # *.fsscript=:\
# # *.fsx=:\
# # *.gem=:\
# # *.gemspec=:\
# # *.gif=:\
# # .git=:\
# # *.go=:\
# # *.gz=:\
# # *.gzip=:\
# # *.h=:\
# # *.haml=:\
# # *.hbs=:\
# # *.hh=:\
# # *.hpp=:\
# # *.hrl=:\
# # *.hs=:\
# # *.htaccess=:\
# # *.htm=:\
# # *.html=:\
# # *.htpasswd=:\
# # *.hxx=:\
# # *.ico=:\
# # *.img=:\
# # *.ini=:\
# # *.iso=:\
# # *.jar=:\
# # *.java=:\
# # *.jl=:\
# # *.jpeg=:\
# # *.jpg=:\
# # *.js=:\
# # *.json=:\
# # *.jsx=:\
# # *.key=:\
# # *.ksh=:\
# # *.leex=:\
# # *.less=:\
# # *.lha=:\
# # *.lhs=:\
# # *.log=:\
# # *.lua=:\
# # *.lzh=:\
# # *.lzma=:\
# # *.m4a=:\
# # *.m4v=:\
# # *.markdown=:\
# # *.md=:\
# # *.mdx=:\
# # *.mjs=:\
# # *.mkv=:\
# # *.ml=λ:\
# # *.mli=λ:\
# # *.mov=:\
# # *.mp3=:\
# # *.mp4=:\
# # *.mpeg=:\
# # *.mpg=:\
# # *.msi=:\
# # *.mustache=:\
# # *.nix=:\
# # *.o=:\
# # *.ogg=:\
# # *.pdf=:\
# # *.php=:\
# # *.pl=:\
# # *.pm=:\
# # *.png=:\
# # *.pp=:\
# # *.ppt=:\
# # *.pptx=:\
# # *.ps1=:\
# # *.psb=:\
# # *.psd=:\
# # *.pub=:\
# # *.py=:\
# # *.pyc=:\
# # *.pyd=:\
# # *.pyo=:\
# # *.r=ﳒ:\
# # *.rake=:\
# # *.rar=:\
# # *.rb=:\
# # *.rc=:\
# # *.rlib=:\
# # *.rmd=:\
# # *.rom=:\
# # *.rpm=:\
# # *.rproj=鉶:\
# # *.rs=:\
# # *.rss=:\
# # *.rtf=:\
# # *.s=:\
# # *.sass=:\
# # *.scala=:\
# # *.scss=:\
# # *.sh=:\
# # *.slim=:\
# # *.sln=:\
# # *.so=:\
# # *.sql=:\
# # *.styl=:\
# # *.suo=:\
# # *.swift=:\
# # *.t=:\
# # *.tar=:\
# # *.tex=ﭨ:\
# # *.tgz=:\
# # *.toml=:\
# # *.ts=:\
# # *.tsx=:\
# # *.twig=:\
# # *.vim=:\
# # *.vimrc=:\
# # *.vue=﵂:\
# # *.wav=:\
# # *.webm=:\
# # *.webmanifest=:\
# # *.webp=:\
# # *.xbps=:\
# # *.xcplayground=:\
# # *.xhtml=:\
# # *.xls=:\
# # *.xlsx=:\
# # *.xml=:\
# # *.xul=:\
# # *.xz=:\
# # *.yaml=:\
# # *.yml=:\
# # *.zip=:\
# # *.zsh=:\
# # "
