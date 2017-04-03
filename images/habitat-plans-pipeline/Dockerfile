FROM ubuntu:yakkety

RUN apt-get update && apt-get install -y curl

RUN curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | bash
RUN hab -V
RUN hab pkg install core/hab-pkg-dockerize

ENV DOCKER_VERSION=17.03.1
RUN curl -L https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz > /tmp/docker-${DOCKER_VERSION}.tgz \
      && cd /tmp/ && tar xfz /tmp/docker-${DOCKER_VERSION}.tgz \
      && mv /tmp/docker/docker /usr/local/bin/docker \
      && chmod +x /usr/local/bin/docker

COPY docker.sh /helpers/
