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

# custom bin path
export PATH=${PATH}:${HOME}/bin

# OS-dependent config
if [[ `uname` == 'Darwin' ]]
then
  chruby_root=/usr/local/opt/chruby/share
  z_root=`brew --prefix`/etc/profile.d
  
  # Haskell/cabal
  export PATH=${HOME}/Library/Haskell/bin:${PATH}
else
  chruby_root=/usr/local/share
  z_root=${HOME}/.zcommand
fi

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

# Customize to your needs...

# chruby
chruby=${chruby_root}/chruby/chruby.sh
if [[ -e ${chruby} ]]
then
  source ${chruby}
  source ${chruby_root}/chruby/auto.sh
  chruby ruby-2.2
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

export DATA_BAG_PATH=/Users/dswain/src/chef-repo/data_bags/

cd ${HOME}
