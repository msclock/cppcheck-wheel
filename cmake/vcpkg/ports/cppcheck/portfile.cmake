vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  danmar/cppcheck
  REF
  "${VERSION}"
  SHA512
  072179cf35f91708735a85966517b5788554c32443558865af64d782cfc082acd073219ab511f5e2f98bd8f1dc8c0d02447452a00f15524eda2ca20be6af8108
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
