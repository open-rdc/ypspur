find_library(YPSPUR_LIBRARIES
    NAMES ypspur
    HINTS ${YPSPUR_LIBDIR} ${YPSPUR_LIBRARY_DIRS})

find_path(YPSPUR_INCLUDE_DIRS
    NAMES ypspur.h)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(YPSpur DEFAULT_MSG
                                  YPSPUR_LIBRARIES
                                  YPSPUR_INCLUDE_DIRS)

mark_as_advanced(YPSPUR_INCLUDE_DIR YPSPUR_CLIENT_LIBRARY YPSPUR_COMMON_LIBRARY)

