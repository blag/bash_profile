# The Bash profile to end all other Bash profiles



## Outline ##

* [Rationale](#rationale)
* [Overview](#overview)
* [Installation](#installation)
* [Quick Howto](#quick-howto)
* [Authoring your own config or alias](#authoring-your-own-config-or-alias)
* [Complaints](#complaints)



## Rationale ##

Are you sick of seeing things like this in your Bash profile?

```bash
# MacPorts Installer addition on 2013-01-30_at_00:59:21: adding an appropriate PATH variable for use with MacPorts.
if [[ -z $(echo ${PATH} | tr ':' '\n' | egrep '(^|:)/opt/local/bin') ]]; then
    export PATH+=":/opt/local/bin"
fi
if [[ -z $(echo ${PATH} | tr ':' '\n' | egrep '(^|:)/opt/local/sbin') ]]; then
    export PATH+=":/opt/local/sbin"
fi
# Finished adapting your PATH environment variable for use with MacPorts.

if [[ -z $(echo ${PATH} | tr ':' '\n' | egrep '(^|:)/usr/local/bin') ]]; then
    export PATH="/usr/local/bin:${PATH}"
fi
if [[ -z $(echo ${PATH} | tr ':' '\n' | egrep '(^|:)/usr/local/sbin') ]]; then
    export PATH="/usr/local/sbin:${PATH}"
fi
# Finished adapting your PATH environment variable for use with MacPorts.

### Added by the Heroku Toolbelt
if [[ -z $(echo ${PATH} | tr ':' '\n' | egrep '(^|:)/usr/local/heroku/bin') ]]; then
    export PATH="/usr/local/heroku/bin:${PATH}"
fi

# Setting PATH for Python 3.4
# The orginal version is saved in .profile.pysave
if [[ -z $(echo ${PATH} | tr ':' '\n' | egrep '(^|:)/Library/Frameworks/Python.framework/Versions/3.4/bin') ]]; then
    export PATH+=":/Library/Frameworks/Python.framework/Versions/3.4/bin"
fi

# Setting PATH for Python 3.5
# The orginal version is saved in .profile.pysave
if [[ -z $(echo ${PATH} | tr ':' '\n' | egrep '(^|:)/Library/Frameworks/Python.framework/Versions/3.5/bin') ]]; then
    export PATH+=":/Library/Frameworks/Python.framework/Versions/3.5/bin"
fi

# Setting PATH for Python 3.5
# The original version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

# Setting PATH for Python 3.6
# The original version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
```

I am too.

The "modern" approach to profile management is brittle, difficult to extend, leaves garbage behind when you uninstall applications like MacPorts, the Heroku toolbelt, and Python versions. It's not composable, and it's very difficult for installers to detect that their application is in the `PATH` or not.

Furthermore, with applications like DiffMerge and Sublime, after the user installs them, they have to perform additional configuration, like setting the Git diff and merge tools, setting the `EDITOR` environment variable, etc.

This Bash profile is a better, cleaner, easily extensible method to profile management.



## Overview ##

This Bash profile:

* is portable - you can use the same repository across Mac OS X, Linux, and other Unixes (no idea about Windows support though)
* is composable - you can add/remove and enable/disable configurations without ever modifying the main bash profile script
* is automatic - once you uninstall an application, it will pick up the installation and remove it from your `PATH`
* comes with superpowers - if you install, say, Python on Mac OS X with an official installer, it will pick it up automatically and add it to your path for all future sessions (or once you source your Bash profile again), without having to modify anything
* is version controlled with Git - you can spin up a development environment or a new computer with a few simple, well known commands
* is on GitHub - you can easily submit a pull request to have your changes merged in to upstream
* respects your (or your employer's) privacy - you can create new "config" or alias scripts that are automatically ignored by Git (just prefix the config script or alias script with a double underscore `__`)



## Installation ##

1. Clone the repository into your home directory:
   ```bash
   cd $HOME
   git clone https://github.com/blag/bash_profile.git
   ```
2. Backup your existing profile
   ```bash
   mv $HOME/.profile $HOME/.profile.bak  # Mac OS X
   mv $HOME/.bash_profile $HOME/.bash_profile.bak  # Linux
   ```
3. Symlink `$HOME/.profile` (Mac) or `$HOME/.bash_profile` (Linux) and `$HOME/.bash_profile.d`
   ```bash
   ln -s $HOME/bash_profile/bash_profile $HOME/.profile 
   ln -s $HOME/bash_profile/bash_profile.d $HOME/.bash_profile.d
   ```
4. OPTIONAL: Enable aliases
   ```bash
   ln -s $HOME/bash_profile/aliases.d $HOME/.aliases.d
   ```
5. OPTIONAL: Enable tab-tab completions
   ```bash
   ln -s $HOME/bash_profile/bash_completion $HOME/.bash_completion
   ln -s $HOME/bash_profile/bash_completion.d $HOME/.bash_completion.d
   ```
6. Re-source your Bash profile
   ```bash
   source $HOME/.profile  # Mac OS X
   source $HOME/.bash_profile  # Linux
   ```

Done!



## Quick Howto ##

### Add a config ###

Add a `.sh` script to `$HOME/bash_profile/bash_profile.d`


### Add an OS-specific part to a config ###

1. 
   ```bash
   mkdir $HOME/bash_profile.d/<config>
   ```
2. Add a script file to the config directory
   ```bash
   touch $HOME/bash_profile.d/$(OS).sh
   ```

If you prefix the file with a "dunderscore" (`__`) it will be ignored from Git. Use this for configs that contain secret, private, or proprietary information.


### Enable a config ###

```bash
enable_config <config>
```


### Disable a config ###

```bash
disable_config <config>
```


### Remove a config ###

```bash
rm $HOME/bash_profile.d/<config>.sh
rm -rf $HOME/bash_profile.d/<config>
```


### Add an alias ###

Add a `.sh` script to `$HOME/bash_profile/aliases.d`

If you prefix the file with a "dunderscore" (`__`) it will be ignored from Git. Use this for aliases that contain secret, private, or proprietary information.


### Enable an alias ###

```bash
enable_alias <alias>
```

or

```bash
chmod +x $HOME/bash_profile/aliases.d/<alias>.sh
```


### Disable an alias ###

```bash
disable_alias <alias>
```

or

```bash
chmod -x $HOME/bash_profile/aliases.d/<alias>.sh
```


### Remove an alias ###

```bash
rm $HOME/bash_profile/aliases.d/<alias>.sh
```



## Authoring your own config or alias ##

Creating your own config is really easy - just drop a script file into `$HOME/bash_profile/bash_profile.d/`, make sure it's executable, then re-source your profile.

If one OS is different than others (like OS X), you can add OS-specific scripts into `$HOME/bash_profile/bash_profile.d/<config>/<os>.sh`. The appropriate OS-specific script will automatically be sourced **before** the common config script. This is most useful when you are just setting paths, or performing a minumum number of operations. Don't overdo it - you should do as much of the processing as you can in the common script, even if it's for an application that only runs on one OS (example: DiffMerge).

Creating your own alias is done in a similar fashion - just drop a alias script file into `$HOME/.aliases.d/`, make sure it's executable, then re-source your profile.


### Add a directory to the `PATH` ###

```bash
PATH+=":<directory>"
```

You do NOT need to manually export `PATH`, that will be done automatically for you.


### Export a variable ###

```bash
EXPORTS+=('<variable_name>')
```


### How to write a good config ###

#### Be lazy - don't do anything if you don't have to ####

While this Bash profile comes with superpowers, configs don't do anything if they detect that their application isn't installed.

##### Example: the DiffMerge config #####

The [DiffMerge config](bash_profile.d/diffmerge.sh) checks that DiffMerge is installed, and simply skips doing anything if it isn't:

```bash
DIFFMERGE_PATH="/Applications/DiffMerge.app"
DIFFMERGE_EXE="${DIFFMERGE_PATH}/Contents/MacOS/DiffMerge"

if [[ -d "$DIFFMERGE_PATH" ]]; then
    # Only configure things if DiffMerge is actually installed
    ...
fi
```

#### Be lazy - you don't always have to add your application to the `PATH` ####

##### Example: the Sublime config #####

Sublime on OS X installs (by default) into `/Applications/Sublime Text.app/Contents/SharedSupport`. The space in the path can trigger bugs in some implmentations, so instead of blindly adding that to `PATH`, [the Sublime config](bash_profile.d/sublime.sh) simply creates a symlink in the user's home `bin` directory (usually `$HOME/.local/bin`), and that is added to the `PATH`.

```bash
SUBLIME_COMMAND="${SUBLIME_INSTALL_DIR}/bin/subl"
SUBLIME_SYMLINK="$USER_PREFIX_BIN/subl"
if [[ -x "$SUBLIME_INSTALL_DIR" ]]; then
    # Check for the subl command and symlink it
    ...
fi
```

#### Be helpful - play nicely with other applications ####

This can be interpreted to mean: don't override the user's existing configurations.

Some configs can be helpful and modify the config files of unrelated applications. In this case, first check that the user hasn't already configured the relevant options differently.

If the user has already configured that option: don't modify the user's configuration.

But if the user hasn't set that option yet, they probably want it to be set automatically for them.

##### Example: the DiffMerge config #####

For instance, the DiffMerge config sets Git's config to use it, but only if the user has not yet set it:

```bash
if [[ -d "$DIFFMERGE_PATH" ]]; then
    # If it exists, and git isn't configured, then configure git to use it
    if [[ -x "$USER_PREFIX_BIN/diffmerge" ]]; then
        if [[ "$(git config --global diff.tool)" == "" ]]; then
            ...
        fi

        if [[ "$(git config --global merge.tool)" == "" ]]; then
            ...
        fi
    fi
fi
```

#### Be lazy - use OS-specific scripts minimally ####

Scripts that are specific to individual OSes are automatically run before the "main" config script. This is done to alleviate a bunch of branching on OS in the main config script.

However, you don't want to put a whole lot of logic into the OS-specific scripts, because then you have to write them all over again.

##### Example: the Python config #####

The [Python script for OS X](bash_profile.d/python/osx.sh) only sets the searchable paths:

```bash
PYTHON_VERSIONS_DIRS=("$HOME/Library/Python" "/Library/Frameworks/Python.framework/Versions")
```

The [main Python script](bash_profile.d/python.sh) does the heavy lifting - adding all Python versions to the `PATH`:

```bash
for PYTHON_VERSIONS_DIR in "${PYTHON_VERSIONS_DIRS[@]}"; do
    for i in $(find ${PYTHON_VERSIONS_DIR} -type d -depth 1); do
        # Add each found Python to the PATH
        ...
    done
done
```

##### Example: the DiffMerge config #####

Some configs only make sense for certain operating systems. In this case, it's sufficient to check that the configured application is installed. You do NOT need to put all configuration into an OS-specific script:

```bash
DIFFMERGE_PATH="/Applications/DiffMerge.app"
DIFFMERGE_EXE="${DIFFMERGE_PATH}/Contents/MacOS/DiffMerge"

if [[ -d "$DIFFMERGE_PATH" ]]; then
    ...
fi
```

#### Be kind - clean up after yourself ####

Sometimes users uninstall applications, and those applications do not need to be in the `PATH` anymore. If you detect that an application no longer exists on the system, either skip any further configuration, or remove any permanent changes you have made.

##### Example: the Sublime config #####

The [Sublime config](bash_profile.d/sublime.sh) installs a symlink into the user's home bin directory (usually `$HOME/.local/bin`) instead of modifying the `PATH`. But when Sublime is uninstalled, the config removes the symlink:

```bash
SUBLIME_COMMAND="${SUBLIME_INSTALL_DIR}/bin/subl"
SUBLIME_SYMLINK="$USER_PREFIX_BIN/subl"
if [[ -x "$SUBLIME_INSTALL_DIR" ]]; then
    ...
else
    # If the user removed Sublime for some reason

    # Remove the symlink
    ...
fi
```

#### Be bold - use logic in your alias scripts ####

The alias scripts aren't special, they are only executed after everything else. And they are executed - using `source` from within `$HOME/bash_profile` - so you can use logic here if you need it.



## Complaints ##

### This is over-engineered ###

Maybe. But it pays itself off pretty quickly.


### This is slow ###

Yep. Takes a few seconds to run on my 6+ year old laptop. That's the price you pay for doing things the way they should have been done in the first place.

But, seriously, why do you care? This code is only run when you launch a new interactive terminal and when you manually `source $HOME/.bash_profile`. It's not run all the time.

It's loading a lot of files from the disk, whether or not they do something. And the more configs that get added the slower it will become (luckily linear time though).

If you *really* think this code needs to be high performance, I'm happy to hear why you think that. And if you have ideas on how to improve the speed, I'm happy to review your pull request/s.
