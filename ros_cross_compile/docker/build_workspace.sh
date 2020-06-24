#!/bin/bash
set -euxo pipefail

export SYSROOT=/ros_ws/cc_internals/sysroot
export ROS_WS_INSTALL_PATH=/ros_ws/install_${TARGET_ARCH}
export ROS_WS_BUILD_PATH=/ros_ws/build_${TARGET_ARCH}

set +ux
source ${SYSROOT}/opt/ros/foxy/setup.bash
set -ux

colcon build \
  --build-base ${ROS_WS_BUILD_PATH} \
  --install-base ${ROS_WS_INSTALL_PATH} \
  --event-handlers console_direct+ \
  --cmake-args -DCMAKE_TOOLCHAIN_FILE=/toolchains/${TARGET_ARCH}-gnu.cmake --no-warn-unused-cli

chown -R "${OWNER_USER}" .
