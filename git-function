function git() {

  if [[ "$1" = "init" ]] # ask for email after init
  then
    /usr/local/bin/git $@
    git-email-prompt.sh
  elif [[ "$1" = "clone" ]] # ask for email after clone
  then
    /usr/local/bin/git $@
    if [[ "$3" = "" ]] # no directory given, extract from repo name
    then
      cd $(echo $2 | awk -F/ '{ print $NF }' | rev | sed 's/tig.//' | rev)
    else
      cd $3
    fi
    git-email-prompt.sh
  else
    /usr/local/bin/git $@
  fi
}