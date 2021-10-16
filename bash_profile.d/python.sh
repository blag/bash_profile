################################################################################
#                                                                              #
#                   ####   #   #  #####  #   #   ###   #   #                   #
#                   #   #   # #     #    #   #  #   #  ##  #                   #
#                   ####     #      #    #####  #   #  # # #                   #
#                   #        #      #    #   #  #   #  #  ##                   #
#                   #        #      #    #   #   ###   #   #                   #
#                                                                              #
################################################################################
#
# Dependencies: None


FOUND_PYTHON_VERSIONS=()
for PYTHON_VERSIONS_DIR in "${PYTHON_VERSIONS_DIRS[@]}"; do
	if [[ -d "$PYTHON_VERSIONS_DIR" ]]; then
		# # Setting PATH for Python 3.6
		# Loop through all installed versions of Python
		for i in $(find ${PYTHON_VERSIONS_DIR} -type d -depth 1 | sort --version-sort); do
			PYTHON_VERSION=${i#"$PYTHON_VERSIONS_DIR/"}

			# Skip versions we've already found
			SKIP=
			for V in "${FOUND_PYTHON_VERSIONS[@]}"; do
				if [[ "$PYTHON_VERSION" == "$V" ]]; then
					SKIP=true
				fi
			done
			if [[ -n "$SKIP" ]]; then
				continue
			fi

			if [[ ! $(grep -q ":${PYTHON_VERSIONS_DIR}/${PYTHON_VERSION}/bin:\?" <(echo $PATH) ) ]]; then
				PATH="${PATH}:${PYTHON_VERSIONS_DIR}/${PYTHON_VERSION}/bin"

				EXPORTS+=("PATH")
			fi

			# Save Python versions we've found so far
			FOUND_PYTHON_VERSIONS+=($PYTHON_VERSION)
		done
	fi
done
