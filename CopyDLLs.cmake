################################################################################
# File: CopyDLLs.cmake
# Created Date: 20 Dec 2021
# Author: Nicolas IRAGNE (nicolas.iragne@alyce.fr)
# -----
# Provides a macro to copy runtime DLLs from a target to its directory.
# -----
################################################################################

function(CopyDLLs TGT)
  add_custom_command(
    TARGET ${TGT}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_RUNTIME_DLLS:${TGT}>
            $<TARGET_FILE_DIR:${TGT}>
    COMMAND_EXPAND_LISTS)
endfunction()
