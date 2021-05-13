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

export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.config/vifm/scripts:$HOME/Programs/AppImageApplications:$PATH
export EDITOR="vim"
export VISUAL="gvim"
export TERM="xterm-256color"
export TERMINAL="alacritty"
export BROWSER="firefox"
# export BROWSER="qutebrowser"
#export EDITOR="emacs -nw"
# export QT_QPA_PLATFORMTHEME="qt5ct"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export NVM_DIR="$HOME/.nvm"

#export LANG=en_US.UTF8
#export LANGUAGE=en_US:en

# export PATH=$(echo $PATH | awk -F: '
# { for (i = 1; i <= NF; i++) arr[$i]; }
# END { for (i in arr) printf "%s:" , i; printf "\n"; } ')
