FROM ubuntu:yakkety

RUN apt-get update && apt-get install -y curl iptables

RUN curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | bash
RUN hab -V
RUN hab pkg install core/hab-pkg-dockerize

RUN hab pkg install starkandwayne/docker && \
      hab pkg binlink starkandwayne/docker docker && \
      hab pkg binlink starkandwayne/docker dockerd && \
      hab pkg binlink starkandwayne/docker docker-containerd && \
      hab pkg binlink starkandwayne/docker docker-init && \
      hab pkg binlink starkandwayne/docker docker-runc
