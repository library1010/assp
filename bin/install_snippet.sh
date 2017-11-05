. config.sh

doMain() {
    echo "Start to install snippet."
    cp ../snippet/* "$SNIPPET_DIR"
    checkError $? "Cannot copy file to $SNIPPET_DIR"
    echo "Setup finished successfully."
    ls -l "$SNIPPET_DIR"
}

doMain
