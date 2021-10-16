

POWERLINE_SHELL_MODE=compatible

if [[ "$PROFILE_SHELL" = "zsh" ]]; then
	FONTS=()
	for font in ${HOME}/Library/Fonts/*; do
		FONTS+=(font)
	done
elif [[ "$PROFILE_SHELL" = "bash" ]]; then
	# See the comment to:
	# https://stackoverflow.com/questions/91368/checking-from-shell-script-if-a-directory-contains-files/91558#91558
	FONTS=$(shopt -s nullglob dotglob; echo ${HOME}/Library/Fonts/* 2>/dev/null)
fi

if [[ "${#FONTS}" -gt 0 ]]; then
	POWERLINE_SHELL_MODE=patched
fi
