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
initialized() {
    { checkOs Darwin && . var/macosx_var.sh; } \
	|| { checkOs Linux && . var/linux_var.sh; } \
	|| exit 1
}

checkOs() {
    local keyword=$1
    local config_path=$2
    uname -a | grep $keyword > /dev/null
    return $?
}

initialized
