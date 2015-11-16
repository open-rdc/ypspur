cmake_minimum_required(VERSION 2.8.3)
project(ypspur)

find_package(catkin REQUIRED)

include(ExternalProject)

message("CMAKE_DEVEL_PREFIX: ${CMAKE_DEVEL_PREFIX}")
message("CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")
message("CMAKE_PREFIX_PATH: ${CMAKE_PREFIX_PATH}")

set(BUILD_USER $ENV{USER} CACHE STRING "")
message("BUILD_USER: " ${BUILD_USER})

unset(SU)
if(BUILD_USER)
    set(SU ${CMAKE_SOURCE_DIR}/su ${BUILD_USER})
endif()

execute_process(COMMAND
    git config --global http.sslVerify false
)

ExternalProject_Add(${PROJECT_NAME}
    PREFIX ""
    GIT_REPOSITORY https://openspur.org/repos/yp-spur.git
    CONFIGURE_COMMAND ${SU} ${CMAKE_COMMAND} <SOURCE_DIR>/configure --prefix=${CMAKE_INSTALL_PREFIX}
    BUILD_COMMAND ${SU} make
    INSTALL_DIR ${CATKIN_DEVEL_PREFIX}
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CATKIN_DEVEL_PREFIX}
)

#ExternalProject_Get_Property(${PROJECT_NAME} binary_dir)

catkin_package()
