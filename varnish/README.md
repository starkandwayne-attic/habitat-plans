## Varnish

A caching HTTP reverse proxy that can be found at https://www.varnish-cache.org/
It is primarily used for accelerating traffic from HTTP endpoints.

### TODO

The plan currently builds varnish from source but one of the dependencies Sphinx is being
installed in the prepare stage via `pip` and it should be moved to a core plan

The plan starts varnish but not cleanly, we need to adjust the config file as the default
config is currently being used without any interpolation from the TOML file. 
