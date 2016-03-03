#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
# Modified by:
#   Guillem Palou
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

autoload -Uz promptinit
promptinit
prompt damoekri

# Customize to your needs...
export PATH=/usr/local/anaconda/bin/:$PATH
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export SPARK_HOME=/usr/local/Cellar/apache-spark/1.5.1/libexec
export PYSPARK_SUBMIT_ARGS='--master local[2] pyspark-shell'
bindkey "^R" history-incremental-search-backward


# useful aliases
