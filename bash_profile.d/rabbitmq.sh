################################################################################
#                                                                              #
#            ####     #    ####   ####   #####  #####  #   #   ###             #
#            #   #   # #   #   #  #   #    #      #    ## ##  #   #            #
#            ####   #####  ####   ####     #      #    # # #  #   #            #
#            #  #   #   #  #   #  #   #    #      #    #   #  #  ##            #
#            #   #  #   #  ####   ####   #####    #    #   #   ####            #
#                                                                              #
################################################################################
#
# Dependencies: None


if [[ -n "${RABBITMQ_DIR}" && -d "${RABBITMQ_DIR}" ]]; then
	if [[ ! $(grep -q ":${RABBITMQ_DIR}/bin:\?" <(echo $PATH) ) ]]; then
		PATH="${PATH}:${RABBITMQ_DIR}/bin"
	fi

	if [[ ! $(grep -q ":${RABBITMQ_DIR}/sbin:\?" <(echo $PATH) ) ]]; then
		PATH="${PATH}:${RABBITMQ_DIR}/sbin"
	fi

	EXPORTS+=("PATH")
fi
