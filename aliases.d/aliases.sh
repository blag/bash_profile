
# https://stackoverflow.com/a/42466441

# Explanation
# Each alias defines a function, "__f", that manipulates an argument or
# iterates through a list of arguments
# Within the function, the actual work is done, and then the function is unset
# to cleanup the global namespace again.
# After the function is defined, it is called, and the arguments are passed to
# it

# TODO: Remove aliases from session when disabled

alias  enable_alias='__f() { chmod +x "$HOME/.aliases.d/$1.sh"; unset -f __f; }; __f'
alias disable_alias='__f() { chmod -x "$HOME/.aliases.d/$1.sh"; unset -f __f; }; __f'

alias  enable_aliases='__f() { for arg in $@; do  enable_alias $arg; done; unset -f __f; }; __f'
alias disable_aliases='__f() { for arg in $@; do disable_alias $arg; done; unset -f __f; }; __f'
