# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# For ranger, htop and other console progs in Qtile
unset COLUMNS
unset LINES

# EXPORTs
export HOME=$(echo /home/$USER)
# export
# PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.config/vifm/scripts:$HOME/Programs/AppImageApplications:$HOME/Programs/Android_SDK/platform-tools
export EDITOR="vim"
export VISUAL="gvim"
export TERM="xterm-256color"
# export TERM="screen-256color"
export TERMINAL="alacritty"
export BROWSER="firefox"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"  # $MANPAGER use batcat to read mans
export RANGER_LOAD_DEFAULT_RC=FALSE  # to avoid loading ranger's config twice 
export ANDROID_SDK=$HOME/Programs/Android_SDK
# export BROWSER="qutebrowser"
#export EDITOR="emacs -nw"
# export QT_QPA_PLATFORMTHEME="qt5ct"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export PATH="/home/alexander/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

### ALIASES ###
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
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
alias ll='lsd --blocks=permission,size,user,group,date,name --group-dirs=first --date="+%d %b %H:%M"'
alias la='ll -a'
# alias bat='bat --theme gruvbox-dark'  # theme moved to the ~/.config/bat/config
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ifconfig=/sbin/ifconfig

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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#complete -cf sudo
#complete -cf sudo gksu

### https://github.com/magicmonty/bash-git-prompt ###
### START 
# # Set config variables first
# GIT_PROMPT_ONLY_IN_REPO=1
#
# # GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
# # GIT_PROMPT_IGNORE_SUBMODULES=1 # uncomment to avoid searching for changed files in submodules
# # GIT_PROMPT_WITH_VIRTUAL_ENV=0 # uncomment to avoid setting virtual environment infos for node/python/conda environments
#
# # GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
# # GIT_PROMPT_SHOW_UNTRACKED_FILES=normal # can be no, normal or all; determines counting of untracked files
#
# # GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0 # uncomment to avoid printing the number of changed files
#
# # GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10
#
# # GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
# # GIT_PROMPT_END=...      # uncomment for custom prompt end sequence
#
# # as last entry source the gitprompt script
# # GIT_PROMPT_THEME=Custom # use custom theme specified in file GIT_PROMPT_THEME_FILE (default ~/.git-prompt-colors.sh)
# # GIT_PROMPT_THEME_FILE=~/.git-prompt-colors.sh
# # GIT_PROMPT_THEME=Solarized # use theme optimized for solarized color scheme
# if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
#     GIT_PROMPT_ONLY_IN_REPO=1
#     source $HOME/.bash-git-prompt/gitprompt.sh
# fi
### FINISH 

### https://github.com/git/git/tree/master/contrib/completion
source ~/.git-completion.bash
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWCOLORHINTS=true
# export PS1='\w$(__git_ps1 " (%s)")\$ '
PS1='\n\[\e[01;33m\]\u\[\e[01;37m\]@\[\e[01;32m\]\h:\[\e[01;34m\]\w\[\e[01;31m\]$(__git_ps1 " (%s)")\[\e[01;33m\]\n > \[\e[0m\]'
# PS1='\n\[\e[01;33m\]\u\[\e[00;33m\]@\[\e[01;32m\]\h:\[\e[01;34m\][\w]\[\e[01;31m\]$(__git_ps1 " (%s)")\[\e[01;32m\]\n~~~>\[\e[0m\]'

# PS1='\n\[\e[01;33m\]\u\[\e[00;33m\]@\[\e[01;32m\]\h:\[\e[01;34m\][\w]\[\e[01;31m\]$(__git_ps1 "(%s)")\[\e[01;32m\]\n~~~>\[\e[0m\]'
# export PS1='\w$(__git_ps1 " (%s)")\$ '

# # Powerline-shell
# function _update_ps1() {
#     PS1=$(powerline-shell $?)
# }
#
# if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#     PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
# fi

# powerline-daemon -q
# POWERLINE_BASH_CONTINUATION=1
# POWERLINE_BASH_SELECT=1
# . /usr/local/lib/python3.7/dist-packages/powerline/bindings/bash/powerline.sh

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Run neofetch
neofetch

