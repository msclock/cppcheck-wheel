cmake_minimum_required(VERSION 3.25)
message(STATUS "CMAKE VERSION:${CMAKE_VERSION}")

project(
  cppcheck
  LANGUAGES CXX C
  HOMEPAGE_URL "https://github.com/msclock/cppcheck-wheel"
  DESCRIPTION "Package cppcheck as a python wheel.")

# Project default module
find_package(cmake-modules REQUIRED)
include(cmake-modules/ProjectDefault)

find_program(cppcheck NAMES "cppcheck" "cppcheck.exe")
cmake_path(GET cppcheck PARENT_PATH cppcheck_dir)
file(GLOB cppcheck_runtimes ${cppcheck_dir}/*)
install(PROGRAMS ${cppcheck_runtimes}
        DESTINATION ${CMAKE_PROJECT_NAME}/Cppcheck)
install(DIRECTORY ${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/share/Cppcheck
        DESTINATION ${CMAKE_PROJECT_NAME})
