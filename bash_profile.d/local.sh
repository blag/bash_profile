################################################################################
#                                                                              #
#                       #       ###    ####    #    #                          #
#                       #      #   #  #       # #   #                          #
#                       #      #   #  #      #####  #                          #
#                       #      #   #  #      #   #  #                          #
#                       #####   ###    ####  #   #  #####                      #
#                                                                              #
################################################################################
#
# Dependencies: homebin


LOCAL_DIR="${HOME}/.local"

if [[ ! $(echo $PATH | grep -q ":${LOCAL_DIR}/bin:\?" ) ]]; then
	PATH="${PATH}:${LOCAL_DIR}/bin"
fi

EXPORTS+=("LOCAL_DIR" "PATH")