################################################################################
# File: FindTensorRT.cmake
# Created Date: 14 Dec 2021
# Author: Nicolas IRAGNE (nicolas.iragne@alyce.fr)
# -----
# Attempts to find TensorRT and its components (usually nvinfer).
# -----
################################################################################

function(create_target TARGET)
  find_library(
    ${TARGET}_LIBRARY
    NAMES ${TARGET}
    PATHS ${TensorRT_DIR}/lib)
  
  set(TARGET_FULL ${${TARGET}_LIBRARY})
  message(STATUS "Found ${TARGET} at ${TARGET_FULL}")
  string(FIND ${TARGET_FULL} "NOTFOUND" _VAR)
  if(${_VAR} EQUAL "-1")
    if (NOT TARGET trt::${TARGET})
      set(TensorRT_${TARGET}_FOUND TRUE CACHE STRING "1")
      get_filename_component(TARGET_FILE_NAME ${TARGET_FULL} NAME_WE)
      get_filename_component(TARGET_PATH ${TARGET_FULL} DIRECTORY)
      add_library(trt::${TARGET} SHARED IMPORTED)
      if(WIN32)
        set_target_properties(
          trt::${TARGET}
          PROPERTIES IMPORTED_LOCATION "${TARGET_PATH}/${TARGET_FILE_NAME}.dll"
                    IMPORTED_IMPLIB "${TARGET_PATH}/${TARGET_FILE_NAME}.lib"
                    INTERFACE_INCLUDE_DIRECTORIES "${TensorRT_DIR}/include")
      else()
        set_target_properties(trt::${TARGET} PROPERTIES IMPORTED_LOCATION "${TARGET_FULL}" INTERFACE_INCLUDE_DIRECTORIES
                                                                                          "${TensorRT_DIR}/include")
      endif(WIN32)
      install(IMPORTED_RUNTIME_ARTIFACTS trt::${TARGET} RUNTIME_DEPENDENCY_SET trt_set COMPONENT ${TARGET})
      message("Created target: trt::${TARGET}")
      set(TensorRT_${TARGET}_FOUND "TensorRT_${TARGET}_FOUND" CACHE INTERNAL "Found ${TARGET}")
    endif(NOT TARGET trt::${TARGET})
  else()
    set(TensorRT_${TARGET}_FOUND FALSE CACHE STRING "1")
    message("Library ${TARGET} not found!")
  endif()
endfunction()

function(create_targets)
  foreach(arg IN LISTS ARGN)
    create_target(${arg})
  endforeach()
endfunction()

message("Finding ${TensorRT_FIND_COMPONENTS}")
create_targets(${TensorRT_FIND_COMPONENTS})

install(
  RUNTIME_DEPENDENCY_SET
  trt_set
  PRE_EXCLUDE_REGEXES
  "api-ms-*"
  "ext-ms-*"
  POST_EXCLUDE_REGEXES
  ".*system32/.*\\.dll"
  DIRECTORIES
  ${CUDA_TOOLKIT_ROOT_DIR}/bin)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(TensorRT HANDLE_COMPONENTS)
