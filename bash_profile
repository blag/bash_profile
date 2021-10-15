################################################################################
#                                                                              #
#                          #####   ###   ####    ###                           #
#                            #    #   #  #   #  #   #                          #
#                            #    #   #  #   #  #   #                          #
#                            #    #   #  #   #  #   #                          #
#                            #     ###   ####    ###                           #
#                                                                              #
################################################################################

# * Add dependency handling for configuration subdirectories
# * Make sure all paths in $PATH exist and if not, remove them
# * Figure out where Python versions are installed on Linux
# * Install powerline-shell
#   git clone https://github.com/milkbikis/powerline-shell
#   cd powerline-shell/
#   cp config.py.dist config.py
#   /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl config.py
#   python install.py
#   ln -s ~/powerline-shell/powerline-shell.py ~/bin/powerline-shell.py
#   git clone https://github.com/powerline/fonts.git
#   cd fonts
#   ./install.sh
#   cd ..
# * Add warnings for things that aren't installed
#   - Powerline-shell
#   - Powerline-fonts
# * After installing Powerline-shell fonts, check that the iTerm 2 config is
#   using a patched font for non-ASCII characters
#   - See: https://github.com/powerline/fonts/issues/44
# * pip
#   - sudo easy_install pip
# * virtualenvwrapper
#   - pip install --user virtualenvwrapper
# * Check out https://github.com/alebcay/awesome-shell for more cool projects

# We split up the $PATH to make it easier to read and reason about.
#
# Be very careful about modifying the piped commands. One wrong move and you
# will have a bad day.
#
# We hard code the paths to grep, sed, tr, and uniq just in case we mess up
# $PATH.
#
# The uniq at the end is probably useless, but we keep it just in case
# somebody isn't as tidy as they should be.
GREP=$(which grep)
SED=$(which sed)
TR=$(which tr)
UNIQ=$(which uniq)
PATH=$(echo "
/bin
/sbin
/usr/bin
/usr/sbin
/opt/local/bin
/opt/local/sbin
/usr/local/bin
/usr/local/sbin" \
| $TR '\n' ':' \
| $GREP -v '^$' \
| $SED 's/:*$//' \
| $SED 's/^:*//' \
| $UNIQ)

# Get the OS we're on
KERNEL=$(uname)
if [[ "${KERNEL}" == "Darwin" ]]; then
	OS="osx"
elif [[ "${KERNEL}" == "Linux" ]]; then
	OS="linux"
else
	OS=$(echo "${KERNEL}" | tr '[:upper:]' '[:lower:]')
fi

# Convert PROFILE_DEBUG from a string to an array of strings
PROFILE_DEBUG=($(echo $PROFILE_DEBUG | ${TR} ' ' '\n'))

if [[ "${#PROFILE_DEBUG}" -gt 0 ]]; then
	echo "Debugging profile"
	LOG_FILE=/dev/stderr
else
	LOG_FILE=/dev/null
fi

if [[ -n "$BASH" && $(basename "$BASH") = "bash" ]]; then
	PROFILE_SHELL=bash
elif [[ -n "$ZSH_NAME" && "$ZSH_NAME" = "zsh" ]]; then
	PROFILE_SHELL=zsh
fi

# -F  - Display a slash after directories, a star after executables, an at-sign
#       after symlinks, an equals sign after sockets, a percent sign after each
#       whiteout, and a vertical bar after FIFOs
# -l  - List in long format
# -a  - Show hidden files
# -s  - 
# -h  - Show file sizes in human-readable prefixes (eg: KB, MB, GB, TB, EB, ZB)
DEFAULT_LS_ARGUMENTS="Flash"

# Disable virtualenv because it's slow and we don't need it yet
DISABLED_CONFIGS=( virtualenv homebin "$OS" )

USER_PREFIX="$HOME/.local"

# Global variables for all configs
# Any variables named in this array will be exported after all configs have run
EXPORTS=()

source $HOME/.bash_profile.d/$OS.sh
source $HOME/.bash_profile.d/homebin.sh

SYSTEM_BASH_COMPLETION_FILE=/usr/local/etc/bash_completion
SYSTEM_BASH_COMPLETION_DIR=/usr/local/etc/bash_completion.d



# Look for configs
CONFIGS=()
for config in $(find $HOME/.bash_profile.d/ -type f -depth 1 -name '*.sh' | grep -v '.DS_Store'); do
	CONFIGS+=($(basename $config | sed 's/.sh$//'))
done

# Remove disabled configs from found configs
for disabled_config in "${DISABLED_CONFIGS[@]}"; do
	for i in "${!CONFIGS[@]}"; do
		if [[ ${CONFIGS[i]} = "${disabled_config}" ]]; then
			unset 'CONFIGS[i]'
		fi
	done
done



# Source all found configs (except for disabled ones)
for config in ${CONFIGS[@]}; do
	# Source OS-specific configs first
	# These are usually used to set OS-specific search directories (see
	# Python's config) or global variables
	if [ -d "$HOME/.bash_profile.d/$config" ] && [ -x "$HOME/.bash_profile.d/$config/$OS.sh" ]; then
		source "$HOME/.bash_profile.d/$config/$OS.sh"
	fi

	# Source the main config after
	# This is used to set specific 
	if [ -x "$HOME/.bash_profile.d/$config.sh" ]; then
		source "$HOME/.bash_profile.d/$config.sh"
	fi
done



# Uniqify PATH so each config doesn't have to do it individually
# https://unix.stackexchange.com/a/11941
PATH=$(echo $PATH | tr ':' '\n' | awk '!seen[$0]++' | tr '\n' ':' | sed 's/:$//')



# We do this here to make sure it happens after its dependencies
for export in "${EXPORTS[@]}"; do
	export "$export"
done



# Activate bash completion itself
# Theoretically these shouldn't need to export anything
if [ -f "${SYSTEM_BASH_COMPLETION_FILE}" ]; then
	source "${SYSTEM_BASH_COMPLETION_FILE}"
fi
