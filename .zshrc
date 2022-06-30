xcode_dir="$(xcode-select -p)"
if [[ -d "${xcode_dir}" ]]; then
    # Load tab completion for git commands (compinit must be run separately).
    zstyle ':completion:*:*:git:*' script "${xcode_dir}/usr/share/git-core/git-completion.zsh"

    # Add git information to the prompt.
    source "${xcode_dir}/usr/share/git-core/git-prompt.sh"
    export GIT_PS1_SHOWCOLORHINTS=true

    # Setup the prompt.
    NEWLINE=$'\n'
    precmd () { __git_ps1 "%F{blue}[%f%F{245}%~%f%F{blue}]%f" "%F{blue}${NEWLINE}⮑ %f " " \e[91m(\e[0m%s\e[91m)\e[0m" }
fi

# Enable code completion.
# if this doesn't work, try deleting the completion cache file (~/.zcompdump) and restarting shell.
autoload -Uz compinit && compinit

source ~/.profile-config/.bash_profile