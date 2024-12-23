vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  danmar/cppcheck
  REF
  "${VERSION}"
  SHA512
  567eee377b04b3ed8d7ff10811d6ef07a68ae4726b33524c305a41ffd7e33e7d029822a5b91f95a473c328c927db3100e9d26ff7689b20ae9721de0b774b71e5
  HEAD_REF
  main)

vcpkg_replace_string("${SOURCE_PATH}/cmake/compilerDefinitions.cmake"
  [[-D_WIN64]]
  [[]]
)

if(VCPKG_TARGET_IS_LINUX)
    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86" OR VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
      message(STATUS "Disable automatic elf rpath fixup for ${VCPKG_TARGET_ARCHITECTURE} linux")
      set(VCPKG_FIXUP_ELF_RPATH OFF)
    endif()
endif()

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        have-rules                  HAVE_RULES
)

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    -DDISABLE_DMAKE=ON
    ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include"
     "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_copy_tools(TOOL_NAMES cppcheck AUTO_CLEAN)

set(VCPKG_POLICY_ALLOW_EMPTY_FOLDERS enabled)
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
