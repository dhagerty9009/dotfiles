#!/bin/zsh
######################################################################
#                                                                    #
#                                                                    #
#                                                                    #
#                                                                    #
#                The Zsh Configuraton of David Hagerty               #
#                                                                    #
#                      Crafted with Loving Care                      #
#                           Over the Years                           #
#                     For Increased Productivity                     #
#                       And Incredible Utility                       #
#                                                                    #
#                              (c) 2016                              #
#                                                                    #
#                                                                    #
#                                                                    #
######################################################################


# Shell Options
#--------------------
# zshoptions(1)  /  http://zsh.sourceforge.net/Doc/Release/Options.html

# Changing Directories
setopt auto_cd # If command is a directory path, cd to it
setopt auto_pushd # cd is really pushd
setopt chase_dots # Resolve `..` directories to their true location
setopt chase_links # Resolve links to their true location
setopt pushd_ignore_dups # Don't put duplicates on the directory stack
setopt pushd_minus # Make `cd -1` go to the previous directory, etc
setopt pushd_to_home # pushd with no arguments goes home, like cd

# Completion
setopt auto_name_dirs # Parameters set to a path can be used as ~param
setopt auto_remove_slash # Remove trailing slash if next char is a word delim
setopt hash_list_all # Before completion, make sure entire path is hashed
setopt glob_complete # Expand globs upon completion
setopt complete_in_word # Completions happen at the cursor's location

# Expansion and Globbing
setopt glob # Perform filename generation (i.e. the use of the * operator)
setopt extended_glob # Use additional glob operators
# setopt glob_dots # Glob dotfiles
setopt mark_dirs # Directories resulting from globbing have trailing slashes
setopt nomatch # If a glob fails, the command isn't executed

# History
setopt hist_ignore_all_dups # Ignore all duplicates when writing history
setopt hist_ignore_space # Ignore commands that begin with spaces
setopt inc_append_history # Write commands to history file as soon as possible

# Input/Output
# setopt noclobber # Prevents `>` from clobbering files. Use `>|` to clobber.
setopt correct # Try to correct the spelling of commands
setopt interactive_comments # Allow comments in interactive shells

# Job Control
setopt auto_continue # When suspended jobs are disowned, resume them in the bg
setopt auto_resume # single-word simple commands are candidates for resumption
setopt bg_nice # Run background jobs at lower priority
setopt check_jobs # Warn about background & suspended jobs on exit
setopt monitor # Enable job control. This is default.

# Prompting
setopt prompt_cr # Print a \r before the prompt
setopt prompt_sp # Preserve lines that would be covered by the \r
setopt prompt_subst # Substitute in parameter/command/arithmetic expansions

# ZLE
# setopt no_beep # The shell shouldn't beep on ZLE errors (most beeps)
setopt zle # Use ZLE. This is default, but I like to be explicit


# Aliases
#--------------------

alias sed="sed -r"
alias ls="ls -a -l --human-readable --classify --group-directories-first --color=auto"
alias mkdir="mkdir -p"
alias grep="grep --extended-regexp --no-messages --binary-files=without-match \
                 --line-number --color"

## Homebrew Aliases

function brho { brew home $1; }
function brse { brew search $1; }
alias bupd="brew update"
alias bupg="brew upgrade --all && brew cleanup"
alias cask="brew cask"

## Git Aliases

alias g="git"
alias git=hub
alias gpo="git push origin"
alias gpm="git push origin master"

## Docker Aliases

alias doco="docker-compose"
alias doma="docker-machine"
alias dcr="docker-compose run"

## Rails Aliases
alias be="bundle exec"
alias r="bundle exec rails"
alias routes="bundle exec rake routes"
alias rc="bundle exec rails console"
alias rs="bundle exec rails server"
function routes_for { rake routes | grep $1; }

## Tmux Aliases
alias at="tmux attach -t"
alias switch="tmux switch -t"
alias ts="tmux new-session -s $PWD"

## Navigation Aliases

# alias la="ls -la"
# alias lf="ls -AFG"

function mcd { mkdir $1; cd $1; }
function cdl { cd $1; ls -a; }
function mct { mkdir $1; cd $1; touch $2; }

## Editing Aliases

alias vim="/usr/local/Cellar/macvim/7.*/MacVim.app/Contents/MacOS/Vim"

## Network Aliases

alias ntest="ping -n -c 1000 www.google.com"

## Application Aliases

alias tover="travis branches"
alias tstat="travis status"
alias tlive="travis logs"
alias mc="mailcatcher"
alias wiki="gollum --host 127.0.0.1"

