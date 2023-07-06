#!/bin/bash

EDITED_FILE_DIR="/usr/edited_file_list"
DATE_TIME=$(date +"%d_%m_%Y-%H_%M_%S")


# Loop over the flags and handel each one
# The shift at the end help us move from one flag/arg to the next
while getopts "hp:" opt; do
    case $opt in
        p) FOLDER_PATH="$OPTARG"
        ;;
        h) echo "Script to add the file name in each file in a given folder.
        -p: the path of the folder in which we will add file name at the end of each file.
        
        The output of the script is a new line at the end of each file (from path)
        and a new file under 'edited_file_list' folder, that contain all the files name that we edited."
        exit 0
        ;;
        ?) echo "Invalid flag -$OPTARG" >&2
        exit 1
        ;;
        :) echo "$0: Error: option -${OPTARG} requires an argument" >&2; 
        exit 1;;
    esac
done
shift $((OPTIND-1))

# Check if the folder path exists
if [ ! -d "$FOLDER_PATH" ]; then
    echo "Folder path does not exist: $FOLDER_PATH"
    exit 1
fi

# Stored all the files name that was edited.
if [ ! -d $EDITED_FILE_DIR ]; then 
    mkdir $EDITED_FILE_DIR
fi

cd $FOLDER_PATH

# For each file in $FOLDER_PATH we will add its name (including extentions)
# Then we will stored all the files name that was edited in $EDITED_FILE_DIR
for file in *; do
    if [[ -f $file ]]; then
        FILE_NAME="$(basename -- $file)"
        echo $FILE_NAME >> $$FILE_NAME
        echo $FOLDER_PATH/$FILE_NAME >> $EDITED_FILE_DIR/$DATE_TIME.txt
    fi
done