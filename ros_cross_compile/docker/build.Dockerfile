FROM ubuntu:focal

RUN apt-get update && apt-get install --no-install-recommends -y \
  cmake \
  gcc-aarch64-linux-gnu \
  python3-pip \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install colcon-common-extensions colcon-mixin
