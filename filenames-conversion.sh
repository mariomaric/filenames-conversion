#!/bin/bash
# Info: https://github.com/mariomaric/filenames-conversion#readme



# Check if arguments are provided
if [ -z "$1" -o -z "$2" -o -z "$3" ]
then
    echo "Please provide arguments."
    echo "Info: https://github.com/mariomaric/filenames-conversion#readme"
    exit 1
else
    # Initialize main parameters 
    pattern="$1"
    out="$2"
    in="$3"
fi



# Set up inital parameters

# http://www.dwheeler.com/essays/filenames-in-shell.html
IFS="$(printf '\n\t')"

# Log
printf "\n%s\n============================\n" "$(date)" 1>&2
if [ -z "$4" ]
then
    printf "=   S I M U L A T I O N    =\n============================\n" 1>&2
fi
printf "# Match files with \"%s\" pattern and replace \"%s\" with \"%s\" string in filename.\n" \
    "$pattern" "$out" "$in" 1>&2



# Do the work
for file in $(find . -iname "$pattern" -exec basename {} \;);
do
    # Conversion
    newfile="$(echo "$file" | sed -e "s/$out/$in/")"
    if [ ! -z "$4" -a "$file" != "$newfile" ]
    then
        mv "$file" "$newfile"
    fi

    # Log
    if [ "$file" == "$newfile" ]
    then
        printf "Same filename: %s\n" "$file" 1>&2
    else
        printf "%s > %s\n" "$file" "$newfile" 1>&2
    fi
done

exit 0
