. config.sh

insertEntries() {
    local keyword=$1
    local keybinding=$2
    local filename=$3
    
    grep $keyword "$filename" > /dev/null || insertEntry $keyword $keybinding "$filename"
}

insertEntry() {
    local keyword=$1
    local keybinding=$2
    local filename=$3

    sed -i.bak "s/^\]$/\t{\"keys\": [\"$keybinding\"], \"command\": \"$keyword\" },/" "$filename" && rm "$filename.bak"
    checkError $? "Cannot change the file $filename using sed"
    echo "" >> "$filename"
    echo "]" >> "$filename"
    checkError $? "Cannot append the file $filename"
    sed -i.bak "/^\s*$/d" "$filename" && rm "$filename.bak"
    checkError $? "Cannot change the file $filename using sed"
    return 0
}

installMacOsEntries() {
    insertEntries add_date "super+shift+," "$KEYMAP_FILE"
    insertEntries today "super+shift+." "$KEYMAP_FILE"
}

installLinuxEntries() {
    insertEntries add_date "ctrl+shift+," "$KEYMAP_FILE"
    insertEntries today "ctrl+shift+." "$KEYMAP_FILE"
}

doMain() {
    (checkOs Darwin && installMacOsEntries) \
	|| (checkOs Linux && installLinuxEntries) \
	|| exit 1
    cat "$KEYMAP_FILE"
}
doMain
