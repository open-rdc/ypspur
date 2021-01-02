cmake_minimum_required(VERSION 2.8.3)
project(ypspur)

include(ExternalProject)

message("CMAKE_DEVEL_PREFIX: ${CMAKE_DEVEL_PREFIX}")
message("CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")
message("CMAKE_PREFIX_PATH: ${CMAKE_PREFIX_PATH}")

ExternalProject_Add(${PROJECT_NAME}
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/ypspur
    SOURCE_DIR ${CMAKE_SOURCE_DIR}
    #GIT_REPOSITORY https://github.com/DaikiMaekawa/ypspur
    CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=${CMAKE_INSTALL_PREFIX}
    BUILD_COMMAND $(MAKE)
    INSTALL_DIR ${CATKIN_INSTALL_PREFIX}
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CATKIN_INSTALL_PREFIX}
)

ExternalProject_Get_Property(${PROJECT_NAME} binary_dir)

add_custom_target(${PROJECT_NAME}-ins
    DEPENDS ${PROJECT_NAME}
    COMMAND echo DESTDIR IS $(DESTDIR) && $(MAKE) -C ${binary_dir} install
    COMMENT Performing ins step for '${PROJECT_NAME}'
)

install(CODE "execute_process(COMMAND \"${CMAKE_COMMAND}\" --build \"${CMAKE_BINARY_DIR}\" --target ${PROJECT_NAME}-ins)")
install(FILES package.xml DESTINATION share/${PROJECT_NAME}/)
install(FILES cmake/ypspurConfig.cmake DESTINATION share/${PROJECT_NAME}/cmake/)
