# `*.conf.mk` & the rest:

Any makefile here ending in `conf.mk` should only define environment variables.
All rules should be defined in files not ending in `conf.mk`; with the exception of `config.mk` which 
is the root configuration file of the rest of the `conf.mk` files.