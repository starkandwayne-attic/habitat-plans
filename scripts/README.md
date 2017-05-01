# Alternative entrypoint

the script `scripts/hab_entry.sh` can be used to pass individual configuration settings into a habitat service started in docker via environment variables.

Eg: instead of needing to:
```
export HAB_REDIS='password = "hello"'
```

by using this script as an alternative entrypoint you can set either of:
```
export HAB_REDIS_PASSWORD='hello'
export REDIS_PASSWORD='hello'
```

to have the same result.

Try it by running:
```
$ docker run --name redis \
  -e HAB_REDIS_PASSWORD=hello \
  -e REDIS_PORT=5555 \
  --volume $PWD/scripts:/scripts \
  --entrypoint /scripts/hab_entry.sh \
  starkandwayne/redis start starkandwayne/redis
```

And then you can see that it worked by:
```
$ docker exec redis redis-cli -p 5555 -a hello SET hello world
OK
$ docker exec redis redis-cli -p 5555 -a hello GET hello
world
```
