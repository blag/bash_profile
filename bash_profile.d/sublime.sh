################################################################################
#                                                                              #
#                 ####  #   #  ####   #      #####  #   #  #####               #
#                #      #   #  #   #  #        #    ## ##  #                   #
#                 ###   #   #  ####   #        #    # # #  ####                #
#                    #  #   #  #   #  #        #    #   #  #                   #
#                ####    ###   ####   #####  #####  #   #  #####               #
#                                                                              #
################################################################################
#
# Dependencies: homebin

SUBLIME_TEXT_COMMAND="${SUBLIME_TEXT_INSTALL_DIR}/bin/subl"
SUBLIME_TEXT_SYMLINK="$USER_PREFIX_BIN/subl"

if [[ -x "$SUBLIME_TEXT_INSTALL_DIR" ]]; then
	# Check for the subl command and symlink it
	if [[ -x "$SUBLIME_TEXT_COMMAND" && ! -e "$USER_PREFIX_BIN/subl" ]]; then
		ln -s "$SUBLIME_TEXT_COMMAND" "$SUBLIME_TEXT_SYMLINK"
		chmod +x "$SUBLIME_TEXT_SYMLINK"
	fi

	EDITOR="subl -n -w"

	EXPORTS+=("EDITOR")
else
	# If the user removed Sublime for some reason

	# Remove the symlink
	if [[ -L "$SUBLIME_TEXT_SYMLINK" ]]; then
		rm "$SUBLIME_TEXT_SYMLINK"
	fi

	# Unset EDITOR
	if [[ "$EDITOR" == subl* ]]; then
		EDITOR=
	fi

	EXPORTS+=("EDITOR")
fi

SUBLIME_MERGE_COMMAND="${SUBLIME_MERGE_INSTALL_DIR}/bin/smerge"
SUBLIME_MERGE_SYMLINK="$USER_PREFIX_BIN/smerge"

if [[ -x "$SUBLIME_MERGE_INSTALL_DIR" ]]; then
	# Check for the smerge command and symlink it
	if [[ -x "$SUBLIME_MERGE_COMMAND" && ! -e "$USER_PREFIX_BIN/smerge" ]]; then
		ln -s "$SUBLIME_MERGE_COMMAND" "$SUBLIME_MERGE_SYMLINK"
		chmod +x "$SUBLIME_MERGE_SYMLINK"
	fi

	EDITOR="smerge"

	EXPORTS+=("EDITOR")
else
	# If the user removed Sublime for some reason

	# Remove the symlink
	if [[ -L "$SUBLIME_MERGE_SYMLINK" ]]; then
		rm "$SUBLIME_MERGE_SYMLINK"
	fi

fi
