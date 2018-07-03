

if [[ -e "$USER_PREFIX_BIN/direnv.darwin-amd64" ]]; then
    if [[ ! "$USER_PREFIX_BIN/direnv" ]]; then
        ln -s "$USER_PREFIX_BIN/direnv.darwin-amd64" "$USER_PREFIX_BIN/direnv"
    fi

    if [[ ! -x "$USER_PREFIX_BIN/direnv" ]]; then
        chmod u+x "$USER_PREFIX_BIN/direnv"
    fi

    DIRENV_EXEC="$USER_PREFIX_BIN/direnv"
fi
