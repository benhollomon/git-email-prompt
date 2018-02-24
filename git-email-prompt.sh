#!/bin/bash

# bash prompt which asks for email address
# to configure for current git repository

# trim whitespace
trimws() {
     echo "$1" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
}

# set working directory variable
wd="$(dirname "$(readlink -f "$0")")"

# check for email file
if [[ -f "$wd/git_emails" ]]
then
     # set your available emails
     readarray -t MAILS < "$wd/git_emails"

     # prompt for email
     echo
     echo "Which email address should be configured for this repository?"
     echo
     echo "Press [Enter] to abort..."
     echo
     for ((i = 0; i < ${#MAILS[*]}; i++))
     do
          echo "$(tput bold)$(($i + 1))$(tput sgr 0): ${MAILS[$i]}"
     done
     echo
     echo -n "email: "
     read -n 1 email
     echo
     echo

     # abort when pressing enter
     if [[ "$email" == "" ]]
     then
          echo "$(tput setaf 3)abort$(tput sgr 0): No email set."
          exit 0
     fi

     # error if entered number is less than 1 or greater than size of emails
     if [[ $email -lt "1" || $email -gt ${#MAILS[*]} ]]
     then
          echo "$(tput setaf 1)error$(tput sgr 0): Unknown email $(tput bold)$email$(tput sgr 0)"
          exit 1
     fi

     # set email and name
     echo "Set '${MAILS[$(($email - 1))]}' as identity for this repository."
     readarray -t -d '-' MAIL <<< "${MAILS[$(($email - 1))]}"
     git config user.name "$(trimws "${MAIL[1]}")"
     git config user.email $(trimws "${MAIL[0]}")
else
     # email file is not available
     echo "Email file not available. Copy 'git_emails.example' to 'git_emails' and configure as necessary."
fi

exit 0

# EOF
