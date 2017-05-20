## Varnish

  A caching HTTP reverse proxy that can be found at https://www.varnish-cache.org/
It is primarily used for accelerating traffic from HTTP endpoint.

## About this plan
  This plan will provide a basic proxied/cache solution butvarnish is
highly configurable through VCL, the best way to fully support your configuration is to
import this plan and provide your own configuration.


### TODO
  Currently Sphinx is being installed via PIP during the installation hook, we should probably
add a Sphinx plan to core.

The plan currently builds varnish from source but one of the dependencies, Sphinx is being
installed in the prepare stage via `pip` and it should be moved to a core plan
