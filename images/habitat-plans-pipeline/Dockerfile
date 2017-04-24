FROM ubuntu:yakkety

RUN apt-get update && apt-get install -y curl iptables

RUN curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | bash
RUN hab -V
RUN hab pkg install core/hab-pkg-dockerize

RUN hab pkg install core/docker && \
      hab pkg binlink core/docker docker && \
      hab pkg binlink core/docker dockerd && \
      hab pkg binlink core/docker docker-containerd && \
      hab pkg binlink core/docker docker-init && \
      hab pkg binlink core/docker docker-runc

COPY start_docker /bin/
