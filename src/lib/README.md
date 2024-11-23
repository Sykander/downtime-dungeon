# Lib

This is where we store our gvars we import inside of commands and other gvars.

All files here should start with a comment listing the gvar ids for each environment.

```
# Development
# <GVAR_ID>
# Production
# <GVAR_ID>
```

# Legacy GVARS

Some Gvars only list one id at the top of the file, this means that the same gvar is currently used on all environments.

If you should update this gvar you will need to update it to have a development and production version in the environments.
