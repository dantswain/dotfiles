# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#

# zmodload zsh/zprof

######################################################################
# zsh set up

# enable autocomplete
autoload -U compinit; compinit

# bash autocomplete compatibility
autoload bashcompinit
bashcompinit

# auto-complete dotfiles
_comp_options+=(globdots) # With hidden files

setopt share_history

# use emacs key bindings
bindkey -e

#ZSH_THEME="af-magic"

#source ${HOME}/.zsh-prompt.zsh

# end zsh set up
######################################################################

# Python
export PYTHONSTARTUP=~/.pystartup

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

spark_home=/opt/apache/spark-2.1.2
if [[ -d ${spark_home} ]]
then
  export SPARK_HOME=${spark_home}
  export PYTHONPATH=${SPARK_HOME}/python/:${SPARK_HOME}/python/lib/:${PYTHONPATH}
fi
unset spark_home

# always launch emacs in 256-color terminal mode
alias emacs='TERM=xterm-256color emacs -nw'

# private env vars
if [[ -e ${HOME}/.zshprivate ]]
then
  source ${HOME}/.zshprivate
fi

PERL_MB_OPT="--install_base \"/Users/dswain/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/dswain/perl5"; export PERL_MM_OPT;

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [[ -f /usr/local/etc/profile.d/z.sh ]]
then
  . /usr/local/etc/profile.d/z.sh
fi

if [[ -d ~/bin ]]
then
  export PATH=~/bin:${PATH}
fi

if [[ -d /usr/local/opt/coreutils/libexec/gnubin ]]
then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

# added by travis gem
[ -f /Users/dswain/.travis/travis.sh ] && source /Users/dswain/.travis/travis.sh

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://medium.com/@caleb89taylor/coding-like-a-hacker-in-the-terminal-79e22954968e
# fo [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fo() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

. $HOME/.asdf/asdf.sh

export JAVA_HOME=$(/usr/libexec/java_home -v 11)

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/dswain/bin/terraform terraform

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dswain/Developer/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dswain/Developer/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dswain/Developer/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dswain/Developer/google-cloud-sdk/completion.zsh.inc'; fi

# direnv
if [ -f "${HOME}/bin/direnv" ]; then eval "$(direnv hook zsh)"; fi

export MYVIMRC="${HOME}/.config/nvim/init.vim"

if [ "${TERM_PROGRAM}" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ~/.dts.omp.json)"
fi

# zprof

