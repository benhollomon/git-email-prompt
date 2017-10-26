#!/bin/bash

function git() {

     for i do
          lastArgument=$i # last argument can be the directory or the repository url
     done

     /usr/bin/git "$@"

     if [[ $? -eq 0 ]] # only show prompt if git command was successful
     then
          if [[ "$1" = "init" || "$1" = "clone" ]]
          then
               if [[ -d "$lastArgument" ]]
               then
                    # it was the directory argument, cd it
                    cd $lastArgument
               else
                    # no directory given, parse it from repository url
                    cd $(echo $lastArgument | awk -F/ '{ print $NF }' | rev | sed 's/tig.//' | rev)
               fi
               git-email-prompt.sh
          fi
     else
          # return the exit code of the failed git command call
          return $?
     fi
}
