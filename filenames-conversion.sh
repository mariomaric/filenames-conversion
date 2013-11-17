#!/bin/bash
# Info: https://github.com/mariomaric/filenames-conversion#readme



# Check if arguments are provided
if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ]
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
printf "Match files with \"%s\" pattern and replace \"%s\" with \"%s\" string in filename.\n" \
    "$pattern" "$out" "$in" 1>&2



# Do the work
for file in $(find . -iname "$pattern" -exec basename {} \;);
do
   newfile="$(echo "$file" | sed -e "s/$out/$in/")"
   mv "$file" "$newfile"
   printf "%s > %s\n" "$file" "$newfile" 1>&2
done

exit 0
