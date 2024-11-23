cmake_minimum_required(VERSION 3.25)
message(STATUS "CMAKE VERSION:${CMAKE_VERSION}")

if(NOT DEFINED SKBUILD_PROJECT_NAME)
  set(SKBUILD_PROJECT_NAME _core)
  set(SKBUILD_PROJECT_VERSION 0.0.0)
endif()

message(
  STATUS
    "Building CMake project ${SKBUILD_PROJECT_NAME} ${SKBUILD_PROJECT_VERSION}")

# Project settings
project(
  ${SKBUILD_PROJECT_NAME}
  VERSION ${SKBUILD_PROJECT_VERSION}
  LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD
    20
    CACHE STRING "C++ standard")
set(CMAKE_CXX_STANDARD_REQUIRED
    ON
    CACHE BOOL "C++ standard required")
set(CMAKE_CXX_EXTENSIONS
    OFF
    CACHE BOOL "C++ extensions")

find_program(cppcheck NAMES "cppcheck" "cppcheck.exe")

install(PROGRAMS ${cppcheck} DESTINATION ${SKBUILD_PROJECT_NAME}/Cppcheck)
install(DIRECTORY ${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/share/Cppcheck
        DESTINATION ${SKBUILD_PROJECT_NAME})
