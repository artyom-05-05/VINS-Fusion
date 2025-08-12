#!/bin/bash 
xhost +local:docker

IMAGE_NAME="vins-noetic"
CONTAINER_NAME="vins-mono-noetic-container"

docker run -it \
    --name "${CONTAINER_NAME}" \
    --net=host \
    --gpus all \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --device /dev/dri \
    "${IMAGE_NAME}" \
    bash

# docker build -t vins-noetic .

# mkdir src/VINS-Fusion/datasets && cd src/VINS-Fusion/datasets
# wget http://robotics.ethz.ch/~asl-datasets/ijrr_euroc_mav_dataset/machine_hall/MH_01_easy/MH_01_easy.bag

# rosrun vins vins_node /catkin_ws/src/VINS-Fusion/config/euroc/euroc_mono_imu_config.yaml
# rosrun loop_fusion loop_fusion_node /catkin_ws/src/VINS-Fusion/config/euroc/euroc_mono_imu_config.yaml

# rosbag play src/VINS-Fusion/datasets/MH_01_easy.bag