# Icons for lf file manager
export LF_ICONS="\
fi=:\
di=:\
ln=:\
pi=|:\
so=ﯲ:\
db=:\
cd=c:\
or=:\
su=:\
sg=:\
tw=:\
ow=w:\
st=:\
ex=:\
*.7z=:\
*.a=:\
*.aac=:\
*.ace=:\
*.ai=:\
*.alz=:\
*.apk=:\
*.arc=:\
*.arj=:\
*.asf=:\
*.asm=:\
*.asp=:\
*.au=:\
*.aup=:\
*.avi=:\
*.avi=:\
*.awk=:\
*.bash=:\
*.bat=:\
*.bmp=:\
*.bz2=:\
*.bz=:\
*.c++=:\
*.c=:\
*.cab=:\
*.cbr=:\
*.cbz=:\
*.cc=:\
*.cgm=:\
*.class=:\
*.clj=:\
*.cljc=:\
*.cljs=:\
*.cmake=:\
*.cmd=:\
*.coffee=:\
*.conf=:\
*.cp=:\
*.cpio=:\
*.cpp=:\
*.cs=:\
*.css=:\
*.cue=:\
*.csh=:\
*.cvs=:\
*.cxx=:\
*.d=:\
*.dart=:\
*.db=:\
*.deb=:\
*.diff=:\
*.dl=:\
*.dll=:\
*.doc=:\
*.docx=:\
*.dump=:\
*.dwm=:\
*.dz=:\
*.ear=:\
*.edn=:\
*.eex=:\
*.efi=:\
*.ejs=:\
*.elf=:\
*.elm=:\
*.emf=:\
*.epub=:\
*.erl=:\
*.esd=:\
*.ex=:\
*.exe=:\
*.exs=:\
*.f#=:\
*.fifo=|:\
*.fish=:\
*.flac=:\
*.flc=:\
*.fli=:\
*.flv=:\
*.flv=:\
*.fs=:\
*.fsi=:\
*.fsscript=:\
*.fsx=:\
*.gem=:\
*.gif=:\
*.git=:\
*.gl=:\
*.go=:\
*.gz=:\
*.gzip=:\
*.h=:\
*.hbs=:\
*.hh=:\
*.hpp=:\
*.hrl=:\
*.hs=:\
*.htaccess=:\
*.htm=:\
*.html=:\
*.htpasswd=:\
*.ico=:\
*.img=:\
*.ini=:\
*.iso=:\
*.jar=:\
*.java=:\
*.jl=:\
*.jpeg=:\
*.jpg=:\
*.js=:\
*.json=:\
*.jsx=:\
*.key=:\
*.ksh=:\
*.less=:\
*.lha=:\
*.lhs=:\
*.log=:\
*.lrz=:\
*.lua=:\
*.lz4=:\
*.lz=:\
*.lzh=:\
*.lzma=:\
*.lzo=:\
*.m2v=:\
*.m4a=:\
*.m4v=:\
*.markdown=:\
*.md=:\
*.mid=:\
*.midi=:\
*.mjpeg=:\
*.mjpg=:\
*.mka=:\
*.mkv=:\
*.ml=λ:\
*.mli=λ:\
*.mng=:\
*.mov=:\
*.mp3=:\
*.mp4=:\
*.mp4v=:\
*.mpc=:\
*.mpeg=:\
*.mpg=:\
*.msi=:\
*.mustache=:\
*.nix=:\
*.nuv=:\
*.o=:\
*.oga=:\
*.ogg=:\
*.ogm=:\
*.ogv=:\
*.ogx=:\
*.opus=:\
*.pbm=:\
*.pcx=:\
*.pdf=:\
*.pgm=:\
*.php=:\
*.pl=:\
*.pm=:\
*.png=:\
*.ppk=:\
*.ppm=:\
*.ppt=:\
*.pptx=:\
*.pro=:\
*.ps1=:\
*.psb=:\
*.psd=:\
*.pub=:\
*.py=:\
*.pyc=:\
*.pyd=:\
*.pyo=:\
*.qt=:\
*.ra=:\
*.rar=:\
*.rb=:\
*.rc=:\
*.rlib=:\
*.rm=:\
*.rmvb=:\
*.rom=:\
*.rpm=:\
*.rs=:\
*.rss=:\
*.rtf=:\
*.rz=:\
*.s=:\
*.sar=:\
*.scala=:\
*.scss=:\
*.sh=:\
*.slim=:\
*.sln=:\
*.so=:\
*.spx=:\
*.sql=:\
*.styl=:\
*.suo=:\
*.svg=:\
*.svgz=:\
*.swm=:\
*.t7z=:\
*.t=:\
*.tar=:\
*.taz=:\
*.tbz2=:\
*.tbz=:\
*.tga=:\
*.tgz=:\
*.tif=:\
*.tiff=:\
*.tlz=:\
*.ts=:\
*.twig=:\
*.txz=:\
*.tz=:\
*.tzo=:\
*.tzst=:\
*.vim=:\
*.vimrc=:\
*.vob=:\
*.war=:\
*.wav=:\
*.wav=:\
*.webm=:\
*.wim=:\
*.wmv=:\
*.xbm=:\
*.xbps=:\
*.xcf=:\
*.xhtml=:\
*.xls=:\
*.xlsx=:\
*.xml=:\
*.xpm=:\
*.xspf=:\
*.xul=:\
*.xwd=:\
*.xz=:\
*.yaml=:\
*.yml=:\
*.yuv=:\
*.z=:\
*.zip=:\
*.zoo=:\
*.zsh=:\
*.zst=:\
*.src=:\
*.ebuild=:\
"

