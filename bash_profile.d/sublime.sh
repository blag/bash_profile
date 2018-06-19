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

SUBLIME_COMMAND="${SUBLIME_INSTALL_DIR}/bin/subl"
SUBLIME_SYMLINK="$USER_PREFIX_BIN/subl"
if [[ -x "$SUBLIME_INSTALL_DIR" ]]; then
	# Check for the subl command and symlink it
	if [[ -x "$SUBLIME_COMMAND" && ! -e "$USER_PREFIX_BIN/subl" ]]; then
		ln -s "$SUBLIME_COMMAND" "$SUBLIME_SYMLINK"
		chmod +x "$SUBLIME_SYMLINK"
	fi

	EDITOR="subl -n -w"

	EXPORTS+=("EDITOR")
else
	# If the user removed Sublime for some reason

	# Remove the symlink
	if [[ -L "$SUBLIME_SYMLINK" ]]; then
		rm "$SUBLIME_SYMLINK"
	fi

	# Unset EDITOR
	if [[ "$EDITOR" == subl* ]]; then
		EDITOR=
	fi

	EXPORTS+=("EDITOR")
fi
