################################################################################
#                                                                              #
#                       #####  #####  #####  ####   #   #                      #
#                         #      #    #      #   #  ## ##                      #
#                         #      #    ####   ####   # # #                      #
#                         #      #    #      #  #   #   #                      #
#                       #####    #    #####  #   #  #   #                      #
#                                                                              #
################################################################################
#
# Dependencies: homebin, direnv, powerline

ITERM_INTEGRATION_BIN="$USER_PREFIX_BIN/iterm2_shell_integration.$PROFILE_SHELL"

if [[ -n "$ITERM_SHELL_INTEGRATION" || -x "$ITERM_INTEGRATION_BIN" ]]; then
	# If we're running iTerm 2
	if [[ -n "$TERM_PROGRAM" && "$TERM_PROGRAM" == "iTerm.app" ]]; then
		# Download the integration file if we don't have it yet
		if [[ ! -x "$ITERM_INTEGRATION_BIN" ]]; then
			curl -L "https://iterm2.com/misc/${PROFILE_SHELL}_startup.in" -o "$ITERM_INTEGRATION_BIN"
		fi

		# Run the integration file
		source "$ITERM_INTEGRATION_BIN"
	fi
fi

# Make alt+backspace and option+backspace act like Bash
# This effectively makes ZSH stop on directory separators and not just
# whitespace
if [[ "$PROFILE_SHELL" = "zsh" ]]; then
	autoload -U select-word-style
	select-word-style bash
fi
