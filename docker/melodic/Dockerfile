FROM osrf/ros:melodic-desktop-full

# Install dependencies for RViz, Ceres, and VINS-Fusion
RUN apt-get update && apt-get install -y \
    wget \
    mesa-utils \
    libgl1-mesa-glx \
    libceres-dev \
    ros-melodic-cv-bridge \
    ros-melodic-image-transport \
    ros-melodic-tf \
    ros-melodic-message-filters \
    ros-melodic-pcl-ros \
    ros-melodic-pcl-conversions \
    ros-melodic-camera-info-manager \
    ros-melodic-roscpp \
    ros-melodic-sensor-msgs \
    ros-melodic-std-msgs \
    ros-melodic-nav-msgs \
    ros-melodic-geometry-msgs \
    ros-melodic-visualization-msgs \
    && rm -rf /var/lib/apt/lists/*

# Set up Catkin workspace
RUN mkdir -p /catkin_ws/src
WORKDIR /catkin_ws/src

# Clone VINS-Fusion
RUN git clone https://github.com/HKUST-Aerial-Robotics/VINS-Fusion.git

# Build workspace
WORKDIR /catkin_ws
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash && catkin_make -j$(nproc)"

# Add ROS sourcing to .bashrc
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

# Beautiful terminal
RUN echo "PS1='\e[92m\u\e[0m@\e[94m\h\e[0m:\e[35m\w\e[0m# '" >> /root/.bashrc
