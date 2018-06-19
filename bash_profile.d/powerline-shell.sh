################################################################################
#                                                                              #
#         ####    ###   #   #  #####  ####   #      #####  #   #  #####        #
#         #   #  #   #  #   #  #      #   #  #        #    ##  #  #            #
#         ####   #   #  # # #  ####   ####   #        #    # # #  ####         #
#         #      #   #  ## ##  #      #  #   #        #    #  ##  #            #
#         #       ###   #   #  #####  #   #  #####  #####  #   #  #####        #
#                                                                              #
################################################################################
#
# Dependencies: direnv, local

if [[ -x "${LOCAL_DIR}/bin/powerline-shell.py" ]]; then
	if [[ -z "$POWERLINE_SHELL_MODE" ]]; then
		POWERLINE_SHELL_MODE=flat
	fi

	function _update_ps1() {
		PS1="$(${LOCAL_DIR}/bin/powerline-shell.py --mode ${POWERLINE_SHELL_MODE} $? 2>${LOG_FILE})"
	}

	# We intentionally do not enclose the not comparison in quotes - we are
	# doing a startswith test.
	# See:
	# https://stackoverflow.com/questions/2172352/in-bash-how-can-i-check-if-a-string-begins-with-some-value/2172367
	# if [[ "${TERM}" != "linux" &&
	if [[ "$PROMPT_COMMAND" != *_update_ps1* ]]; then
		PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"

		EXPORTS+=("PROMPT_COMMAND")
	fi
fi
