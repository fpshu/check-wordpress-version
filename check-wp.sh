#!/bin/bash
# check worpdress version
#########################

# no arguments, exit
if [ $# == 0 ]; then
    echo "No path given!"
    exit
else
    where=$1
    latest=`curl https://develop.svn.wordpress.org/tags/ 2>/dev/null | grep li | tail -n+2 | cut -d'"' -f 2 | cut -d'/' -f 1 | sort -g | tail -n 1`
    echo "Latest wordpress version: $latest"
    for line in $(find $where -regextype posix-extended -regex '(.*)wp-includes\/version.php'); do
        current=`cat $line | grep '^$wp_version' | cut -d"'" -f 2`
        if [ "$latest" != "$current" ]; then
            echo "UPDATE NEEDED! Current version is: $current , DocRoot is: ${line%wp-includes/version.php}"
        fi
    done
fi
