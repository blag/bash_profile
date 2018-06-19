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

if [[ ! $(which -s direnv) ]]; then
	eval "$(direnv hook bash)"

	EXPORTS+=("PROMPT_COMMAND")
fi