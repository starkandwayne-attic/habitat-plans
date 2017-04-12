# Stark & Wayne habitat plans

This repository contains habitat plans that are supported by Stark & Wayne

## Building plans

To build a plan locally (eg. Redis) run:
```
$ hab pkg build redis
```

this will build your package and put the output into the results dir:

```
$ ll results
total 1152
drwxr-xr-x   5 jcarter  staff     170 Apr 12 12:00 .
drwxr-xr-x  17 jcarter  staff     578 Apr 12 11:59 ..
-rw-r--r--   1 jcarter  staff     367 Apr 12 12:00 last_build.env
drwxr-xr-x   3 jcarter  staff     102 Apr 12 11:59 logs
-rw-r--r--   1 jcarter  staff  582034 Apr 12 12:00 starkandwayne-redis-3.2.8-20170412082113-x86_64-linux.hart
```

You can also build from within the context of the `hab studio` (a shell environment for quickly iterating plans).

```
$ hab studio enter
[1][default:/src:0]# build redis
```

this has the same effect as `hab pkg build redis` (that command creates an on the fly studio to build the pkg and then exists).

## Export to docker

If you have build your package in the studio and remain in the context you can export your pkg to docker via:

```
[2][default:/src:130]# hab pkg export docker starkandwayne/redis
```

This will export the latest version of starkandwayne/redis to docker (if you have just build one it will use the local version).
On the host you can see the result:

```
$ docker images
REPOSITORY                                  TAG                     IMAGE ID            CREATED             SIZE
starkandwayne/redis                         latest                  7f9496bb6bba        13 seconds ago      165 MB
starkandwayne/redis                         3.2.8-20170412082113    7f9496bb6bba        About a minute ago   165 MB
```

## Via pipeline

Instead of building and exporting the images manually you can also use https://ci.starkandwayne.com/teams/main/pipelines/habitat-plans to help you with your workflow.
When you have decided on a version of `plan.sh` file you like commit and push it to origin. This will trigger a build of the plan and make the image available via
```
$ docker pull starkandwayne/redis:edge
```

If you have added a new plan you will need to run `ci/repipe` to update the pipeline.

## Testing

Many of the plans are testable via [delmo](https://github.com/bodymindarts/delmo). You can run the tests via:
```
$ delmo -f redis/tests/delmo.yml
```

The tests will run against the latest image build by the pipeine (`starkandwayne/redis:edge`). When a file `<pkg>/tests/delmo.yml` is found the same tests will also be run in the pipeline.
