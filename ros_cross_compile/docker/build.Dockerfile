FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --no-install-recommends -y \
  build-essential \
  cmake \
  python3-pip \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install --no-install-recommends -y \
  gcc-aarch64-linux-gnu \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install colcon-common-extensions colcon-mixin

COPY build_workspace.sh /root
COPY mixins/ /mixins/
COPY toolchains/ /toolchains/
WORKDIR /ros_ws
ENTRYPOINT ["/root/build_workspace.sh"]
