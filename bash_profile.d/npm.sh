################################################################################
#                                                                              #
#                             #   #  ####   #   #                              #
#                             ##  #  #   #  ## ##                              #
#                             # # #  ####   # # #                              #
#                             #  ##  #      #   #                              #
#                             #   #  #      #   #                              #
#                                                                              #
################################################################################
#
# Dependencies: homebin

# If npm is installed
if $(which -s npm); then
	if [[ -z "$USER_PREFIX" ]]; then
		# If NPM isn't configured
		if [[ ! -e "${HOME}/.npmrc" ]]; then
			# Luckily npm will create this for us
			\npm config set prefix "$HOME/.npm"
		else
			# Since npm is so damn slow we avoid calling it altogether and
			# grabbing the prefix out of ~/.npmrc ourselves
			# NPM_PREFIX=$(\npm config get prefix)
			NPM_PREFIX=$(grep prefix "$HOME/.npmrc" | sed 's/^\s*prefix\s*=\s*//')
		fi
	else
		# If NPM isn't configured
		if [[ ! -e "$HOME/.npmrc" ]]; then
			# Luckily npm will create this for us
			\npm config set prefix "$USER_PREFIX"
		# else
			# Since npm is so damn slow we avoid calling it altogether and
			# grabbing the prefix out of ~/.npmrc ourselves
		fi
	fi

	if [[ -n "$USER_PREFIX_BIN" ]]; then
		NPM_PREFIX_BIN="$USER_PREFIX_BIN"
	else
		NPM_PREFIX_BIN="${NPM_PREFIX}/bin"
	fi

	# Regarding argument to grep: since ? is not a character that needs
	# escaping, "\?" is interpreted literally, so double backslashes are not
	# needed here.
	if [[ -n "$PATH" && -z $(echo $PATH | grep ":${NPM_PREFIX_BIN}:\?") && \
	      -n "${NPM_PREFIX_BIN}" && -d "${NPM_PREFIX_BIN}" ]]; then

		PATH="${PATH}:${NPM_PREFIX_BIN}"

		EXPORTS+=("PATH")
	fi
fi

# If nvm is installed but not configured
if [ -d "${HOME}/.nvm" ] && [ -f "${HOME}/.nvm/nvm.sh" ] && [[ $(type -t nvm >/dev/null) ]]; then
	NVM_DIR="${HOME}/.nvm"

	NVM_DIR=$NVM_DIR . ${HOME}/.nvm/nvm.sh

	EXPORTS+=("NVM_DIR")
fi
