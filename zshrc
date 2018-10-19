#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# OS-dependent config
if [[ `uname` == 'Darwin' ]]
then
  chruby_root=/usr/local/opt/chruby/share
  z_root=`brew --prefix`/etc/profile.d
  
  # Haskell/cabal
  if [[ -d ${HOME}/Library/Haskell/bin ]]
  then
    export PATH=${HOME}/Library/Haskell/bin:${PATH}
  fi
else
  chruby_root=/usr/local/share
  z_root=${HOME}/.zcommand
fi

test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex" && kiex default 1.6.4

# kerl erlang version
export ERLANG_INSTALL=${HOME}/bin/r17p1
if [[ -e ${ERLANG_INSTALL}/activate ]]
then
  source ${ERLANG_INSTALL}/activate
fi

# Anaconda
#export ANACONDA_ROOT=${HOME}/anaconda
#if [[ -d ${ANACONDA_ROOT}/bin ]]
#then
#  export PATH=${ANACONDA_ROOT}/bin:$PATH
#fi

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

# Customize to your needs...

# chruby
chruby=${chruby_root}/chruby/chruby.sh
if [[ -e ${chruby} ]]
then
  source ${chruby}
  source ${chruby_root}/chruby/auto.sh
  chruby ruby-2.3
fi

# don't autocorrect 'gem'
alias gem='nocorrect gem'

# always launch emacs in 256-color terminal mode
alias emacs='TERM=xterm-256color emacs -nw'

# for great z
z_cmd=${z_root}/z.sh
if [[ -e ${z_cmd} ]]
then
  source ${z_root}/z.sh
fi

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

# added by travis gem
[ -f /Users/dswain/.travis/travis.sh ] && source /Users/dswain/.travis/travis.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://medium.com/@caleb89taylor/coding-like-a-hacker-in-the-terminal-79e22954968e
# fo [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fo() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
