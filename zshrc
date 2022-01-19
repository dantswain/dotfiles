# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#

# zmodload zsh/zprof

# Path to your oh-my-zsh installation.
export ZSH="/Users/dswain/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="af-magic"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git asdf fzf docker-compose docker gcloud gitfast gnu-utils golang gradle)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

######################################################################
# non-oh-my-zsh

setopt share_history

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

# zprof

