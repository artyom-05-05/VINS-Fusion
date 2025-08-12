#!/bin/bash 
xhost +local:docker

docker run -it \
    --name vins-mono \
    --net=host \
    --gpus all \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --device /dev/dri \
    vins-mono \
    bash

# docker build -t vins-mono .

# wget http://robotics.ethz.ch/~asl-datasets/ijrr_euroc_mav_dataset/machine_hall/MH_01_easy/MH_01_easy.bag

# rosrun vins vins_node /catkin_ws/src/VINS-Fusion/config/euroc/euroc_mono_imu_config.yaml
# rosrun loop_fusion loop_fusion_node /catkin_ws/src/VINS-Fusion/config/euroc/euroc_mono_imu_config.yaml

# rosbag play src/VINS-Fusion/datasets/MH_01_easy.bag