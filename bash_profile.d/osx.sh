################################################################################
#                                                                              #
#                               ###    ####  #   #                             #
#                              #   #  #       # #                              #
#                              #   #   ###     #                               #
#                              #   #      #   # #                              #
#                               ###   ####   #   #                             #
#                                                                              #
################################################################################
#
# Dependencies: None

# http://blog.dolphm.com/disable-mouse-pointer-acceleration-and-scroll-wheel-acceleration-in-os-x/
if [[ "$DISABLE_SCROLLWHEEL_ACCELERATION" ]]; then
	# This has an annoying habit of resetting every now and then, so we just
	# set it all the time
	defaults write .GlobalPreferences com.apple.scrollwheel.scaling -1
fi


COLOR_BLACK=a
COLOR_RED=b
COLOR_GREEN=c
COLOR_BROWN=d
COLOR_BLUE=e
COLOR_MAGENTA=f
COLOR_CYAN=g
COLOR_LIGHT_GRAY=h
COLOR_LIGHT_GREY=$COLOR_LIGHT_GRAY
COLOR_BLACK_BOLD=A
COLOR_RED_BOLD=B
COLOR_GREEN_BOLD=C
COLOR_BROWN_BOLD=D
COLOR_BLUE_BOLD=E
COLOR_MAGENTA_BOLD=F
COLOR_LIGHT_GRAY_BOLD=H
COLOR_LIGHT_GREY_BOLD=$COLOR_LIGHT_GRAY_BOLD
COLOR_DEFAULT=x

COLOR_FG_DIRECTORY="$COLOR_BLUE"
COLOR_BG_DIRECTORY="$COLOR_DEFAULT"
COLOR_FG_SYMBOLIC_LINK="$COLOR_MAGENTA"
COLOR_BG_SYMBOLIC_LINK="$COLOR_DEFAULT"
COLOR_FG_SOCKET="$COLOR_GREEN"
COLOR_BG_SOCKET="$COLOR_DEFAULT"
COLOR_FG_PIPE="$COLOR_BROWN"
COLOR_BG_PIPE="$COLOR_DEFAULT"
COLOR_FG_EXECUTABLE="$COLOR_GREEN"
COLOR_BG_EXECUTABLE="$COLOR_DEFAULT"
COLOR_FG_BLOCK_DEVICE="$COLOR_BLUE"
COLOR_BG_BLOCK_DEVICE="$COLOR_CYAN"
COLOR_FG_CHARACTER_DEVICE="$COLOR_BLUE"
COLOR_BG_CHARACTER_DEVICE="$COLOR_BROWN"
COLOR_FG_SETUID="$COLOR_BLACK"
COLOR_BG_SETUID="$COLOR_RED"
COLOR_FG_SETGID="$COLOR_BLACK"
COLOR_BG_SETGID="$COLOR_CYAN"
COLOR_FG_DIRECTORY_STICKY="$COLOR_BLACK"
COLOR_BG_DIRECTORY_STICKY="$COLOR_GREEN"
COLOR_FG_DIRECTORY_NONSTICKY="$COLOR_BLACK"
COLOR_BG_DIRECTORY_NONSTICKY="$COLOR_BROWN"



COLORS_DIRECTORY="$COLOR_FG_DIRECTORY$COLOR_BG_DIRECTORY"
COLORS_SYMBOLIC_LINK="$COLOR_FG_SYMBOLIC_LINK$COLOR_BG_SYMBOLIC_LINK"
COLORS_SOCKET="$COLOR_FG_SOCKET$COLOR_BG_SOCKET"
COLORS_PIPE="$COLOR_FG_PIPE$COLOR_BG_PIPE"
COLORS_EXECUTABLE="$COLOR_FG_EXECUTABLE$COLOR_BG_EXECUTABLE"
COLORS_BLOCK_DEVICE="$COLOR_FG_BLOCK_DEVICE$COLOR_BG_BLOCK_DEVICE"
COLORS_CHARACTER_DEVICE="$COLOR_FG_CHARACTER_DEVICE$COLOR_BG_CHARACTER_DEVICE"
COLORS_SETUID="$COLOR_FG_SETUID$COLOR_BG_SETUID"
COLORS_SETGID="$COLOR_FG_SETGID$COLOR_BG_SETGID"
COLORS_DIRECTORY_STICKY="$COLOR_FG_DIRECTORY_STICKY$COLOR_BG_DIRECTORY_STICKY"
COLORS_DIRECTORY_NONSTICKY="$COLOR_FG_DIRECTORY_NONSTICKY$COLOR_BG_DIRECTORY_NONSTICKY"



CLICOLOR=1
LSCOLORS_DEFAULT=exfxcxdxbxegedabagacad

LSCOLORS="
$COLORS_DIRECTORY
$COLORS_SYMBOLIC_LINK
$COLORS_SOCKET
$COLORS_PIPE
$COLORS_EXECUTABLE
$COLORS_BLOCK_DEVICE
$COLORS_CHARACTER_DEVICE
$COLORS_SETUID
$COLORS_SETGID
$COLORS_DIRECTORY_STICKY
$COLORS_DIRECTORY_NONSTICKY
"

# Remove all of those newlines
# https://stackoverflow.com/a/19347380
LSCOLORS="${LSCOLORS//[$'\t\r\n']}"

# Global variables for all configs
# Any variables named in this array will be exported after all configs have run
EXPORTS+=("CLICOLOR" "LSCOLORS")
