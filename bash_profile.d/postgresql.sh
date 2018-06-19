################################################################################
#                                                                              #
#     ####    ###    ####  #####   ####  ####   #####   ####   ###   #         #
#     #   #  #   #  #        #    #      #   #  #      #      #   #  #         #
#     ####   #   #   ###     #    #  ##  ####   ####    ###   #   #  #         #
#     #      #   #      #    #    #   #  #  #   #          #  #  ##  #         #
#     #       ###   ####     #     ###   #   #  #####  ####    ###   #####     #
#                                                                              #
################################################################################
#
# Dependencies: None


if [[ -n "${POSTGRES_APP}" && -d "${POSTGRES_APP}/Contents/Versions/latest" ]]; then
	if [[ ! $(grep -q ":${POSTGRES_APP}/Contents/Versions/latest/bin:\?" <(echo $PATH) ) ]]; then
		PATH="${PATH}:${POSTGRES_APP}/Contents/Versions/latest/bin"
	fi

	EXPORTS+=("PATH")
fi
