#!/bin/bash
# Profile
# This contains certain commands that I use regularly for the terminal.

# Adds tab completion for git commands
# source ~/.profile-config/.git-completion.sh

# Adds the ability to show git information in the PS1 line.
# source ~/.profile-config/.git-prompt.sh

# Fix colors on prompt and add git branch name
# Shows more details in prompt.
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
set TERM xterm-256color; export TERM
# export PS1='\[\033[94m\][\[\033[m\]\[\033[90m\]\w\[\033[m\]\[\033[94m\]]\[\033[m\]\[\033[91m\]$(__git_ps1 " (%s)")\n\[\033[m\]\[\033[94m\]⮑\[\033[m\]  '
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad # defines nicer colors for the LS command

# MISC aliases
alias git-remove-untracked='git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d' # Clean up local branches.
#alias windows='cd /mnt/c/Users/Admin/'
alias git-add-identity="ssh-add -K ~/.ssh/id_rsa"
alias rmd="rm -rf"
alias ll="ls -al"
alias ue5="/home/samwise/applications/UnrealEngine/Engine/Binaries/Linux/UnrealEditor > /dev/null 2>&1 &"
alias rgb="openrgb --profile zelda.orp"
alias movesteam="wmctrl-app -w \"Steam\" -m1"
alias steamsavefolder="cd ~/.steam/debian-installation/steamapps/compatdata/"

# Git aliases
alias gci="git commit"
alias gcim="git commit -m"
alias gst="git status"
alias ga="git add"
alias gall="git add ."
alias gap="git add --patch"
alias gcob="git checkout -b"
alias gco="git checkout"
alias gcoa="git checkout ."
alias gdiff="git diff"
alias gdiffs="git diff --staged"
alias gbrall="git branch --all"
alias gbr="git branch"
alias gup="git branch -vv"
alias gbrd="git branch -D"
alias gcp="git cherry-pick"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"
alias gri="git rebase -i"
alias grc="git rebase --continue"
alias gra="git rebase --abort"
alias gm="git merge"
alias gmc="git merge --continue"
alias gma="git merge --abort"
alias gfp="git fetch --prune"
alias gfa="git fetch --all --prune"
alias gpu="git pull"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gps="git push --set-upstream"
alias gpso="git push --set-upstream origin"
alias gpd="git push -d"
alias gl="git log"
alias gl3="git log -3"
alias gr="git remote"
alias grv="git remote -v"
alias gra="git remote add"
alias grr="git remote rename"
alias grrm="git remote remove"
alias grs="git remote set-url"
alias gre="git reset"
alias greh="git reset HEAD"
alias grehh="git reset HEAD --hard"
alias grem="git reset --mixed"
alias gss="git stash push"
alias gsl="git stash list"
alias gsd="git stash drop"
alias gsp="git stash pop"
alias gsc="git stash clear"
alias gsa="git stash apply"
alias gres="git restore --staged"

# Adding to the PATH
export PATH="$HOME/bin:$PATH"
export VISUAL='subl -w'
export EDITOR="$VISUAL"
export DENO_INSTALL="/home/samwise/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="/home/samwise/applications/swift-5.5.3/usr/bin:$PATH"

###
# Opens github.com based on the 'git remote'
#
# $1 Action to perform.
##
function github () 
{
    local arg1="$1"
    local repo=$(git config --get remote.origin.url)

    # Format to the correct url.
    if [[ $repo == git* ]]; then
        repo="https://www.github.com/"${repo##*:}

        if [[ $repo == *git ]]; then
            repo=${repo%%.git}
        fi
    fi

    # See if an argument is given. If so changed the url based off that.
    echo "$arg1"
    if [[ ! -z "$arg1" ]]; then
        local branch=$(git rev-parse --abbrev-ref HEAD)
        if [[ "$arg1" == "commits" ]]; then
            repo="$repo/commits/$branch"
        elif [[ "$arg1" == "branch" ]]; then
            repo="$repo/tree/$branch"
        elif [[ "$arg1" == "pr" ]]; then
            repo="$repo/compare/$branch?expand=1"
        elif [[ "$arg1" == "actions" ]]; then
            repo="$repo/actions"
        fi
    fi

    # Finally open the url in chrome.
    open "$repo"
}

