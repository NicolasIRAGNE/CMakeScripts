################################################################################
# File: FetchIfMissing.cmake
# Created Date: 14 Dec 2021
# Author: Nicolas IRAGNE (nicolas.iragne@alyce.fr)
# -----
# This module provides a function to fetch a file from a remote server if it is
# missing in the system.
# For each dependency, it will define the following variables:
# - <dependency>_FETCHED if the file is not found and fetched
# If the dependency has been fetched, add it to the variable FETCHED_TARGETS.
# 
# A typical usage would be:
#
# FetchIfMissing(json
#    GIT_REPOSITORY https://github.com/NicolasIRAGNE/nlohmann_json_cmake_fetchcontent
#    GIT_TAG nicolasiragne/interface
# )
# FetchIfMissing(SDL2
#   GIT_REPOSITORY "https://github.com/libsdl-org/SDL/"
#   GIT_TAG release-2.0.18
# )
# FetchContent_MakeAvailable(${FETCHED_TARGETS})
# -----
################################################################################

include(FetchContent)
function(FetchIfMissing TARGET)
    option(${TARGET}_FETCH_IF_MISSING "Download and build ${TARGET} if not found in the system" ON)
    find_package(${TARGET} QUIET)

    if (NOT ${TARGET}_FOUND)
        if (NOT ${TARGET}_FETCH_IF_MISSING)
            message(FATAL_ERROR "${TARGET} not found! Set ${TARGET}_FETCH_IF_MISSING to true to download and build it.")
        endif()
        message(STATUS "${TARGET} not found in the system. Downloading...")
        FetchContent_Declare(${ARGV})
        if (NOT DEFINED ${TARGET}_FETCHED)
            set(${TARGET}_FETCHED ON CACHE INTERNAL "${TARGET} was fetched from an external url")
            set(FETCHED_TARGETS ${FETCHED_TARGETS} ${TARGET} CACHE INTERNAL "List of fetched targets")
        endif()
    else()
        message(STATUS "${TARGET} found in the system. Skipping...")
    endif()
endfunction()