#[[
SPDX-License-Identifier: MIT
SPDX-FileCopyrightText: Copyright 2023 Mikhail Svetkin
SPDX-FileCopyrightText: Copyright 2024 msclock
]]

include_guard(GLOBAL)

cmake_minimum_required(VERSION 3.25)

get_property(IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE)

if(IN_TRY_COMPILE)
  return()
endif()

unset(IN_TRY_COMPILE)

# Load the common settings
include(${CMAKE_CURRENT_LIST_DIR}/scripts/build_type.cmake)

include(${CMAKE_CURRENT_LIST_DIR}/bootstrap/vcpkg-config.cmake)

set(VCPKG_VERBOSE
    ON
    CACHE BOOL "Vcpkg VCPKG_VERBOSE")

file(READ ${CMAKE_SOURCE_DIR}/vcpkg.json _vcpkg_json)
string(JSON _builtin_baseline GET ${_vcpkg_json} builtin-baseline)
vcpkg_configure(CACHE_DIR_NAME cppcheck-wheel REF ${_builtin_baseline})

message(STATUS "CMAKE_CXX_COMPILER_TARGET: ${CMAKE_CXX_COMPILER_TARGET}")
message(STATUS "CMAKE_CXX_COMPILER: ${CMAKE_CXX_COMPILER}")
