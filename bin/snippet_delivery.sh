checkError() {
    local check_arg=$1
    local fail_message=$2

    if [ "$check_arg" -ne "0" ]; then
	echo "$fail_message"
	exit $check_arg
    fi

    return $check_arg
}

# Get the $SNIPPET_DIR and the shell name
initialize() {
    loadConfig Darwin var/macosx_var.sh \
	|| loadConfig Linux var/linux_var.sh \
	|| exit 1
}

loadConfig() {
    local keyword=$1
    local config_path=$2

    if uname -a | grep $keyword > /dev/null
    then
	. $config_path
	return 0
    fi
    return 1
}

doMain() {
    echo "Start to install snippet."
    cp ../snippet/* "$SNIPPET_DIR"
    checkError $? "Cannot copy file to $SNIPPET_DIR"
    echo "Setup finished successfully."
    ls -l "$SNIPPET_DIR"
}

initialize
doMain

exit 0
