include(vcpkg_common_functions)

if(NOT VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
  message(WARNING
    "You will need to also install https://raw.githubusercontent.com/unicode-org/cldr/master/common/supplemental/windowsZones.xml into your install location.\n"
    "See https://howardhinnant.github.io/date/tz.html"
  )
endif()

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO HowardHinnant/date
  REF c56f915cc3ab43543efff504cb2406260a543004
  SHA512 70dda716602ab67d72f9c8f5a74947edecbab8eab5ab564d127627bb4bdd042a293a6f6e83dc7176c4c17ae5ec11e83e8e942e9a139a929dce713c829ebb7a79
  HEAD_REF master
)


set(DATE_BUILD_SHARED_LIBS OFF)
if (VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
  set(DATE_BUILD_SHARED_LIBS ON)
endif()

set(DATE_USE_SYSTEM_TZ_DB 1)
if("remote-api" IN_LIST FEATURES)
  set(DATE_USE_SYSTEM_TZ_DB 0)
endif()

vcpkg_configure_cmake(
  SOURCE_PATH ${SOURCE_PATH}
  PREFER_NINJA
  OPTIONS
    -DBUILD_SHARED_LIBS=${DATE_BUILD_SHARED_LIBS}
    -DUSE_SYSTEM_TZ_DB=${DATE_USE_SYSTEM_TZ_DB}
    -DENABLE_DATE_TESTING=OFF
)

vcpkg_install_cmake()

if(NOT VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
  vcpkg_fixup_cmake_targets(CONFIG_PATH CMake TARGET_PATH share/date)
else()
  vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/date TARGET_PATH share/date)
endif()

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/date RENAME copyright)
