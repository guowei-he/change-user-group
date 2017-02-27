#!/bin/bash
#
# This small tool changes the primary group of the users
#
# Usage:
#   1. Users stored in a text file. In this case only 1 arguement is passed to the script.
#      ./change-user-group.sh <user-list>
#
#      Format in <user-list>:
#        cgsb user1 user2
#
#   2. Users from command-line. In this case more than 1 arguments are passed to the script.
#      ./change-user-group.sh <account> <username>...
#


change-user-group() {

        echo "Processing acct=$1 user=$2"

        acct=$1
        user=$2

        usermod -g ${acct} ${user}
}

#--------------------------------------------------
#--------------------------------------------------


parse-args() {
        if (( $# == 0 )); then
                return
        fi

        acct=$1
        shift

        while (( $# > 0 )); do
                echo $acct $1
                change-user-group $acct $1
                shift
        done
}

parse-all() {
        # take input from stdin
        echo "Parsing input..."

        while read ans; do
                parse-args $ans
        done
}

#==================================================
#==================================================

if (( $# == 1)) && [[ x"$1" == x"all" ]]; then
        parse-all
else
        parse-args $*
fi

