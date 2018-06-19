################################################################################
#                                                                              #
#                  #    #      #####    #     ####  #####   ####               #
#                 # #   #        #     # #   #      #      #                   #
#                #####  #        #    #####   ###   ####    ###                #
#                #   #  #        #    #   #      #  #          #               #
#                #   #  #####  #####  #   #  ####   #####  ####                #
#                                                                              #
################################################################################
#
# Dependencies: None

if [[ -d "$HOME/.aliases.d" ]]; then
	for alias_file in $HOME/.aliases.d/*.sh; do
		# https://stackoverflow.com/a/43606356
		if [[ -x "$alias_file" ]]; then
			source "$alias_file"
		else
			continue
		fi
	done
fi
