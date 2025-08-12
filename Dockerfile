# Use ROS Noetic (Ubuntu 20.04) as base image
FROM osrf/ros:noetic-desktop-full

ENV DEBIAN_FRONTEND=noninteractive
ENV LIBGL_ALWAYS_SOFTWARE=1
ENV DISABLE_ROS1_EOL_WARNINGS=1
ENV XDG_RUNTIME_DIR=/tmp/runtime-root

# Basic utilities + dependencies for RViz, Ceres and typical ROS packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    git \
    build-essential \
    python3-pip \
    python3-rosdep \
    python3-rosinstall \
    python3-vcstool \
    mesa-utils \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    libceres-dev \
    && rm -rf /var/lib/apt/lists/*

# Install ROS Noetic package dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-noetic-cv-bridge \
    ros-noetic-image-transport \
    ros-noetic-tf \
    ros-noetic-message-filters \
    ros-noetic-pcl-ros \
    ros-noetic-pcl-conversions \
    ros-noetic-camera-info-manager \
    ros-noetic-roscpp \
    ros-noetic-sensor-msgs \
    ros-noetic-std-msgs \
    ros-noetic-nav-msgs \
    ros-noetic-geometry-msgs \
    ros-noetic-visualization-msgs \
    && rm -rf /var/lib/apt/lists/*

# Initialize rosdep
RUN rosdep init || true
RUN rosdep update

# Set up Catkin workspace
RUN mkdir -p /catkin_ws/src
WORKDIR /catkin_ws/src

# Clone VINS-Fusion
RUN git clone https://github.com/rkuo2000/VINS-Fusion/

# Build workspace
WORKDIR /catkin_ws
RUN /bin/bash -lc "source /opt/ros/noetic/setup.bash && catkin_make -j\$(nproc)"

# Add ROS sourcing to .bashrc
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

# Beautiful terminal
RUN echo "PS1='\e[92m\u\e[0m@\e[94m\h\e[0m:\e[35m\w\e[0m# '" >> /root/.bashrc

# Default entry
CMD ["/bin/bash"]
