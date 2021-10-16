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
	POWERLINE_SHELL_EXEC="${LOCAL_DIR}/bin/powerline-shell.py"
elif which -s powerline-go 1>/dev/null; then
	POWERLINE_SHELL_EXEC=$(which powerline-go)
fi

if [[ -n "$POWERLINE_SHELL_EXEC" ]]; then
	if [[ -z "$POWERLINE_SHELL_MODE" ]]; then
		POWERLINE_SHELL_MODE=flat
	fi

	function _update_ps1() {
		PS1="$(${POWERLINE_SHELL_EXEC} --mode ${POWERLINE_SHELL_MODE} \
			                           --error $? \
			                           --jobs $(jobs -p | wc -l) \
			                           2>${LOG_FILE})"

		# Uncomment the following line to automatically clear errors after showing
		# them once. This not only clears the error for powerline-go, but also for
		# everything else you run in that shell. Don't enable this if you're not
		# sure this is what you want.

		#set "?"
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
