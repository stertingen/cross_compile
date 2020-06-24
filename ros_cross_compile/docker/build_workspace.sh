#!/bin/bash
set -euxo pipefail

# Ensure these exist so that we can use them
# (it is possible the workspace has no ROS dependencies, so these wouldn't have been created)
mkdir -p /opt/ros/"${ROS_DISTRO}"
touch /opt/ros/"${ROS_DISTRO}"/setup.bash

set +ux
# shellcheck source=/dev/null
source /opt/ros/"${ROS_DISTRO}"/setup.bash
set -ux

export SYSROOT=/cc_sysroot
export ROS_WS_INSTALL_PATH=/ros_ws/install_aarch64
colcon build \
  --build-base build_"${TARGET_ARCH}" \
  --install-base install_"${TARGET_ARCH}" \
  --cmake-args -DCMAKE_TOOLCHAIN_FILE=/toolchains/aarch64-gnu.cmake --no-warn-unused-cli

chown -R "${OWNER_USER}" .
