FROM ubuntu:yakkety

RUN apt-get update && apt-get install -y curl

RUN curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | bash

RUN hab -V

RUN hab pkg install core/hab-pkg-dockerize
