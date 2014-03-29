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

# Customize to your needs...

# chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
chruby ruby-1.9.3

# don't autocorrect 'gem'
alias gem='nocorrect gem'

# always launch emacs in 256-color terminal mode
alias emacs='TERM=xterm-256color emacs -nw'

# for great z
. `brew --prefix`/etc/profile.d/z.sh