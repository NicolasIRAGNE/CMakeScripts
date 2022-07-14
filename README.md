# CMakeScripts

- [CMakeScripts](#cmakescripts)
  - [Table of Contents](#table-of-contents)
  - [ccache.cmake](#ccachecmake)
  - [CopyDLLs.cmake](#copydllscmake)
  - [FetchIfMissing.cmake](#fetchifmissingcmake)
  - [FindTensorRT.cmake](#findtensorrtcmake)
- [Notes](#notes)
      - [Code Style](#code-style)
      - [Contributing](#contributing)

## [ccache.cmake](./ccache.cmake)

This module will attempt to use ccache as a compiler launcher. Simply including `ccache.cmake` is enough to use it.

This does not really work on windows, but it should work on linux. I will try to fix it in the future.

## [CopyDLLs.cmake](./CopyDLLs.cmake)

This module will provide a quick way to copy DLLs that a target depends on to the target's build directory.

*NB:* This module is usually not enough, as it uses CMake's `TARGET_RUNTIME_DLLS` generator expression, which is very dependent on how the DLL files were linked. As this is a fairly new CMake feature, most of the 3rd party libraries do not properly declare their dependencies.

## [FetchIfMissing.cmake](./FetchIfMissing.cmake)

This module provides a function to fetch a package from a remote server if it is
missing from the system.

Example usage:

```CMake
FetchIfMissing(json
   GIT_REPOSITORY https://github.com/NicolasIRAGNE/nlohmann_json_cmake_fetchcontent
   GIT_TAG nicolasiragne/interface
)
FetchIfMissing(SDL2
  GIT_REPOSITORY "https://github.com/libsdl-org/SDL/"
  GIT_TAG release-2.0.18
)
FetchContent_MakeAvailable(${FETCHED_TARGETS})
```

## [FindTensorRT.cmake](./FindTensorRT.cmake)

Attempts to find TensorRT and its components (usually nvinfer).
Example usage:

```CMake
Find_Package(TensorRT COMPONENTS nvinfer REQUIRED)
target_link_libraries(foo trt::nvinfer)
```

# Notes

#### Code Style

The code style is ass. This is a work in progress. I copied a bit of code from an old existing script which had inconsistent style and I'm too lazy to fix it. Too bad!

#### Contributing

If you use these scripts, please report any bugs or issues. I will try to fix them. If you want to contribute, please fork the repository and submit a pull request. If you want to send me pictures of monkeys, please send them to nicolas.iragne@alyce.fr.
