# 通用脚本开头

``` shell
# Check Root
[ $(id -u) != "0" ] && RED "Error: You must be root to run this script" && exit 1

# Script Path
export BASEPATH=`dirname $(readlink -f ${BASH_SOURCE[0]})` && cd $BASEPATH

# Time
export TIME=`date  +%Y%m%d_%H%M`

# Information Notify
function info() {
  (>&2 echo -e "[\e[34m\e[1mINFO\e[0m] $*")
}

function error() {
  (>&2 echo -e "[\e[33m\e[1mERROR\e[0m] $*")
}

function ok() {
  (>&2 echo -e "[\e[32m\e[1m OK \e[0m] $*")
}

# LogFile
function log() {
  (>&2 echo `date +"%Y-%m-%d %H:%M:%S"`'  '"$@" >>"$BASEPATH"'/update.log')
}

# Color Fonts
function GREEN() {
echo -e "\033[32m $@ \033[0m"
}
function GREENF() {
echo -en "\033[32m $@ \033[0m"
}
function RED() {
echo -e "\033[31m $@ \033[0m"
}
function REDF() {
echo -en "\033[31m $@ \033[0m"
}

function print_delim() {
  echo '============================'
}
```

