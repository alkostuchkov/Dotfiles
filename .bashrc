# For ranger, htop and other console progs in Qtile ---------------------------
unset COLUMNS
unset LINES

###############################################################################
# EXPORTs
###############################################################################
export HOME=$(echo /home/$USER)
export GHCUP_INSTALL_BASE_PREFIX="$HOME/.config"  # for GHCUP

# export
PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.config/vifm/scripts:$HOME/Programs/AppImageApplications:$GHCUP_INSTALL_BASE_PREFIX/.ghcup/bin:$HOME/Programs/Android_SDK/platform-tools
export EDITOR="vim"   #  vim is either a link to nvim    or just  vim
export VISUAL="gvim"  # gvim is either a link to nvim-qt or just gvim
export TERM="xterm-256color"
export TERMINAL="alacritty"
export BROWSER="firefox"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"  # $MANPAGER use batcat to read mans
export RANGER_LOAD_DEFAULT_RC=FALSE  # to avoid loading ranger's config twice
export ANDROID_SDK="$HOME/Programs/Android_SDK"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share"
export XDG_DATA_DIRS+=":/var/lib/flatpak/exports/share"
export XDG_DATA_DIRS+=":$HOME/.local/share/flatpak/exports/share/applications"
export XDG_DATA_DIRS+=":/var/lib/flatpak/exports/share/applications"
export XDG_CACHE_HOME="$HOME/.cache"

# If not running interactively, don't do anything -----------------------------
case $- in
    *i*) ;;
      *) return;;
esac

###############################################################################
# HIST...
###############################################################################
# don't put duplicate lines or lines starting with space in the history ------
# See bash(1) for more options
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1) ---------
HISTSIZE=1000
HISTFILESIZE=2000

###############################################################################
# shopt
###############################################################################
# append to the history file, don't overwrite it ------------------------------
shopt -s histappend
# check the window size after each command and, if necessary, -----------------
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will ----------
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

# enable programmable completion features (you don't need to enable -----------
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###############################################################################
# prompt
###############################################################################
# set variable identifying the chroot you work in (used in the prompt below) --
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color) --------------
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned --
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir --------------------------
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWCOLORHINTS=true
# export PS1='\w$(__git_ps1 " (%s)")\$ '
# PS1='\n \[\e[01;33m\]\u\[\e[01;37m\]@\[\e[01;32m\]\h:\[\e[01;34m\]\w\[\e[01;31m\]$(__git_ps1 " (%s)")\[\e[01;33m\]\n >_ \[\e[2m\]'
PS1='\n \[\e[01;33m\]\u\[\e[01;37m\]@\[\e[01;32m\]\h:\[\e[01;34m\]\w\[\e[01;31m\]$(__git_ps1 " (%s)")\[\e[01;33m\]\n >_ \[\e[0m\]'

###############################################################################
# ALIASES
###############################################################################
# enable color support of ls and also add handy aliases -----------------------
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Alias definitions -----------------------------------------------------------
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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
# git -------------------------------------------------------------------------
source ~/.git-completion.bash
source ~/.git-prompt.sh
# asdf manager ----------------------------------------------------------------
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash
# Fuzzy finder ----------------------------------------------------------------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# # broot -----------------------------------------------------------------------
# source /home/alexander/.config/broot/launcher/bash/br

# Run neofetch ----------------------------------------------------------------
neofetch

# Icons for lf file manager ---------------------------------------------------
# export LF_ICONS="\
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
# # export LF_ICONS="\
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
#
