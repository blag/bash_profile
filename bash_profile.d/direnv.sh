################################################################################
#                                                                              #
#                   ####   #####  ####   #####  #   #  #   #                   #
#                   #   #    #    #   #  #      ##  #  #   #                   #
#                   #   #    #    ####   ####   # # #  #   #                   #
#                   #   #    #    #  #   #      #  ##   # #                    #
#                   ####   #####  #   #  #####  #   #    #                     #
#                                                                              #
################################################################################
#
# Dependencies: homebin

if [[ -z "$DIRENV_EXEC" ]]; then
	DIRENV_EXEC=$(which direnv 2>/dev/null)
fi

if [[ -n "$DIRENV_EXEC" ]]; then
	eval "$($DIRENV_EXEC hook $PROFILE_SHELL)"

	EXPORTS+=("PROMPT_COMMAND")
fi
