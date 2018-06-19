################################################################################
#                                                                              #
#         ####   #####  #####  #####  #   #  #####  ####    ###   #####        #
#         #   #    #    #      #      ## ##  #      #   #  #      #            #
#         #   #    #    ####   ####   # # #  ####   ####   #  ##  ####         #
#         #   #    #    #      #      #   #  #      #  #   #   #  #            #
#         ####   #####  #      #      #   #  #####  #   #   ###   #####        #
#                                                                              #
################################################################################
#
# Dependencies: homebin


DIFFMERGE_PATH="/Applications/DiffMerge.app"
DIFFMERGE_EXE="${DIFFMERGE_PATH}/Contents/MacOS/DiffMerge"

if [[ -d "$DIFFMERGE_PATH" ]]; then
	if [[ ! -f "$USER_PREFIX_BIN/diffmerge" ]]; then
		# Link it in
		ln -s "$DIFFMERGE_EXE" "$USER_PREFIX_BIN/diffmerge"
	fi

	# If it exists, and git isn't configured, then configure git to use it
	# TODO: Cleanup after ourselves if DiffMerge isn't installed but Git is
	#       still configured to use it
	if [[ -x "$USER_PREFIX_BIN/diffmerge" ]]; then
		# https://sourcegear.com/diffmerge/webhelp/sec__git__mac.html
		if [[ "$(git config --global diff.tool)" == "" ]]; then
			git config --global diff.tool diffmerge
			git config --global difftool.diffmerge.cmd \
			    "$DIFFMERGE_EXE \"\$LOCAL\" \"\$REMOTE\""
		fi

		if [[ "$(git config --global merge.tool)" == "" ]]; then
			git config --global merge.tool diffmerge
			git config --global mergetool.diffmerge.trustExitCode true
			git config --global mergetool.diffmerge.cmd \
			    "$DIFFMERGE_EXE --merge --result=\"\$MERGED\" \"\$LOCAL\" \"\$BASE\" \"\$REMOTE\""
		fi
	fi
fi
