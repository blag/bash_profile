
# https://stackoverflow.com/a/42466441

# Explanation
# Each alias defines a function, "__f", that manipulates an argument or
# iterates through a list of arguments
# Within the function, the actual work is done, and then the function is unset
# to cleanup the global namespace again.
# After the function is defined, it is called, and the arguments are passed to
# it

alias  enable_config='__f() { chmod +x "$HOME/.bash_profile.d/$1.sh"; chmod +x "$HOME/.bash_profile.d/$1/*.sh" 2>/dev/null; unset -f __f; }; __f'
alias disable_config='__f() { chmod -x "$HOME/.bash_profile.d/$1.sh"; chmod -x "$HOME/.bash_profile.d/$1/*.sh" 2>/dev/null; unset -f __f; }; __f'

alias  enable_configs='__f() { for arg in $@; do  enable_alias $arg; done; unset -f __f; }; __f'
alias disable_configs='__f() { for arg in $@; do disable_alias $arg; done; unset -f __f; }; __f'
