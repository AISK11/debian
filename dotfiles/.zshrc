##################################################################
# Author: AISK11

# Packages installed:
# sudo apt install zsh zsh-autosuggestions zsh-syntax-highlighting

# Change default shell:
# user$ chsh -s /bin/zsh
# root# usermod -s /bin/zsh <USER>
##################################################################

## Security clear:
clear

autoload -U colors && colors
## command prompt (https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Prompt-Expansion):
## Foreground: %F{XXX} ; bacKground: %K{XXX} (https://askubuntu.com/questions/821157/print-a-256-color-test-pattern-in-the-terminal/821163):
#export PS1="%n@%m %~ %# "
export PS1="%{$fg[red]%}%n%{$fg[yellow]%}@%{$fg[red]%}%m %{$fg[yellow]%}%~ %{$fg[red]%}%# %{$reset_color%}"

## Autocompletion:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

## Key compatibility
bindkey -v
export KEYTIMEOUT=1

## History settings:
export HISTSIZE=2000
export HISTFILE="${HOME}/.zsh_history"
export SAVEHIST=${HISTSIZE}

## PATH variable:
export PATH=${PATH}:/sbin:/usr/sbin

## Aliases:
## System:
alias ls='ls --color=always'
alias l='ls -l'
alias ll='ls -l'
alias la='ls -lah'
alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias watch='watch -n 1'
## UserPrograms:
alias lightcord='cd ~/Lightcord && npm start &'
alias mp3_download='youtube-dl --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output "%(title)s.%(ext)s" --no-playlist'
alias mp3_download_playlist='youtube-dl -i -x --yes-playlist --audio-format "mp3" --audio-quality 0 --console-title'
alias www='firefox'
## Network:
alias ip='ip -c'
alias mtr='mtr -t'
alias wireshark='doas wireshark'
## Network Advanced:
ipv4_forward_yes()
{
    doas bash -c 'echo "1" > /proc/sys/net/ipv4/ip_forward'
}
ipv4_forward_no()
{
    doas bash -c 'echo "0" > /proc/sys/net/ipv4/ip_forward'
}
## Nvidia:
alias run_with_nvidia='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'

## Functions:
## Usage: $(mem <program-name>)
mem()
{
    ps -eo rss,pid,euser,args --sort %mem | grep -i $@ | grep -v grep | awk '{printf $1/1024 "MB"; $1=""; print }'
}

### Usefull commands
## Remove audio from video:
#ffmpeg -i <input_file.mp4> -vcodec copy -an <output_file.mp4>


## Protects against accidental
## [doas ]rm [-rf ]/*[*]
## Much safer syntax must be used:
## [daos ]rm [-rf ]*
## Credit: https://unix.stackexchange.com/questions/73000/zsh-check-arguments-of-a-command-before-executing-it
accept-line() {
    if [[ $BUFFER =~ '.*rm\ .*/\*/*' ]]; then
        zle -M "Why are you doing this to me?!"
    else
        zle .$WIDGET "$@"
    fi
}
zle -N accept-line

## start X:
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]];
then
    source /etc/profile
    startx
fi

## enable auto-suggestions based on the history:
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ## change suggestion color:
    #ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

#################
## zsh insults ##
#################
## Credits:
## https://github.com/ahmubashshir/zinsults
## https://github.com/hkbakke/bash-insulter
## https://gist.github.com/Cysioland/021140812b7cd86c19fb
########################################
ALLOW_INSULTS=1

if [[ ${ALLOW_INSULTS} -ne 0 ]]; then
    0=${(%):-%N}
    __zinsult_msgfile="${0:A:h}/.zsh/msgs.zsh"
    if
        [[ -w ${__zinsult_msgfile:P:h} ]] \
        && [[
            -s "${__zinsult_msgfile}" \
            && (
                ! -s "${__zinsult_msgfile}.zwc" \
                || "${__zinsult_msgfile}" -nt "${__zinsult_msgfile}.zwc"
            )
        ]]
    then
        builtin zcompile -Mz "${__zinsult_msgfile}"
    fi
    if ! ((${+functions[command_not_found_handler]})); then
        function command_not_found_handler {
            printf 'zsh: command not found: %s\n' "$1" >&2
        }
    fi
    if ! ((${+functions[__zinsult_try_find_command]}));then
        functions -c command_not_found_handler __zinsult_try_find_command
    fi
    if (( ! ${+zinsults_load} )); then
        typeset -ga zinsults_load
    fi

    function command_not_found_handler {
        local -a msgs
        local idx
        setopt localoptions noksharrays
        if ! ((${+CMD_NOT_FOUND_MSGS}));then
            source "${__zinsult_msgfile}"
        else
            msgs=( "${CMD_NOT_FOUND_MSGS[@]}" )
        fi
        if (($#msgs>0));then
            RANDOM=$(od -vAn -N4 -tu < /dev/urandom)
            builtin print -P -f 'zsh: %s\n' "$msgs[RANDOM % $#msgs + 1]"
            unset msgs
        fi
        __zinsult_try_find_command "$@"
    }
fi
########################################

## Syntax highlighting:
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
