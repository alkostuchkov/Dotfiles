# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# # if running bash
# if [ -n "$BASH_VERSION" ]; then
    # # include .bashrc if it exists
    # if [ -f "$HOME/.bashrc" ]; then
	# . "$HOME/.bashrc"
    # fi
# fi
#
# # set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/bin" ] ; then
    # PATH="$HOME/bin:$PATH"
# fi
# PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH"

# # Append "$1" to $PATH when not already in.
# # This function API is accessible to scripts in /etc/profile.d
# append_path () {
    # case ":$PATH:" in
        # *:"$1":*)
            # ;;
        # *)
            # PATH="${PATH:+$PATH:}$1"
    # esac
# }
# # Append our default paths
# # append_path "/usr/local/sbin"
# # append_path "/usr/local/bin"
# # append_path "/usr/bin"
# append_path "$HOME/.local/bin"
# append_path "$HOME/.cargo/bin"
# append_path "$HOME/.config/vifm/scripts"
# append_path "$HOME/Programs/AppImageApplications"
#
# # Force PATH to be environment
# export PATH

export HOME=$(echo /home/$USER)

export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.config/vifm/scripts:$HOME/Programs/AppImageApplications
export EDITOR="vim"
export VISUAL="gvim"
export TERM="xterm-256color"
export TERMINAL="alacritty"
export BROWSER="firefox"
export RANGER_LOAD_DEFAULT_RC=FALSE  # to avoid loading ranger's config twice
# export BROWSER="qutebrowser"
#export EDITOR="emacs -nw"
# export QT_QPA_PLATFORMTHEME="qt5ct"
# export MANPAGER="sh -c 'col -bx | bat --theme gruvbox-dark -l man -p'"  # $MANPAGER use batcat to read mans
export MANPAGER="sh -c 'col -bx | bat -l man -p'"  # theme moved to the ~/.config/bat/config
export NVM_DIR="$HOME/.nvm"

#export LANG=en_US.UTF8
#export LANGUAGE=en_US:en

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# export PATH=$(echo $PATH | awk -F: '
# { for (i = 1; i <= NF; i++) arr[$i]; }
# END { for (i in arr) printf "%s:" , i; printf "\n"; } ')

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
