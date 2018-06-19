Config scripts that are added here will be automatically sourced by the Bash profile script.

Any config scripts or config script directories that begin with `__` (double underscores) are ignored by Git.

Any scripts that should be run on a per-OS basis should be created in a named directory:

```
python.sh       - common config script
python/osx.sh   - OS X config script
python/linux.sh - Linux config script
```

These OS-specific config scripts will be automatically sourced before the common config script.