# export LF_ICONS="\
# tw=:\
# st=:\
# ow=:\
# dt=:\
# di=:\
# fi=:\
# ln=:\
# or=:\
# *.7z=:\
# *.a=:\
# *.ai=:\
# *.apk=:\
# *.asm=:\
# *.asp=:\
# *.aup=:\
# *.avi=:\
# *.awk=:\
# *.bash=:\
# *.bat=:\
# *.bmp=:\
# *.bz2=:\
# *.c=:\
# *.c++=:\
# *.cab=:\
# *.cbr=:\
# *.cbz=:\
# *.cc=:\
# *.class=:\
# *.clj=:\
# *.cljc=:\
# *.cljs=:\
# *.cmake=:\
# *.coffee=:\
# *.conf=:\
# *.cp=:\
# *.cpio=:\
# *.cpp=:\
# *.cs=:\
# *.csh=:\
# *.css=:\
# *.cue=:\
# *.cvs=:\
# *.cxx=:\
# *.d=:\
# *.dart=:\
# *.db=:\
# *.deb=:\
# *.diff=:\
# *.dll=:\
# *.doc=:\
# *.docx=:\
# *.dump=:\
# *.edn=:\
# *.eex=:\
# *.efi=:\
# *.ejs=:\
# *.elf=:\
# *.elm=:\
# *.epub=:\
# *.erl=:\
# *.ex=:\
# *.exe=:\
# *.exs=:\
# *.f#=:\
# *.fifo=|
# *.fish=:\
# *.flac=:\
# *.flv=:\
# *.fs=:\
# *.fsi=:\
# *.fsscript=:\
# *.fsx=:\
# *.gem=:\
# *.gemspec=:\
# *.gif=:\
# .git=:\
# *.go=:\
# *.gz=:\
# *.gzip=:\
# *.h=:\
# *.haml=:\
# *.hbs=:\
# *.hh=:\
# *.hpp=:\
# *.hrl=:\
# *.hs=:\
# *.htaccess=:\
# *.htm=:\
# *.html=:\
# *.htpasswd=:\
# *.hxx=:\
# *.ico=:\
# *.img=:\
# *.ini=:\
# *.iso=:\
# *.jar=:\
# *.java=:\
# *.jl=:\
# *.jpeg=:\
# *.jpg=:\
# *.js=:\
# *.json=:\
# *.jsx=:\
# *.key=:\
# *.ksh=:\
# *.leex=:\
# *.less=:\
# *.lha=:\
# *.lhs=:\
# *.log=:\
# *.lua=:\
# *.lzh=:\
# *.lzma=:\
# *.m4a=:\
# *.m4v=:\
# *.markdown=:\
# *.md=:\
# *.mdx=:\
# *.mjs=:\
# *.mkv=:\
# *.ml=λ:\
# *.mli=λ:\
# *.mov=:\
# *.mp3=:\
# *.mp4=:\
# *.mpeg=:\
# *.mpg=:\
# *.msi=:\
# *.mustache=:\
# *.nix=:\
# *.o=:\
# *.ogg=:\
# *.pdf=:\
# *.php=:\
# *.pl=:\
# *.pm=:\
# *.png=:\
# *.pp=:\
# *.ppt=:\
# *.pptx=:\
# *.ps1=:\
# *.psb=:\
# *.psd=:\
# *.pub=:\
# *.py=:\
# *.pyc=:\
# *.pyd=:\
# *.pyo=:\
# *.r=ﳒ:\
# *.rake=:\
# *.rar=:\
# *.rb=:\
# *.rc=:\
# *.rlib=:\
# *.rmd=:\
# *.rom=:\
# *.rpm=:\
# *.rproj=鉶:\
# *.rs=:\
# *.rss=:\
# *.rtf=:\
# *.s=:\
# *.sass=:\
# *.scala=:\
# *.scss=:\
# *.sh=:\
# *.slim=:\
# *.sln=:\
# *.so=:\
# *.sql=:\
# *.styl=:\
# *.suo=:\
# *.swift=:\
# *.t=:\
# *.tar=:\
# *.tex=ﭨ:\
# *.tgz=:\
# *.toml=:\
# *.ts=:\
# *.tsx=:\
# *.twig=:\
# *.vim=:\
# *.vimrc=:\
# *.vue=﵂:\
# *.wav=:\
# *.webm=:\
# *.webmanifest=:\
# *.webp=:\
# *.xbps=:\
# *.xcplayground=:\
# *.xhtml=:\
# *.xls=:\
# *.xlsx=:\
# *.xml=:\
# *.xul=:\
# *.xz=:\
# *.yaml=:\
# *.yml=:\
# *.zip=:\
# *.zsh=:\
# "
