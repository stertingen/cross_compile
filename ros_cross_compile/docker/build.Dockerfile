FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive

# Common for all
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    cmake \
    python3-pip \
    wget \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install colcon-common-extensions colcon-mixin

# Specific at the end (layer sharing)
RUN apt-get update && apt-get install --no-install-recommends -y \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
  && rm -rf /var/lib/apt/lists/*

# Fast an small, no optimization necessary
COPY build_workspace.sh /root
COPY mixins/ /mixins/
COPY toolchains/ /toolchains/
WORKDIR /ros_ws
ENTRYPOINT ["/root/build_workspace.sh"]
