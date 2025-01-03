cmake_minimum_required(VERSION 3.25)
message(STATUS "CMAKE VERSION:${CMAKE_VERSION}")

project(
  cppcheck
  LANGUAGES CXX C
  HOMEPAGE_URL "https:///msclock/cppcheck-wheel"
  DESCRIPTION "Package cppcheck as a python wheel.")

# Project default module
find_package(cmake-modules REQUIRED)
include(cmake-modules/ProjectDefault)

<<<<<<< before updating
find_program(cppcheck NAMES "cppcheck" "cppcheck.exe")
cmake_path(GET cppcheck PARENT_PATH cppcheck_dir)
file(GLOB cppcheck_runtimes ${cppcheck_dir}/*)
install(PROGRAMS ${cppcheck_runtimes}
        DESTINATION ${SKBUILD_PROJECT_NAME}/Cppcheck)
install(DIRECTORY ${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/share/Cppcheck
        DESTINATION ${SKBUILD_PROJECT_NAME})
=======
# Project custom modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
>>>>>>> after updating
