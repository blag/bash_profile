################################################################################
#                                                                              #
#                   ####    ###   #####  #####  ####   #   #                   #
#                   #   #  #   #  #        #    #   #   # #                    #
#                   ####   #   #  ####     #    ####     #                     #
#                   #      #   #  #        #    #  #     #                     #
#                   #       ###   #####    #    #   #    #                     #
#                                                                              #
################################################################################
#
# Dependencies: None


POETRY_BIN_DIR="${HOME}/.poetry/bin"

if which -s poetry 1>/dev/null; then
	if [[ ! $(echo $PATH | grep -q ":${POETRY_BIN_DIR}:\?" ) ]]; then
		PATH="${PATH}:${POETRY_BIN_DIR}"
	fi

	EXPORTS+=("PATH")
fi
