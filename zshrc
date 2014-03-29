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
else
  chruby_root=/usr/local/share
  z_root=${HOME}/.z
fi


# Customize to your needs...

# chruby
chruby=${chruby_root}/chruby/chruby.sh
if [[ -e ${chruby} ]]
then
  source ${chruby}
  chruby ruby-1.9.3
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