## Scripting Aliases

alias py26="python"
alias pyi3="python3"
alias rb="ruby"

alias koans="cd ~/code/Ruby/koans/; ruby path_to_enlightenment.rb"


# Environment
#--------------------
export HAXE_STD_PATH="/usr/local/lib/haxe/std"
export NODE_PATH=/usr/local/lib/node

. `brew --prefix`/etc/profile.d/z.sh

source /Users/david/.secrets

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

[ -f /Users/david/.travis/travis.sh ] && source /Users/david/.travis/travis.sh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/david/.iterm2_shell_integration.zsh

# Core tools
EDITOR="vim"
VISUAL="vim"
PAGER="less"
export EDITOR VISUAL PAGER

# History
#--------------------

HISTSIZE=2000
HISTFILE=${ZDOTDIR}/.history
SAVEHIST=$HISTSIZE
export HISTSIZE HISTFILE SAVEHIST


# Keyboard
#--------------------

autoload -Uz zkbd
[[ ! -f ${ZDOTDIR}/zkbd/${TERM} ]] && zkbd
source ${ZDOTDIR}/zkbd/${TERM}

bindkey -e
[[ -n "${key[Home]}"       ]] && bindkey "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"        ]] && bindkey "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"     ]] && bindkey "${key[Insert]}"     overwrite-mode
[[ -n "${key[Delete]}"     ]] && bindkey "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"         ]] && bindkey "${key[Up]}"         up-line-or-search
[[ -n "${key[Down]}"       ]] && bindkey "${key[Down]}"       down-line-or-search
[[ -n "${key[Left]}"       ]] && bindkey "${key[Left]}"       backward-char
[[ -n "${key[Right]}"      ]] && bindkey "${key[Right]}"      forward-char
[[ -n "${key[Ctrl-Left]}"  ]] && bindkey "${key[Ctrl-Left]}"  backward-word
[[ -n "${key[Ctrl-Right]}" ]] && bindkey "${key[Ctrl-Right]}" forward-word


# Prompt
#--------------------

autoload -Uz promptinit && promptinit
prompt cbarrick


# Completion
#--------------------

autoload -Uz compinit && compinit -u

zstyle ':completion:*' use-cache true # Cache completion to `${ZDOTDIR}/.zcompcache`
zstyle ':completion:*' squeeze-slashes true # Strip slashes from directories
zstyle ':completion:*' menu select # Make the menu interactive with arrow keys

bindkey '^I' menu-expand-or-complete
bindkey '^[[Z' reverse-menu-complete


# zmv - Batch Rename
#--------------------

autoload -Uz zmv
alias mv="noglob zmv"

# EX: Rename all .cpp files to .cc
#     zmv '(*).cpp' '$1.cc'
# Arguments are quoted to escape the globbing system
# Use `-n` for a dry-run


# Quick Status
#--------------------
# Use the `l` command to print both the directory listing and git status
# Use `ll` to include dotfiles

function l {
	git -C $PWD/$1:h/$1:t status -sb $PWD/$1 2>/dev/null
	ls $@ --format=long
}

function ll {
	git -C $PWD/$1:h/$1:t status -sb $PWD/$1 2>/dev/null
	ls $@ --format=long --almost-all
}


# Rationalize Dots
#--------------------

function rationalize-dot {
	if [[ $LBUFFER = *... ]]; then
		LBUFFER=$LBUFFER[1,-2]
		LBUFFER+=/..
	else
		LBUFFER+=.
	fi
}
zle -N rationalize-dot
bindkey . rationalize-dot


# Apple Terminal.app
#--------------------
# Alert Terminal.app of the current directory (for the resume feature among others)
# based on this answer: http://superuser.com/a/328148

update_terminal_cwd() {
	# Get the directory as a "file:" URL, including the hostname.
	local URL_PATH=''
	{
		# LANG=C to process text byte-by-byte.
		local i ch hexch LANG=C
		for ((i = 1; i <= ${#PWD}; ++i)); do
			ch="$PWD[i]"
			if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
				URL_PATH+="$ch"
			else
				# Percent-encode special characters
				hexch=$(printf "%02X" "'$ch")
				URL_PATH+="%$hexch"
			fi
		done
	}

	# Print the pathname through a special escape sequence to inform Terminal.app
	local PWD_URL="file://$HOST$URL_PATH"
	printf '\e]7;%s\a' "$PWD_URL"
}

if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
	autoload add-zsh-hook
	add-zsh-hook precmd update_terminal_cwd
fi


# Startup
#--------------------

print "\r${USER} @ ${HOST}"