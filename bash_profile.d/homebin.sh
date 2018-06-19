################################################################################
#                                                                              #
#                #   #   ###   #   #  #####  ####   #####  #   #               #
#                #   #  #   #  ## ##  #      #   #    #    ##  #               #
#                #####  #   #  # # #  ####   ####     #    # # #               #
#                #   #  #   #  #   #  #      #   #    #    #  ##               #
#                #   #   ###   #   #  #####  ####   #####  #   #               #
#                                                                              #
################################################################################
#
# Dependencies: None

# Create the user's personal bin directory if it doesn't yet exist
if [[ -z "$USER_PREFIX" ]]; then
	USER_PREFIX="$HOME"
fi

USER_PREFIX_BIN="$USER_PREFIX/bin"
USER_PREFIX_LIB="$USER_PREFIX/lib"

mkdir -p "$USER_PREFIX_BIN"

PATH+=":$USER_PREFIX_BIN"

# We export $PATH immediately because some configs use `which -s <command>` to
# determine whether to run or not
export PATH
