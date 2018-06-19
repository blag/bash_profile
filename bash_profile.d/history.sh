################################################################################
#                                                                              #
#                #   #  #####   ####  #####   ###   ####   #   #               #
#                #   #    #    #        #    #   #  #   #   # #                #
#                #####    #     ###     #    #   #  ####     #                 #
#                #   #    #        #    #    #   #  #  #     #                 #
#                #   #  #####  ####     #     ###   #   #    #                 #
#                                                                              #
################################################################################
#
# Dependencies: None


if [[ -z "$HISTCONTROL" ]]; then
	HISTORY_IGNORE=ignoreboth
	# ignorespace - Ignore lines that begin with space
	# ignoredups  - Ignore duplicate lines
	# ignoreboth  - Ignore both lines that begin with a space and duplicates
	# erasedups   - Remove all previous duplicate lines from history
	HISTORY_ERASE=
fi

if [[ ! -z "$HISTORY_IGNORE" && ! -z "$HISTORY_ERASE" ]]; then
	HISTCONTROL=$HISTORY_IGNORE:$HISTORY_ERASE
elif [[ ! -z "$HISTORY_IGNORE" ]]; then
	HISTCONTROL=$HISTORY_IGNORE
elif [[ ! -z "$HISTORY_ERASE" ]]; then
	HISTCONTROL=$HISTORY_ERASE
fi

EXPORTS+=("HISTCONTROL")
