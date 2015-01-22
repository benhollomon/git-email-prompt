function git() {

  if [[ "$1" = "init" ]] # ask for identity after init
  then
    /usr/local/bin/git $@
    _gitIdentity
  elif [[ "$1" = "clone" ]] # ask for idenity after clone
  then
    for i do
      lastArgument=$i # last argument can be the directory or the repository url
    done
    /usr/local/bin/git $@
    if [[ -d "$lastArgument" ]]
    then
      # it was the directory argument, cd it
      cd $lastArgument
    else
      # no directory given, parse it from repository url
      cd $(echo $lastArgument | awk -F/ '{ print $NF }' | rev | sed 's/tig.//' | rev)
    fi
    _gitIdentity
  else
    /usr/local/bin/git $@
  fi
}