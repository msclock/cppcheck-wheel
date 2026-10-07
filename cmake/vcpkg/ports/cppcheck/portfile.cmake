vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  danmar/cppcheck
  REF
  "${VERSION}"
  SHA512
  aad4ed7f14b24d60896fe39f39a3b0bce1046a704ee27c914971792393e1bb128c13a1537632d6ae2eadd50fdcbd9396c59bbf5c98209400ae9d2f7d130224f9
  HEAD_REF
  main)

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

if(EXISTS "/etc/alpine-release")
  message(STATUS "No execinfo.h in muslc for alpine")
  set(NO_UNIX_BACKTRACE_SUPPORT ON)
endif()

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    -DDISABLE_DMAKE=ON
    -DNO_UNIX_BACKTRACE_SUPPORT=${NO_UNIX_BACKTRACE_SUPPORT}
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
set(VCPKG_POLICY_DLLS_IN_STATIC_LIBRARY enabled)
