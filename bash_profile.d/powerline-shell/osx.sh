

POWERLINE_SHELL_MODE=compatible

# See the comment to:
# https://stackoverflow.com/questions/91368/checking-from-shell-script-if-a-directory-contains-files/91558#91558
FONTS=$(shopt -s nullglob dotglob; echo ${HOME}/Library/Fonts/* 2>/dev/null)

if [[ "${#FONTS}" -gt 0 ]]; then
	POWERLINE_SHELL_MODE=patched
fi
